/* Создание типа объекта Фильтрация полевого журнала */

CREATE OR REPLACE TYPE FLT_JOURNAL_FIELD_OBJECT AS OBJECT
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

/* Создание типа таблицы Фильтрации полевого журнала */

CREATE OR REPLACE TYPE FLT_JOURNAL_FIELD_TABLE 
AS TABLE OF FLT_JOURNAL_FIELD_OBJECT

--

/* Создание функции просмотра Фильтрации в полевом журнале */

CREATE OR REPLACE FUNCTION GET_FLT_JOURNAL_FIELDS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN FLT_JOURNAL_FIELD_TABLE
PIPELINED
IS
  INC2 FLT_JOURNAL_FIELD_OBJECT:=FLT_JOURNAL_FIELD_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                          NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_FLT_JOURNAL_FIELDS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    
   
  FOR INC1 IN (SELECT /*+ INDEX (JF) INDEX (C) INDEX (P) INDEX (RP) INDEX (CR) */
                      JF.DATE_OBSERVATION, 
                      JF.VALUE, 
                      JF.MEASURE_TYPE_ID,
                      JF.CYCLE_ID,
                      C.CYCLE_NUM,
                      JF.POINT_ID,
                      P.NAME AS POINT_NAME,
                      CR.CONVERTER_ID,
                      CR.NAME AS CONVERTER_NAME,
                      JF.GROUP_ID,
                      JF.PARAM_ID 
                 FROM JOURNAL_FIELDS JF, CYCLES C, POINTS P,
                      ROUTE_POINTS RP, CONVERTERS CR
                WHERE JF.CYCLE_ID=C.CYCLE_ID
                  AND JF.POINT_ID=P.POINT_ID
                  AND RP.POINT_ID=JF.POINT_ID
                  AND CR.CONVERTER_ID=P.POINT_ID 
                  AND JF.MEASURE_TYPE_ID=GET_FLT_JOURNAL_FIELDS.MEASURE_TYPE_ID
                  AND JF.PARAM_ID IN (3040, /* Замеренный объем */
                                      3041, /* Время замера */
                                      3042, /* Расход */
                                      3082 /* Т воды 2 */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_FLT_JOURNAL_FIELDS.IS_CLOSE								  
                ORDER BY JF.DATE_OBSERVATION, JF.GROUP_ID, RP.PRIORITY) LOOP
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



/* Создание просмотра Через бетон НГ плотины в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2582,1))

--

/* Обновление просмотра Через бетон НГ плотины в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O1');
END;

--

/* Создание индекса на цикл просмотра Через бетон НГ плотины в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O1_1
 ON S_FLT_JOURNAL_FIELDS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Через бетон НГ плотины в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O1_2
 ON S_FLT_JOURNAL_FIELDS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Через бетон НГ плотины в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O1_3
 ON S_FLT_JOURNAL_FIELDS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Через бетон НГ плотины в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N1
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2582,0))

--

/* Создание просмотра Через бетон НГ плотины в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_1
AS
  SELECT JFO1.*
    FROM S_FLT_JOURNAL_FIELDS_O1 JFO1
   UNION
  SELECT JFN1.*
    FROM S_FLT_JOURNAL_FIELDS_N1 JFN1

--



/* Создание просмотра Через швы НГ плотины в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2583,1))

--

/* Обновление просмотра Через швы НГ плотины в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O2');
END;

--

/* Создание индекса на цикл просмотра Через швы НГ плотины в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O2_1
 ON S_FLT_JOURNAL_FIELDS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Через швы НГ плотины в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O2_2
 ON S_FLT_JOURNAL_FIELDS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Через швы НГ плотины в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O2_3
 ON S_FLT_JOURNAL_FIELDS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Через швы НГ плотины в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N2
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2583,0))

--

/* Создание просмотра Через швы НГ плотины в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_2
AS
  SELECT JFO2.*
    FROM S_FLT_JOURNAL_FIELDS_O2 JFO2
   UNION
  SELECT JFN2.*
    FROM S_FLT_JOURNAL_FIELDS_N2 JFN2

--



/* Создание просмотра Дренажа осн. плотины 1 ряда в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2581,1))

--

/* Обновление просмотра Дренажа осн. плотины 1 ряда в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O3');
END;

--

/* Создание индекса на цикл просмотра Дренажа осн. плотины 1 ряда в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O3_1
 ON S_FLT_JOURNAL_FIELDS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажа осн. плотины 1 ряда в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O3_2
 ON S_FLT_JOURNAL_FIELDS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажа осн. плотины 1 ряда в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O3_3
 ON S_FLT_JOURNAL_FIELDS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажа осн. плотины 1 ряда в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N3
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2581,0))

--

/* Создание просмотра Дренажа осн. плотины 1 ряда в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_3
AS
  SELECT JFO3.*
    FROM S_FLT_JOURNAL_FIELDS_O3 JFO3
   UNION
  SELECT JFN3.*
    FROM S_FLT_JOURNAL_FIELDS_N3 JFN3

--




/* Создание просмотра Через агрегатные швы в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2584,1))

--

/* Обновление просмотра Через агрегатные швы в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O4');
END;

--

/* Создание индекса на цикл просмотра Через агрегатные швы в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O4_1
 ON S_FLT_JOURNAL_FIELDS_O4(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Через агрегатные швы в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O4_2
 ON S_FLT_JOURNAL_FIELDS_O4(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Через агрегатные швы в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O4_3
 ON S_FLT_JOURNAL_FIELDS_O4(MEASURE_TYPE_ID)

--

/* Создание просмотра Через агрегатные швы в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N4
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2584,0))

--

/* Создание просмотра Через агрегатные швы в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_4
AS
  SELECT JFO4.*
    FROM S_FLT_JOURNAL_FIELDS_O4 JFO4
   UNION
  SELECT JFN4.*
    FROM S_FLT_JOURNAL_FIELDS_N4 JFN4

--



/* Создание просмотра Автоном. источн. и водосливы в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O5
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2585,1))

--

/* Обновление просмотра Автоном. источн. и водосливы в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O5');
END;

--

/* Создание индекса на цикл просмотра Автоном. источн. и водосливы в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O5_1
 ON S_FLT_JOURNAL_FIELDS_O5(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Автоном. источн. и водосливы в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O5_2
 ON S_FLT_JOURNAL_FIELDS_O5(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Автоном. источн. и водосливы в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O5_3
 ON S_FLT_JOURNAL_FIELDS_O5(MEASURE_TYPE_ID)

--

/* Создание просмотра Автоном. источн. и водосливы в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N5
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2585,0))

--

/* Создание просмотра Автоном. источн. и водосливы в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_5
AS
  SELECT JFO5.*
    FROM S_FLT_JOURNAL_FIELDS_O5 JFO5
   UNION
  SELECT JFN5.*
    FROM S_FLT_JOURNAL_FIELDS_N5 JFN5

--



/* Создание просмотра Дренажа осн. плотины 2 ряда в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O6
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2626,1))

--

/* Обновление просмотра Дренажа осн. плотины 2 ряда в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O6');
END;

--

/* Создание индекса на цикл просмотра Дренажа осн. плотины 2 ряда в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O6_1
 ON S_FLT_JOURNAL_FIELDS_O6(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажа осн. плотины 2 ряда в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O6_2
 ON S_FLT_JOURNAL_FIELDS_O6(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажа осн. плотины 2 ряда в полевом журнале старых данных */

CREATE INDEX IDX_FLT_JF_O6_3
 ON S_FLT_JOURNAL_FIELDS_O6(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажа осн. плотины 2 ряда в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N6
AS
  SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2626,0))

--

/* Создание просмотра Дренажа осн. плотины 2 ряда в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_6
AS
  SELECT JFO6.*
    FROM S_FLT_JOURNAL_FIELDS_O6 JFO6
   UNION
  SELECT JFN6.*
    FROM S_FLT_JOURNAL_FIELDS_N6 JFN6

--


/* Создание просмотра Фильтрации в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS
AS
  SELECT JF1.*
    FROM S_FLT_JOURNAL_FIELDS_1 JF1
   UNION
  SELECT JF2.*
    FROM S_FLT_JOURNAL_FIELDS_2 JF2
   UNION
  SELECT JF3.*
    FROM S_FLT_JOURNAL_FIELDS_3 JF3
   UNION
  SELECT JF4.*
    FROM S_FLT_JOURNAL_FIELDS_4 JF4
   UNION
  SELECT JF5.*
    FROM S_FLT_JOURNAL_FIELDS_5 JF5
   UNION
  SELECT JF6.*
    FROM S_FLT_JOURNAL_FIELDS_6 JF6



--


/* Фиксация изменений БД */

COMMIT
