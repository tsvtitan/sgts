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
  PRESSURE_ACTIVE FLOAT,
  MARK_WATER FLOAT,
  PRESSURE_OPPOSE FLOAT,
  PRESSURE_BROUGHT FLOAT,
  OBJECT_PATHS VARCHAR2(1000),
  COORDINATE_Z FLOAT
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
                      JO.MEASURE_TYPE_ID,
                      JO.CYCLE_ID,
                      C.CYCLE_NUM,
                      JO.POINT_ID,
                      P.NAME AS POINT_NAME,
                      CR.CONVERTER_ID,
                      CR.NAME AS CONVERTER_NAME,
                      JO.GROUP_ID,
					  MIN(DECODE(JO.PARAM_ID,2960,JO.VALUE,NULL)) AS MARK_WATER,
					  MIN(DECODE(JO.PARAM_ID,2961,JO.VALUE,NULL)) AS PRESSURE_ACTIVE,
					  MIN(DECODE(JO.PARAM_ID,2962,JO.VALUE,NULL)) AS PRESSURE_OPPOSE,
					  MIN(DECODE(JO.PARAM_ID,2963,JO.VALUE,NULL)) AS PRESSURE_BROUGHT,
                      (SELECT TO_NUMBER(REPLACE(CP.VALUE,',','.'),'FM99999.9999') FROM CONVERTER_PASSPORTS CP, COMPONENTS CM 
                        WHERE CP.COMPONENT_ID=CM.COMPONENT_ID
                          AND CM.CONVERTER_ID=CR.CONVERTER_ID
                          AND CM.PARAM_ID=2940 /* Отметка оголовка */ ) AS MARK_HEAD,
                      OT.OBJECT_PATHS,
					  P.COORDINATE_Z					   
                 FROM JOURNAL_OBSERVATIONS JO, CYCLES C, POINTS P,
                      ROUTE_POINTS RP, CONVERTERS CR,
                      (SELECT OT1.OBJECT_ID, SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS
                         FROM OBJECT_TREES OT1, OBJECTS O1
                        WHERE OT1.OBJECT_ID=O1.OBJECT_ID
                        START WITH OT1.PARENT_ID IS NULL
                      CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID
					    GROUP BY OT1.OBJECT_ID) OT
                WHERE JO.CYCLE_ID=C.CYCLE_ID
                  AND JO.POINT_ID=P.POINT_ID
                  AND RP.POINT_ID=JO.POINT_ID
                  AND CR.CONVERTER_ID=P.POINT_ID
				  AND P.OBJECT_ID=OT.OBJECT_ID 
                  AND JO.MEASURE_TYPE_ID=GET_PZM_JOURNAL_OBSERVATIONS.MEASURE_TYPE_ID
                  AND JO.PARAM_ID IN (2960, /* Отметка уровня воды */
                                      2961, /* Действующий напор */
                                      2962, /* Фильтрационное противодавление */
                                      2963 /* Приведенный напор */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_PZM_JOURNAL_OBSERVATIONS.IS_CLOSE								  
                GROUP BY JO.DATE_OBSERVATION, JO.MEASURE_TYPE_ID, JO.CYCLE_ID, C.CYCLE_NUM, JO.POINT_ID, 
				         P.NAME, CR.CONVERTER_ID, CR.NAME, JO.GROUP_ID, RP.PRIORITY, CR.DATE_ENTER, 
						 OT.OBJECT_PATHS, P.COORDINATE_Z
                ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, RP.PRIORITY) LOOP
    INC2.CYCLE_ID:=INC1.CYCLE_ID;
    INC2.CYCLE_NUM:=INC1.CYCLE_NUM;
	INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION;
	INC2.MEASURE_TYPE_ID:=INC1.MEASURE_TYPE_ID;
	INC2.POINT_ID:=INC1.POINT_ID;
	INC2.POINT_NAME:=INC1.POINT_NAME;
	INC2.CONVERTER_ID:=INC1.CONVERTER_ID;
	INC2.CONVERTER_NAME:=INC1.CONVERTER_NAME;
	INC2.MARK_HEAD:=INC1.MARK_HEAD;
	INC2.MARK_WATER:=INC1.MARK_WATER;
	INC2.PRESSURE_ACTIVE:=INC1.PRESSURE_ACTIVE;
	INC2.PRESSURE_OPPOSE:=INC1.PRESSURE_OPPOSE;
	INC2.PRESSURE_BROUGHT:=INC1.PRESSURE_BROUGHT;
	INC2.OBJECT_PATHS:=INC1.OBJECT_PATHS;
	INC2.COORDINATE_Z:=INC1.COORDINATE_Z;
	
	PIPE ROW (INC2);  						
  END LOOP;
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

/* Обновление просмотра Веерных пьезометров в журнале наблюдений старых данных */

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

/* Обновление просмотра Створных пьезометров в журнале наблюдений старых данных */

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

/* Обновление просмотра Береговых пьезометров в журнале наблюдений старых данных */

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
