/* Создание типа объекта Одноосных щелемеров журнала наблюдений */

CREATE OR REPLACE TYPE SL1_JOURNAL_OBSERVATION_OBJECT AS OBJECT
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
  CURRENT_OPENING FLOAT,
  CYCLE_NULL_OPENING FLOAT
)

--

/* Создание типа таблицы Одноосных щелемеров журнала наблюдений */

CREATE OR REPLACE TYPE SL1_JOURNAL_OBSERVATION_TABLE 
AS TABLE OF SL1_JOURNAL_OBSERVATION_OBJECT

--

/* Создание функции просмотра Одноосных щелемеров в журнале наблюдений */

CREATE OR REPLACE FUNCTION GET_SL1_JOURNAL_OBSERVATIONS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN SL1_JOURNAL_OBSERVATION_TABLE
PIPELINED
IS
  INC2 SL1_JOURNAL_OBSERVATION_OBJECT:=SL1_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_SL1_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    
   
  FOR INC1 IN (SELECT /*+ INDEX (JO) INDEX (JF) INDEX (C) INDEX (P) INDEX (RP) INDEX (CR) */
                      JO.DATE_OBSERVATION, 
                      JO.MEASURE_TYPE_ID,
                      JO.CYCLE_ID,
                      C.CYCLE_NUM,
                      JO.POINT_ID,
                      P.NAME AS POINT_NAME,
                      CR.CONVERTER_ID,
                      CR.NAME AS CONVERTER_NAME,
                      JO.GROUP_ID,
                      MIN(DECODE(JO.PARAM_ID,30000,JO.VALUE,NULL)) AS VALUE,
 				      MIN(DECODE(JO.PARAM_ID,30002,JO.VALUE,NULL)) AS OPENING,
					  MIN(DECODE(JO.PARAM_ID,30031,JO.VALUE,NULL)) AS CURRENT_OPENING,
					  MIN(DECODE(JO.PARAM_ID,30034,JO.VALUE,NULL)) AS CYCLE_NULL_OPENING,
					  OT.OBJECT_PATHS,
					  P.COORDINATE_Z,
					  JF.JOURNAL_NUM
                 FROM JOURNAL_OBSERVATIONS JO, JOURNAL_FIELDS JF, CYCLES C, POINTS P,
                      ROUTE_POINTS RP, CONVERTERS CR,
                      (SELECT OT1.OBJECT_ID, SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS
                         FROM OBJECT_TREES OT1, OBJECTS O1
                        WHERE OT1.OBJECT_ID=O1.OBJECT_ID
                        START WITH OT1.PARENT_ID IS NULL
                      CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID
					    GROUP BY OT1.OBJECT_ID) OT
                WHERE JO.JOURNAL_FIELD_ID=JF.JOURNAL_FIELD_ID
				  AND JO.CYCLE_ID=C.CYCLE_ID
                  AND JO.POINT_ID=P.POINT_ID
                  AND RP.POINT_ID=JO.POINT_ID
                  AND CR.CONVERTER_ID=P.POINT_ID 
				  AND P.OBJECT_ID=OT.OBJECT_ID
                  AND JO.MEASURE_TYPE_ID=GET_SL1_JOURNAL_OBSERVATIONS.MEASURE_TYPE_ID
				  AND JF.MEASURE_TYPE_ID=JO.MEASURE_TYPE_ID
                  AND JO.PARAM_ID IN (30000, /* Отсчет */
                                      30002, /* Раскрытие с начала наблюдений */
                                      30031, /* Текущее раскрытие */
                                      30034 /* Раскрытие с нулевого цикла */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_SL1_JOURNAL_OBSERVATIONS.IS_CLOSE
                GROUP BY JO.DATE_OBSERVATION, JO.MEASURE_TYPE_ID, JO.CYCLE_ID, C.CYCLE_NUM, JO.POINT_ID, 
				         P.NAME, CR.CONVERTER_ID, CR.NAME, JO.GROUP_ID, RP.PRIORITY, CR.DATE_ENTER, 
						 OT.OBJECT_PATHS, P.COORDINATE_Z, JF.JOURNAL_NUM				  								  
                ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, RP.PRIORITY) LOOP
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
	INC2.CYCLE_NULL_OPENING:=INC1.CYCLE_NULL_OPENING;
	  						
    PIPE ROW (INC2);
  END LOOP;
  RETURN;
END;

--



/* Создание просмотра Межсекционные в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_OBSERVATIONS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30001,1))

--

/* Обновление просмотра Межсекционные в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание индекса на цикл просмотра Межсекционные в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O1_1
 ON S_SL1_JOURNAL_OBSERVATIONS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Межсекционные в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O1_2
 ON S_SL1_JOURNAL_OBSERVATIONS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Межсекционные в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O1_3
 ON S_SL1_JOURNAL_OBSERVATIONS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Межсекционные в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_N1
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30001,0))

--

/* Создание просмотра Межсекционные в журнале наблюдений */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_1
AS
  SELECT JOO1.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_O1 JOO1
   UNION
  SELECT JON1.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_N1 JON1

--



/* Создание просмотра Межстолбчатый в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_OBSERVATIONS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30002,1))

--

/* Обновление просмотра Межстолбчатый в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание индекса на цикл просмотра Межстолбчатый в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O2_1
 ON S_SL1_JOURNAL_OBSERVATIONS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Межстолбчатый в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O2_2
 ON S_SL1_JOURNAL_OBSERVATIONS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Межстолбчатый в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O2_3
 ON S_SL1_JOURNAL_OBSERVATIONS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Межстолбчатый в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_N2
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30002,0))

--

/* Создание просмотра Межстолбчатый в журнале наблюдений */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_2
AS
  SELECT JOO2.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_O2 JOO2
   UNION
  SELECT JON2.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_N2 JON2

--



/* Создание просмотра На трещине в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_OBSERVATIONS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30003,1))

--

/* Обновление просмотра На трещине в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Создание индекса на цикл просмотра На трещине в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O3_1
 ON S_SL1_JOURNAL_OBSERVATIONS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра На трещине в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O3_2
 ON S_SL1_JOURNAL_OBSERVATIONS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра На трещине в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O3_3
 ON S_SL1_JOURNAL_OBSERVATIONS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра На трещине в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_N3
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30003,0))

--

/* Создание просмотра На трещине в журнале наблюдений */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_3
AS
  SELECT JOO3.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_O3 JOO3
   UNION
  SELECT JON3.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_N3 JON3

--




/* Создание просмотра На основании плотины в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_OBSERVATIONS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30004,1))

--

/* Обновление просмотра На основании плотины в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_OBSERVATIONS_O4');
END;

--

/* Создание индекса на цикл просмотра На основании плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O4_1
 ON S_SL1_JOURNAL_OBSERVATIONS_O4(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра На основании плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O4_2
 ON S_SL1_JOURNAL_OBSERVATIONS_O4(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра На основании плотины в журнале наблюдений старых данных */

CREATE INDEX IDX_SL1_JO_O4_3
 ON S_SL1_JOURNAL_OBSERVATIONS_O4(MEASURE_TYPE_ID)

--

/* Создание просмотра На основании плотины в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_N4
AS
  SELECT * FROM TABLE(GET_SL1_JOURNAL_OBSERVATIONS(30004,0))

--

/* Создание просмотра На основании плотины в журнале наблюдений */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_4
AS
  SELECT JOO4.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_O4 JOO4
   UNION
  SELECT JON4.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_N4 JON4

--


/* Создание просмотра Одноосных щелемеров в журнале наблюдений */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS
AS
  SELECT JO1.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_1 JO1
   UNION
  SELECT JO2.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_2 JO2
   UNION
  SELECT JO3.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_3 JO3
   UNION
  SELECT JO4.*
    FROM S_SL1_JOURNAL_OBSERVATIONS_4 JO4


--


/* Фиксация изменений БД */

COMMIT
