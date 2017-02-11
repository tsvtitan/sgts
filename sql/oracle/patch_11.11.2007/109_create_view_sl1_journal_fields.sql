/* Создание типа объекта Одноосные щелемеры полевого журнала */

CREATE OR REPLACE TYPE SL1_JOURNAL_FIELD_OBJECT AS OBJECT
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
  OBJECT_PATHS VARCHAR2(1000),
  COORDINATE_Z FLOAT,
  VALUE FLOAT,
  OPENING FLOAT,
  CURRENT_OPENING FLOAT
)

--

/* Создание типа таблицы Одноосные щелемеры полевого журнала */

CREATE OR REPLACE TYPE SL1_JOURNAL_FIELD_TABLE 
AS TABLE OF SL1_JOURNAL_FIELD_OBJECT

--

/* Создание функции просмотра Одноосные щелемеры в полевом журнале */

CREATE OR REPLACE FUNCTION GET_SL1_JOURNAL_FIELDS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN SL1_JOURNAL_FIELD_TABLE
PIPELINED
IS
  INC2 SL1_JOURNAL_FIELD_OBJECT:=SL1_JOURNAL_FIELD_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                          NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_SL1_JOURNAL_FIELDS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    
   
  FOR INC1 IN (SELECT /*+ INDEX (JF) INDEX (C) INDEX (P) INDEX (RP) INDEX (CR) */
                      JF.DATE_OBSERVATION, 
                      JF.MEASURE_TYPE_ID,
                      JF.CYCLE_ID,
                      C.CYCLE_NUM,
                      JF.POINT_ID,
                      P.NAME AS POINT_NAME,
                      CR.CONVERTER_ID,
                      CR.NAME AS CONVERTER_NAME,
                      JF.GROUP_ID,
					  MIN(DECODE(JF.PARAM_ID,30000,JF.VALUE,NULL)) AS VALUE,
					  MIN(DECODE(JF.PARAM_ID,30002,JF.VALUE,NULL)) AS OPENING,
					  MIN(DECODE(JF.PARAM_ID,30031,JF.VALUE,NULL)) AS CURRENT_OPENING,
					  OT.OBJECT_PATHS,
					  P.COORDINATE_Z,
					  JF.JOURNAL_NUM
                 FROM JOURNAL_FIELDS JF, CYCLES C, POINTS P,
                      ROUTE_POINTS RP, CONVERTERS CR,
                      (SELECT OT1.OBJECT_ID, SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS
                         FROM OBJECT_TREES OT1, OBJECTS O1
                        WHERE OT1.OBJECT_ID=O1.OBJECT_ID
                        START WITH OT1.PARENT_ID IS NULL
                      CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID
					    GROUP BY OT1.OBJECT_ID) OT
                WHERE JF.CYCLE_ID=C.CYCLE_ID
                  AND JF.POINT_ID=P.POINT_ID
                  AND RP.POINT_ID=JF.POINT_ID
                  AND CR.CONVERTER_ID=P.POINT_ID
				  AND P.OBJECT_ID=OT.OBJECT_ID 
                  AND JF.MEASURE_TYPE_ID=GET_SL1_JOURNAL_FIELDS.MEASURE_TYPE_ID
                  AND JF.PARAM_ID IN (30000, /* Отсчет */
                                      30002, /* Раскрытие с начала наблюдений */
                                      30031 /* Текущее раскрытие */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
 				  AND C.IS_CLOSE=GET_SL1_JOURNAL_FIELDS.IS_CLOSE								  
                GROUP BY JF.DATE_OBSERVATION, JF.MEASURE_TYPE_ID, JF.CYCLE_ID, C.CYCLE_NUM, JF.POINT_ID, 
				         P.NAME, CR.CONVERTER_ID, CR.NAME, JF.GROUP_ID, RP.PRIORITY, CR.DATE_ENTER, 
						 OT.OBJECT_PATHS, P.COORDINATE_Z, JF.JOURNAL_NUM
                ORDER BY JF.DATE_OBSERVATION, JF.GROUP_ID, RP.PRIORITY) LOOP
    INC2.CYCLE_ID:=INC1.CYCLE_ID;
    INC2.CYCLE_NUM:=INC1.CYCLE_NUM;
    INC2.JOURNAL_NUM:=INC1.JOURNAL_NUM;
	INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION;
	INC2.MEASURE_TYPE_ID:=INC1.MEASURE_TYPE_ID;
	INC2.POINT_ID:=INC1.POINT_ID;
	INC2.POINT_NAME:=INC1.POINT_NAME;
	INC2.CONVERTER_ID:=INC1.CONVERTER_ID;
	INC2.CONVERTER_NAME:=INC1.CONVERTER_NAME;
    INC2.OBJECT_PATHS:=INC1.OBJECT_PATHS;
    INC2.COORDINATE_Z:=INC1.COORDINATE_Z;
	INC2.VALUE:=INC1.VALUE;
	INC2.OPENING:=INC1.OPENING;
	INC2.CURRENT_OPENING:=INC1.CURRENT_OPENING;
	
    PIPE ROW (INC2);
  END LOOP;
  RETURN;
END;

--


/* Создание просмотра Межсекционные в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_FIELDS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30001,1))

--

/* Обновление просмотра Межсекционные в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O1');
END;

--

/* Создание индекса на цикл просмотра Межсекционные в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O1_1
 ON S_SL1_JOURNAL_FIELDS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Межсекционные в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O1_2
 ON S_SL1_JOURNAL_FIELDS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Межсекционные в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O1_3
 ON S_SL1_JOURNAL_FIELDS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Межсекционные в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_N1
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30001,0))

--

/* Создание просмотра Межсекционные в полевом журнале */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_1
AS
  SELECT JFO1.*
    FROM S_SL1_JOURNAL_FIELDS_O1 JFO1
   UNION
  SELECT JFN1.*
    FROM S_SL1_JOURNAL_FIELDS_N1 JFN1

--



/* Создание просмотра Межстолбчатый в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30002,1))

--

/* Обновление просмотра Межстолбчатый в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O2');
END;

--

/* Создание индекса на цикл просмотра Межстолбчатый в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O2_1
 ON S_SL1_JOURNAL_FIELDS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Межстолбчатый в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O2_2
 ON S_SL1_JOURNAL_FIELDS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Межстолбчатый в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O2_3
 ON S_SL1_JOURNAL_FIELDS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Межстолбчатый в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_N2
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30002,0))

--

/* Создание просмотра Межстолбчатый в полевом журнале */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_2
AS
  SELECT JFO2.*
    FROM S_SL1_JOURNAL_FIELDS_O2 JFO2
   UNION
  SELECT JFN2.*
    FROM S_SL1_JOURNAL_FIELDS_N2 JFN2

--



/* Создание просмотра На трещине в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_FIELDS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30003,1))

--

/* Обновление просмотра На трещине в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O3');
END;

--

/* Создание индекса на цикл просмотра На трещине в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O3_1
 ON S_SL1_JOURNAL_FIELDS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра На трещине в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O3_2
 ON S_SL1_JOURNAL_FIELDS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра На трещине в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O3_3
 ON S_SL1_JOURNAL_FIELDS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра На трещине в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_N3
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30003,0))

--

/* Создание просмотра На трещине в полевом журнале */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_3
AS
  SELECT JFO3.*
    FROM S_SL1_JOURNAL_FIELDS_O3 JFO3
   UNION
  SELECT JFN3.*
    FROM S_SL1_JOURNAL_FIELDS_N3 JFN3

--




/* Создание просмотра На основании плотины в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_FIELDS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30004,1))

--

/* Обновление просмотра На основании плотины в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O4');
END;

--

/* Создание индекса на цикл просмотра На основании плотины в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O4_1
 ON S_SL1_JOURNAL_FIELDS_O4(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра На основании плотины в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O4_2
 ON S_SL1_JOURNAL_FIELDS_O4(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра На основании плотины в полевом журнале старых данных */

CREATE INDEX IDX_SL1_JF_O4_3
 ON S_SL1_JOURNAL_FIELDS_O4(MEASURE_TYPE_ID)

--

/* Создание просмотра На основании плотины в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_N4
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30004,0))

--

/* Создание просмотра На основании плотины в полевом журнале */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_4
AS
  SELECT JFO4.*
    FROM S_SL1_JOURNAL_FIELDS_O4 JFO4
   UNION
  SELECT JFN4.*
    FROM S_SL1_JOURNAL_FIELDS_N4 JFN4

--


/* Создание просмотра Одноосных щелемеров в полевом журнале */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS
AS
  SELECT JF1.*
    FROM S_SL1_JOURNAL_FIELDS_1 JF1
   UNION
  SELECT JF2.*
    FROM S_SL1_JOURNAL_FIELDS_2 JF2
   UNION
  SELECT JF3.*
    FROM S_SL1_JOURNAL_FIELDS_3 JF3
   UNION
  SELECT JF4.*
    FROM S_SL1_JOURNAL_FIELDS_4 JF4


--


/* Фиксация изменений БД */

COMMIT
