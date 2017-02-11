/* Создание типа объекта Влажности полевого журнала */

CREATE OR REPLACE TYPE TVL_JOURNAL_FIELD_OBJECT 
AS OBJECT
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
  VALUE_DRY FLOAT,
  ADJUSTMENT_DRY FLOAT,
  T_DRY FLOAT,
  VALUE_WET FLOAT,
  ADJUSTMENT_WET FLOAT,
  T_WET FLOAT,
  MOISTURE FLOAT  
)

--

/* Создание типа таблицы Влажности полевого журнала */

CREATE OR REPLACE TYPE TVL_JOURNAL_FIELD_TABLE 
AS TABLE OF TVL_JOURNAL_FIELD_OBJECT

--

/* Создание функции просмотра Влажности в полевом журнале */

CREATE OR REPLACE FUNCTION GET_TVL_JOURNAL_FIELDS
(
  IS_CLOSE INTEGER
)
RETURN TVL_JOURNAL_FIELD_TABLE
PIPELINED
IS
  INC2 TVL_JOURNAL_FIELD_OBJECT:=TVL_JOURNAL_FIELD_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                          NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_TVL_JOURNAL_FIELDS.IS_CLOSE) LOOP
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
                  AND JF.MEASURE_TYPE_ID=2660 /* Влажность */
                  AND JF.PARAM_ID IN (3101, /* Отсчет сухой */
                                      3104, /* Поправка сухая */
                                      3106, /* Т сухая */
                                      3102, /* Отсчет мокрый */
                                      3105, /* Поправка мокрая */
                                      3107, /* Т мокрая */
                                      3109 /* Влажность */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_TVL_JOURNAL_FIELDS.IS_CLOSE								  
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
	
	  IF (INC1.PARAM_ID=3101) THEN INC2.VALUE_DRY:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3104) THEN INC2.ADJUSTMENT_DRY:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3106) THEN INC2.T_DRY:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3102) THEN INC2.VALUE_WET:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3105) THEN INC2.ADJUSTMENT_WET:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3107) THEN INC2.T_WET:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3109) THEN INC2.MOISTURE:=INC1.VALUE; END IF;
	  						
	END IF;
	OLD_GROUP_ID:=INC1.GROUP_ID;
  END LOOP;
  IF (FLAG=1) THEN
    PIPE ROW (INC2);
  END IF;
  RETURN;
END;

--

/* Создание просмотра Влажности в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_TVL_JOURNAL_FIELDS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_TVL_JOURNAL_FIELDS(1))

--

/* Обновление просмотра Влажности в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_TVL_JOURNAL_FIELDS_O');
END;

--

/* Создание индекса на цикл просмотра Влажности в полевом журнале старых данных */

CREATE INDEX IDX_TVL_JF_O_1
 ON S_TVL_JOURNAL_FIELDS_O(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Влажности в полевом журнале старых данных */

CREATE INDEX IDX_TVL_JF_O_2
 ON S_TVL_JOURNAL_FIELDS_O(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Влажности в полевом журнале старых данных */

CREATE INDEX IDX_TVL_JF_O_3
 ON S_TVL_JOURNAL_FIELDS_O(MEASURE_TYPE_ID)

--

/* Создание просмотра Влажности в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_TVL_JOURNAL_FIELDS_N
AS
  SELECT * FROM TABLE(GET_TVL_JOURNAL_FIELDS(0))

--

/* Создание просмотра Влажности в полевом журнале */

CREATE OR REPLACE VIEW S_TVL_JOURNAL_FIELDS
AS
  SELECT JFO.*
    FROM S_TVL_JOURNAL_FIELDS_O JFO
   UNION
  SELECT JFN.*
    FROM S_TVL_JOURNAL_FIELDS_N JFN

--

/* Фиксация изменений БД */

COMMIT
