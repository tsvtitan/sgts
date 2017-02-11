/* Создание типа объекта Химанализа журнала наблюдений */

CREATE OR REPLACE TYPE HMZ_JOURNAL_OBSERVATION_OBJECT AS OBJECT
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
  PH FLOAT,
  CO2SV FLOAT,
  CO3_2 FLOAT,
  CO2AGG FLOAT,
  ALKALI FLOAT,
  ACERBITY FLOAT,
  CA FLOAT,
  MG FLOAT,
  CL FLOAT,
  SO4_2 FLOAT,
  HCO3 FLOAT,
  NA_K FLOAT,
  AGGRESSIV FLOAT,
  OBJECT_PATHS VARCHAR2(1000),
  COORDINATE_Z FLOAT
)

--

/* Создание типа таблицы Химанализа журнала наблюдений */

CREATE OR REPLACE TYPE HMZ_JOURNAL_OBSERVATION_TABLE 
AS TABLE OF HMZ_JOURNAL_OBSERVATION_OBJECT

--

/* Создание функции просмотра Химанализа в журнале наблюдений */

CREATE OR REPLACE FUNCTION GET_HMZ_JOURNAL_OBSERVATIONS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN HMZ_JOURNAL_OBSERVATION_TABLE
PIPELINED
IS
  INC2 HMZ_JOURNAL_OBSERVATION_OBJECT:=HMZ_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
			               											  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_HMZ_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP
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
                      MIN(DECODE(JO.PARAM_ID,3060,JO.VALUE,NULL)) AS PH,
                      MIN(DECODE(JO.PARAM_ID,3061,JO.VALUE,NULL)) AS CO2SV,
                      MIN(DECODE(JO.PARAM_ID,3062,JO.VALUE,NULL)) AS CO3_2,
                      MIN(DECODE(JO.PARAM_ID,3063,JO.VALUE,NULL)) AS CO2AGG,
                      MIN(DECODE(JO.PARAM_ID,3065,JO.VALUE,NULL)) AS ALKALI,
                      MIN(DECODE(JO.PARAM_ID,3066,JO.VALUE,NULL)) AS ACERBITY,
                      MIN(DECODE(JO.PARAM_ID,3067,JO.VALUE,NULL)) AS CA,
                      MIN(DECODE(JO.PARAM_ID,3068,JO.VALUE,NULL)) AS MG,
                      MIN(DECODE(JO.PARAM_ID,3069,JO.VALUE,NULL)) AS CL,
                      MIN(DECODE(JO.PARAM_ID,3070,JO.VALUE,NULL)) AS SO4_2,
                      MIN(DECODE(JO.PARAM_ID,3071,JO.VALUE,NULL)) AS HCO3,
                      MIN(DECODE(JO.PARAM_ID,3072,JO.VALUE,NULL)) AS NA_K,
                      MIN(DECODE(JO.PARAM_ID,3100,JO.VALUE,NULL)) AS AGGRESSIV,
                      (SELECT TO_NUMBER(REPLACE(CP.VALUE,',','.'),'FM99999.9999') FROM CONVERTER_PASSPORTS CP, COMPONENTS CM 
                        WHERE CP.COMPONENT_ID=CM.COMPONENT_ID
                          AND CM.CONVERTER_ID=CR.CONVERTER_ID
                          AND CM.PARAM_ID=3002 /* Отметка галереи */) AS MARK,
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
                  AND JO.MEASURE_TYPE_ID=GET_HMZ_JOURNAL_OBSERVATIONS.MEASURE_TYPE_ID
                  AND JO.PARAM_ID IN (3060, /* pH */
                                      3061, /* CO2 св */
                                      3062, /* CO3(-2) */
                                      3063, /* CO2 агр */
                                      3065, /* Щелочность */
                                      3066, /* Жесткость */
                                      3067, /* Ca(+) */
                                      3068, /* Mg(+) */
                                      3069, /* Cl(-) */
                                      3070, /* SO4(-2) */
                                      3071, /* HCO3(-) */
                                      3072, /* Na(+)+K(+) */
                                      3100 /* Агрессивность */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_HMZ_JOURNAL_OBSERVATIONS.IS_CLOSE
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
	INC2.MARK:=INC1.MARK;
	INC2.PH:=INC1.PH;
	INC2.CO2SV:=INC1.CO2SV;
	INC2.CO3_2:=INC1.CO3_2;
	INC2.CO2AGG:=INC1.CO2AGG;
	INC2.ALKALI:=INC1.ALKALI;
	INC2.ACERBITY:=INC1.ACERBITY;
	INC2.CA:=INC1.CA;
	INC2.MG:=INC1.MG;
	INC2.CL:=INC1.CL;
	INC2.SO4_2:=INC1.SO4_2;
	INC2.HCO3:=INC1.HCO3;
	INC2.NA_K:=INC1.NA_K;
	INC2.AGGRESSIV:=INC1.AGGRESSIV;
    INC2.OBJECT_PATHS:=INC1.OBJECT_PATHS;
    INC2.COORDINATE_Z:=INC1.COORDINATE_Z;

    PIPE ROW (INC2);
  END LOOP;
  RETURN;
END;
 
--



/* Создание просмотра Химанализа в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2600,1))

--

/* Обновление просмотра Химанализа в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O');
END;

--

/* Создание индекса на цикл просмотра Химанализа в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O_1
 ON S_HMZ_JOURNAL_OBSERVATIONS_O(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Химанализа в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O_2
 ON S_HMZ_JOURNAL_OBSERVATIONS_O(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Химанализа в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O_3
 ON S_HMZ_JOURNAL_OBSERVATIONS_O(MEASURE_TYPE_ID)

--

/* Создание просмотра Химанализа в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_N
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2600,0))

--

/* Создание просмотра Химанализа в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS
AS
  SELECT JOO.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_O JOO
   UNION
  SELECT JON.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_N JON

--



/* Фиксация изменений БД */

COMMIT
