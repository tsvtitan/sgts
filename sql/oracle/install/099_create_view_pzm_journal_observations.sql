/* Создание типа объекта Пьезометров журнала наблюдений */

CREATE OR REPLACE TYPE PZM_JOURNAL_OBSERVATION_OBJECT AS OBJECT
(
  CYCLE_ID INTEGER,
  CYCLE_NUM INTEGER,
  DATE_OBSERVATION DATE,
  MEASURE_TYPE_ID INTEGER,
  POINT_ID INTEGER,
  POINT_NAME INTEGER,
  CONVERTER_ID INTEGER,
  CONVERTER_NAME VARCHAR2(100),
  MARK_HEAD FLOAT,
  SECTION VARCHAR2(100),
  POLE INTEGER,
  PRESSURE_ACTIVE FLOAT,
  MARK_WATER FLOAT,
  PRESSURE_OPPOSE FLOAT,
  PRESSURE_BROUGHT FLOAT
)

--

/* Создание типа таблицы Пьезометров журнала наблюдений */

CREATE OR REPLACE TYPE PZM_JOURNAL_OBSERVATION_TABLE 
AS TABLE OF PZM_JOURNAL_OBSERVATION_OBJECT

--

/* Создание функции просмотра Пьезометров в журнале наблюдений */

CREATE OR REPLACE FUNCTION GET_PZM_JOURNAL_OBSERVATIONS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN PZM_JOURNAL_OBSERVATION_TABLE
PIPELINED
IS
  INC2 PZM_JOURNAL_OBSERVATION_OBJECT:=PZM_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                                      NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_PZM_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    
   
  FOR INC1 IN (SELECT /*+ INDEX (JO) INDEX (C) INDEX (P) INDEX (RP) INDEX (CR) */
                      JO.DATE_OBSERVATION, 
                      JO.VALUE, 
                      JO.MEASURE_TYPE_ID,
                      JO.CYCLE_ID,
                      C.CYCLE_NUM,
                      JO.POINT_ID,
                      P.NAME AS POINT_NAME,
                      CR.CONVERTER_ID,
                      CR.NAME AS CONVERTER_NAME,
                      JO.GROUP_ID,
                      JO.PARAM_ID 
                 FROM JOURNAL_OBSERVATIONS JO, CYCLES C, POINTS P,
                      ROUTE_POINTS RP, CONVERTERS CR
                WHERE JO.CYCLE_ID=C.CYCLE_ID
                  AND JO.POINT_ID=P.POINT_ID
                  AND RP.POINT_ID=JO.POINT_ID
                  AND CR.CONVERTER_ID=P.POINT_ID 
                  AND JO.MEASURE_TYPE_ID=GET_PZM_JOURNAL_OBSERVATIONS.MEASURE_TYPE_ID
                  AND JO.PARAM_ID IN (2960, /* Отметка уровня воды */
                                      2961, /* Действующий напор */
                                      2962, /* Фильтрационное противодавление */
                                      2963 /* Приведенный напор */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_PZM_JOURNAL_OBSERVATIONS.IS_CLOSE								  
               ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, RP.PRIORITY) LOOP
    IF (FLAG=0) THEN
	  OLD_GROUP_ID:=INC1.GROUP_ID;
	  FLAG:=1;
	END IF;
    IF (OLD_GROUP_ID<>INC1.GROUP_ID) THEN
	  OLD_GROUP_ID:=INC1.GROUP_ID;
	  PIPE ROW (INC2); 
	END IF;
    INC2.CYCLE_ID:=INC1.CYCLE_ID;
    INC2.CYCLE_NUM:=INC1.CYCLE_NUM;
	INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION;
	INC2.MEASURE_TYPE_ID:=INC1.MEASURE_TYPE_ID;
	INC2.POINT_ID:=INC1.POINT_ID;
	INC2.POINT_NAME:=INC1.POINT_NAME;
	INC2.CONVERTER_ID:=INC1.CONVERTER_ID;
	INC2.CONVERTER_NAME:=INC1.CONVERTER_NAME;
	
	IF (OLD_GROUP_ID=INC1.GROUP_ID) THEN
	
      INC2.MARK_HEAD:=0;
      FOR INC IN (SELECT CP.VALUE,
   	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=INC1.CONVERTER_ID
                     AND C.PARAM_ID=2940 /* Отметка оголовка */
                   ORDER BY CP.DATE_BEGIN) LOOP
        INC2.MARK_HEAD:=TO_NUMBER(REPLACE(INC.VALUE,',','.'),'FM99999.9999');
  	    EXIT WHEN (INC1.DATE_OBSERVATION>=INC.DATE_BEGIN) AND (INC1.DATE_OBSERVATION<=INC.DATE_END);
      END LOOP;
  	
      INC2.SECTION:=0;
      FOR INC IN (SELECT CP.VALUE,
   	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=INC1.CONVERTER_ID
                     AND C.PARAM_ID=2941 /* Секция оголовка */
                   ORDER BY CP.DATE_BEGIN) LOOP
        INC2.SECTION:=INC.VALUE;
  	    EXIT WHEN (INC1.DATE_OBSERVATION>=INC.DATE_BEGIN) AND (INC1.DATE_OBSERVATION<=INC.DATE_END);
      END LOOP;
  	
      INC2.POLE:=0;
      FOR INC IN (SELECT CP.VALUE,
   	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=INC1.CONVERTER_ID
                     AND C.PARAM_ID=2942 /* Столб пьезометра */
                   ORDER BY CP.DATE_BEGIN) LOOP
        INC2.POLE:=TO_NUMBER(REPLACE(INC.VALUE,',','.'),'FM99999.9999');
  	    EXIT WHEN (INC1.DATE_OBSERVATION>=INC.DATE_BEGIN) AND (INC1.DATE_OBSERVATION<=INC.DATE_END);
      END LOOP;
	
	  IF (INC1.PARAM_ID=2960) THEN INC2.MARK_WATER:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2961) THEN INC2.PRESSURE_ACTIVE:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2962) THEN INC2.PRESSURE_OPPOSE:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2963) THEN INC2.PRESSURE_BROUGHT:=INC1.VALUE; END IF;
	  						
	END IF;
	OLD_GROUP_ID:=INC1.GROUP_ID;
  END LOOP;
  IF (FLAG=1) THEN
    PIPE ROW (INC2);
  END IF;
  RETURN;
