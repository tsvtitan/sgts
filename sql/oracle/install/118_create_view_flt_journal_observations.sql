/* Создание типа объекта Фильтрация журнала наблюдений */

CREATE OR REPLACE TYPE FLT_JOURNAL_OBSERVATION_OBJECT AS OBJECT
(
  CYCLE_ID INTEGER,
  CYCLE_NUM INTEGER,
  JOURNAL_NUM VARCHAR2(100),
  DATE_OBSERVATION DATE,
  MEASURE_TYPE_ID INTEGER,
  POINT_ID INTEGER,
  POINT_NAME INTEGER,
  CONVERTER_ID INTEGER,
  CONVERTER_NAME VARCHAR2(100),
  MARK FLOAT,
  SECTION VARCHAR2(100),
  VOLUME FLOAT,
  TIME FLOAT,
  EXPENSE FLOAT,
  T_WATER FLOAT
)

--

/* Создание типа таблицы Фильтрации журнала наблюдений */

CREATE OR REPLACE TYPE FLT_JOURNAL_OBSERVATION_TABLE 
AS TABLE OF FLT_JOURNAL_OBSERVATION_OBJECT

--

/* Создание функции просмотра Фильтрации в журнале наблюдений */

CREATE OR REPLACE FUNCTION GET_FLT_JOURNAL_OBSERVATIONS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN FLT_JOURNAL_OBSERVATION_TABLE
PIPELINED
IS
  INC2 FLT_JOURNAL_OBSERVATION_OBJECT:=FLT_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_FLT_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP
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
                  AND JO.MEASURE_TYPE_ID=GET_FLT_JOURNAL_OBSERVATIONS.MEASURE_TYPE_ID
                  AND JO.PARAM_ID IN (3040, /* Замеренный объем */
                                      3041, /* Время замера */
                                      3042, /* Расход */
                                      3082 /* Т воды 2 */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_FLT_JOURNAL_OBSERVATIONS.IS_CLOSE								  
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
	
      INC2.MARK:=0;
      FOR INC IN (SELECT CP.VALUE,
   	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=INC1.CONVERTER_ID
                     AND C.PARAM_ID=3002 /* Отметка галереи */
                   ORDER BY CP.DATE_BEGIN) LOOP
        INC2.MARK:=TO_NUMBER(REPLACE(INC.VALUE,',','.'),'FM99999.9999');
  	    EXIT WHEN (INC1.DATE_OBSERVATION>=INC.DATE_BEGIN) AND (INC1.DATE_OBSERVATION<=INC.DATE_END);
      END LOOP;
  	
      INC2.SECTION:='';
      FOR INC IN (SELECT CP.VALUE,
   	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=INC1.CONVERTER_ID
                     AND C.PARAM_ID=3003 /* Секция плотины */
                   ORDER BY CP.DATE_BEGIN) LOOP
        INC2.SECTION:=INC.VALUE;
  	    EXIT WHEN (INC1.DATE_OBSERVATION>=INC.DATE_BEGIN) AND (INC1.DATE_OBSERVATION<=INC.DATE_END);
      END LOOP;
  	
	  IF (INC1.PARAM_ID=3040) THEN INC2.VOLUME:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3041) THEN INC2.TIME:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3042) THEN INC2.EXPENSE:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3082) THEN INC2.T_WATER:=INC1.VALUE; END IF;
	  						
	END IF;
	OLD_GROUP_ID:=INC1.GROUP_ID;
  END LOOP;
  IF (FLAG=1) THEN
    PIPE ROW (INC2);
  END IF;
  RETURN;
END;

--



