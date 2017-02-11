/* Создание типа объекта Пьезометров полевого журнала */

CREATE OR REPLACE TYPE PZM_JOURNAL_FIELD_OBJECT AS OBJECT
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
  INSTRUMENT_ID INTEGER,
  INSTRUMENT_NAME VARCHAR2(100),
  VALUE FLOAT
)

--

/* Создание типа таблицы Пьезометров полевого журнала */

CREATE OR REPLACE TYPE PZM_JOURNAL_FIELD_TABLE 
AS TABLE OF PZM_JOURNAL_FIELD_OBJECT

--

/* Создание функции просмотра Пьезометров в полевом журнале */

CREATE OR REPLACE FUNCTION GET_PZM_JOURNAL_FIELDS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN PZM_JOURNAL_FIELD_TABLE
PIPELINED
IS
  INC2 PZM_JOURNAL_FIELD_OBJECT:=PZM_JOURNAL_FIELD_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_PZM_JOURNAL_FIELDS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    

  FOR INC1 IN (SELECT /*+ INDEX (JF) INDEX (C) INDEX (P) INDEX (RP) INDEX (I) INDEX (CR) */
                      JF.DATE_OBSERVATION, 
                      JF.VALUE, 
                      JF.MEASURE_TYPE_ID,
                      JF.JOURNAL_NUM,
                      JF.CYCLE_ID,
                      C.CYCLE_NUM,
                      JF.POINT_ID,
                      P.NAME AS POINT_NAME,
                      JF.INSTRUMENT_ID,
                      I.NAME AS INSTRUMENT_NAME,
                      CR.CONVERTER_ID,
                      CR.NAME AS CONVERTER_NAME 
                 FROM JOURNAL_FIELDS JF, CYCLES C, POINTS P,
                      ROUTE_POINTS RP, INSTRUMENTS I, CONVERTERS CR
                WHERE JF.CYCLE_ID=C.CYCLE_ID
                  AND JF.POINT_ID=P.POINT_ID
                  AND RP.POINT_ID=JF.POINT_ID
                  AND I.INSTRUMENT_ID=JF.INSTRUMENT_ID 
                  AND CR.CONVERTER_ID=P.POINT_ID 
                  AND JF.MEASURE_TYPE_ID=GET_PZM_JOURNAL_FIELDS.MEASURE_TYPE_ID
                  AND JF.PARAM_ID=2920 /* Отсчет пьезометра */
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
                  AND C.IS_CLOSE=GET_PZM_JOURNAL_FIELDS.IS_CLOSE	
                ORDER BY JF.DATE_OBSERVATION, RP.PRIORITY) LOOP
    INC2.CYCLE_ID:=INC1.CYCLE_ID;
    INC2.CYCLE_NUM:=INC1.CYCLE_NUM;
	INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION;
	INC2.MEASURE_TYPE_ID:=INC1.MEASURE_TYPE_ID;
	INC2.JOURNAL_NUM:=INC1.JOURNAL_NUM;
    INC2.POINT_ID:=INC1.POINT_ID;
    INC2.POINT_NAME:=INC1.POINT_NAME;
    INC2.CONVERTER_ID:=INC1.CONVERTER_ID;
	INC2.CONVERTER_NAME:=INC1.CONVERTER_NAME;
	INC2.INSTRUMENT_ID:=INC1.INSTRUMENT_ID;
	INC2.INSTRUMENT_NAME:=INC1.INSTRUMENT_NAME;
    INC2.VALUE:=INC1.VALUE;
	
    PIPE ROW (INC2);
  END LOOP;
  RETURN;
END;

--



/* Создание просмотра Веерных пьезометров в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2561,1))

--

/* Обновление просмотра Веерных пьезометров в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O1');
END;

--

/* Создание индекса на цикл просмотра Веерных пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O1_1
 ON S_PZM_JOURNAL_FIELDS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Веерных пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O1_2
 ON S_PZM_JOURNAL_FIELDS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Веерных пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O1_3
 ON S_PZM_JOURNAL_FIELDS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Веерных пьезометров в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_N1
AS
  SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2561,0))

--

/* Создание просмотра Веерных пьезометров в полевом журнале */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_1
AS
  SELECT JFO1.*
    FROM S_PZM_JOURNAL_FIELDS_O1 JFO1
   UNION
  SELECT JFN1.*
    FROM S_PZM_JOURNAL_FIELDS_N1 JFN1

--



/* Создание просмотра Створных пьезометров в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2562,1))

--

/* Обновление просмотра Створных пьезометров в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O2');
END;

--

/* Создание индекса на цикл просмотра Створных пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O2_1
 ON S_PZM_JOURNAL_FIELDS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Створных пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O2_2
 ON S_PZM_JOURNAL_FIELDS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Створных пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O2_3
 ON S_PZM_JOURNAL_FIELDS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Створных пьезометров в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_N2
AS
  SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2562,0))

--

/* Создание просмотра Створных пьезометров в полевом журнале */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_2
AS
  SELECT JFO2.*
    FROM S_PZM_JOURNAL_FIELDS_O2 JFO2
   UNION
  SELECT JFN2.*
    FROM S_PZM_JOURNAL_FIELDS_N2 JFN2

--


/* Создание просмотра Береговых пьезометров в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2563,1))

--

/* Обновление просмотра Береговых пьезометров в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O3');
END;

--

/* Создание индекса на цикл просмотра Береговых пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O3_1
 ON S_PZM_JOURNAL_FIELDS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Береговых пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O3_2
 ON S_PZM_JOURNAL_FIELDS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Береговых пьезометров в полевом журнале старых данных */

CREATE INDEX IDX_PZM_JF_O3_3
 ON S_PZM_JOURNAL_FIELDS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра Береговых пьезометров в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_N3
AS
  SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2563,0))

--

/* Создание просмотра Береговых пьезометров в полевом журнале */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_3
AS
  SELECT JFO3.*
    FROM S_PZM_JOURNAL_FIELDS_O3 JFO3
   UNION
  SELECT JFN3.*
    FROM S_PZM_JOURNAL_FIELDS_N3 JFN3

--


/* Создание просмотра Всех пьезометров в полевом журнале */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS
AS
  SELECT JF1.*
    FROM S_PZM_JOURNAL_FIELDS_1 JF1
   UNION
  SELECT JF2.*
    FROM S_PZM_JOURNAL_FIELDS_2 JF2
   UNION
  SELECT JF3.*
    FROM S_PZM_JOURNAL_FIELDS_3 JF3

--


/* Фиксация изменений БД */

COMMIT