END;

--



/* Создание просмотра Веерных пьезометров в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2561,1))

--

/* Обновление просмотра Веерных пьезометров в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание индекса на цикл просмотра Веерных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O1_1
 ON S_PZM_JOURNAL_OBSERVATIONS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Веерных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O1_2
 ON S_PZM_JOURNAL_OBSERVATIONS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Веерных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O1_3
 ON S_PZM_JOURNAL_OBSERVATIONS_O1(MEASURE_TYPE_ID)

--

/* Создание индекса на точку просмотра Веерных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O1_4
 ON S_PZM_JOURNAL_OBSERVATIONS_O1(POINT_ID)

--

/* Создание индекса на преобразователь просмотра Веерных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O1_5
 ON S_PZM_JOURNAL_OBSERVATIONS_O1(CONVERTER_ID)

--

/* Создание просмотра Веерных пьезометров в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_N1
AS
  SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2561,0))

--

/* Создание просмотра Веерных пьезометров в журнале наблюдений */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_1
AS
  SELECT JOO1.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_O1 JOO1
   UNION
  SELECT JON1.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_N1 JON1

--




/* Создание просмотра Створных пьезометров в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2562,1))

--

/* Обновление просмотра Створных пьезометров в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание индекса на цикл просмотра Створных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O2_1
 ON S_PZM_JOURNAL_OBSERVATIONS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Створных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O2_2
 ON S_PZM_JOURNAL_OBSERVATIONS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Створных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O2_3
 ON S_PZM_JOURNAL_OBSERVATIONS_O2(MEASURE_TYPE_ID)

--

/* Создание индекса на точку просмотра Створных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O2_4
 ON S_PZM_JOURNAL_OBSERVATIONS_O2(POINT_ID)

--

/* Создание индекса на преобразователь просмотра Створных пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O2_5
 ON S_PZM_JOURNAL_OBSERVATIONS_O2(CONVERTER_ID)

--

/* Создание просмотра Створных пьезометров в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_N2
AS
  SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2562,0))

--

/* Создание просмотра Створных пьезометров в журнале наблюдений */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_2
AS
  SELECT JOO2.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_O2 JOO2
   UNION
  SELECT JON2.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_N2 JON2

--


/* Создание просмотра Береговых пьезометров в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2563,1))

--

/* Обновление просмотра Береговых пьезометров в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Создание индекса на цикл просмотра Береговых пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O3_1
 ON S_PZM_JOURNAL_OBSERVATIONS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Береговых пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O3_2
 ON S_PZM_JOURNAL_OBSERVATIONS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Береговых пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O3_3
 ON S_PZM_JOURNAL_OBSERVATIONS_O3(MEASURE_TYPE_ID)

--

/* Создание индекса на точку просмотра Береговых пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O3_4
 ON S_PZM_JOURNAL_OBSERVATIONS_O3(POINT_ID)

--

/* Создание индекса на преобразователь просмотра Береговых пьезометров в журнале наблюдений старых данных */

CREATE INDEX IDX_PZM_JO_O3_5
 ON S_PZM_JOURNAL_OBSERVATIONS_O3(CONVERTER_ID)

--

/* Создание просмотра Береговых пьезометров в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_N3
AS
  SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2563,0))

--

/* Создание просмотра Береговых пьезометров в журнале наблюдений */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_3
AS
  SELECT JOO3.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_O3 JOO3
   UNION
  SELECT JON3.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_N3 JON3

--

/* Создание просмотра Всех пьезометров в журнале наблюдений */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS
AS
  SELECT JO1.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_1 JO1
   UNION
  SELECT JO2.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_2 JO2
   UNION
  SELECT JO3.*
    FROM S_PZM_JOURNAL_OBSERVATIONS_3 JO3

--

/* Фиксация изменений БД */

COMMIT