/* Создание просмотра Через бетон НГ плотины в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2582,1))

--

/* Обновление просмотра Через бетон НГ плотины в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание индекса на цикл просмотра Через бетон НГ плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O1_1
 ON S_FLT_JOURNAL_OBSERVATIONS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Через бетон НГ плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O1_2
 ON S_FLT_JOURNAL_OBSERVATIONS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Через бетон НГ плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O1_3
 ON S_FLT_JOURNAL_OBSERVATIONS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Через бетон НГ плотины в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_N1
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2582,0))

--

/* Создание просмотра Через бетон НГ плотины в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_1
AS
  SELECT JOO1.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_O1 JOO1
   UNION
  SELECT JON1.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_N1 JON1

--



/* Создание просмотра Через швы НГ плотины в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2583,1))

--

/* Обновление просмотра Через швы НГ плотины в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание индекса на цикл просмотра Через швы НГ плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O2_1
 ON S_FLT_JOURNAL_OBSERVATIONS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Через швы НГ плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O2_2
 ON S_FLT_JOURNAL_OBSERVATIONS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Через швы НГ плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O2_3
 ON S_FLT_JOURNAL_OBSERVATIONS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Через швы НГ плотины в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_N2
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2583,0))

--

/* Создание просмотра Через швы НГ плотины в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_2
AS
  SELECT JOO2.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_O2 JOO2
   UNION
  SELECT JON2.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_N2 JON2

--



/* Создание просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2581,1))

--

/* Обновление просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Создание индекса на цикл просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O3_1
 ON S_FLT_JOURNAL_OBSERVATIONS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O3_2
 ON S_FLT_JOURNAL_OBSERVATIONS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O3_3
 ON S_FLT_JOURNAL_OBSERVATIONS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_N3
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2581,0))

--

/* Создание просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_3
AS
  SELECT JOO3.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_O3 JOO3
   UNION
  SELECT JON3.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_N3 JON3

--




/* Создание просмотра Через агрегатные швы в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2584,1))

--

/* Обновление просмотра Через агрегатные швы в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O4');
END;

--

/* Создание индекса на цикл просмотра Через агрегатные швы в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O4_1
 ON S_FLT_JOURNAL_OBSERVATIONS_O4(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Через агрегатные швы в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O4_2
 ON S_FLT_JOURNAL_OBSERVATIONS_O4(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Через агрегатные швы в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O4_3
 ON S_FLT_JOURNAL_OBSERVATIONS_O4(MEASURE_TYPE_ID)

--

/* Создание просмотра Через агрегатные швы в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_N4
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2584,0))

--

/* Создание просмотра Через агрегатные швы в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_4
AS
  SELECT JOO4.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_O4 JOO4
   UNION
  SELECT JON4.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_N4 JON4

--



/* Создание просмотра Автоном. источн. и водосливы в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O5
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2585,1))

--

/* Обновление просмотра Автоном. источн. и водосливы в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O5');
END;

--

/* Создание индекса на цикл просмотра Автоном. источн. и водосливы в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O5_1
 ON S_FLT_JOURNAL_OBSERVATIONS_O5(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Автоном. источн. и водосливы в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O5_2
 ON S_FLT_JOURNAL_OBSERVATIONS_O5(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Автоном. источн. и водосливы в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O5_3
 ON S_FLT_JOURNAL_OBSERVATIONS_O5(MEASURE_TYPE_ID)

--

/* Создание просмотра Автоном. источн. и водосливы в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_N5
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2585,0))

--

/* Создание просмотра Автоном. источн. и водосливы в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_5
AS
  SELECT JOO5.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_O5 JOO5
   UNION
  SELECT JON5.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_N5 JON5

--



/* Создание просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O6
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2626,1))

--

/* Обновление просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O6');
END;

--

/* Создание индекса на цикл просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O6_1
 ON S_FLT_JOURNAL_OBSERVATIONS_O6(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O6_2
 ON S_FLT_JOURNAL_OBSERVATIONS_O6(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_FLT_JO_O6_3
 ON S_FLT_JOURNAL_OBSERVATIONS_O6(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_N6
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2626,0))

--

/* Создание просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS_6
AS
  SELECT JOO6.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_O6 JOO6
   UNION
  SELECT JON6.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_N6 JON6

--



/* Создание просмотра Фильтрации в журнале наблюдений */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_OBSERVATIONS
AS
  SELECT JO1.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_1 JO1
   UNION
  SELECT JO2.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_2 JO2
   UNION
  SELECT JO3.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_3 JO3
   UNION
  SELECT JO4.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_4 JO4
   UNION
  SELECT JO5.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_5 JO5
   UNION
  SELECT JO6.*
    FROM S_FLT_JOURNAL_OBSERVATIONS_6 JO6



--


/* Фиксация изменений БД */

COMMIT
