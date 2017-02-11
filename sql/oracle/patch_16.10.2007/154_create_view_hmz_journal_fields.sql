/* Создание типа объекта Химанализа полевого журнала */

CREATE OR REPLACE TYPE HMZ_JOURNAL_FIELD_OBJECT AS OBJECT
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

/* Создание типа таблицы Химанализа полевого журнала */

CREATE OR REPLACE TYPE HMZ_JOURNAL_FIELD_TABLE 
AS TABLE OF HMZ_JOURNAL_FIELD_OBJECT

--

/* Создание функции просмотра Химанализа в полевом журнале */

CREATE OR REPLACE FUNCTION GET_HMZ_JOURNAL_FIELDS
(
  MEASURE_TYPE_ID INTEGER,
  IS_CLOSE INTEGER
)
RETURN HMZ_JOURNAL_FIELD_TABLE
PIPELINED
IS
  INC2 HMZ_JOURNAL_FIELD_OBJECT:=HMZ_JOURNAL_FIELD_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                          NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
														  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_HMZ_JOURNAL_FIELDS.IS_CLOSE) LOOP
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
                      MIN(DECODE(JF.PARAM_ID,3060,JF.VALUE,NULL)) AS PH,
                      MIN(DECODE(JF.PARAM_ID,3061,JF.VALUE,NULL)) AS CO2SV,
                      MIN(DECODE(JF.PARAM_ID,3062,JF.VALUE,NULL)) AS CO3_2,
                      MIN(DECODE(JF.PARAM_ID,3063,JF.VALUE,NULL)) AS CO2AGG,
                      MIN(DECODE(JF.PARAM_ID,3065,JF.VALUE,NULL)) AS ALKALI,
                      MIN(DECODE(JF.PARAM_ID,3066,JF.VALUE,NULL)) AS ACERBITY,
                      MIN(DECODE(JF.PARAM_ID,3067,JF.VALUE,NULL)) AS CA,
                      MIN(DECODE(JF.PARAM_ID,3068,JF.VALUE,NULL)) AS MG,
                      MIN(DECODE(JF.PARAM_ID,3069,JF.VALUE,NULL)) AS CL,
                      MIN(DECODE(JF.PARAM_ID,3070,JF.VALUE,NULL)) AS SO4_2,
                      MIN(DECODE(JF.PARAM_ID,3071,JF.VALUE,NULL)) AS HCO3,
                      MIN(DECODE(JF.PARAM_ID,3072,JF.VALUE,NULL)) AS NA_K,
                      MIN(DECODE(JF.PARAM_ID,3100,JF.VALUE,NULL)) AS AGGRESSIV,
                      (SELECT TO_NUMBER(REPLACE(CP.VALUE,',','.'),'FM99999.9999') FROM CONVERTER_PASSPORTS CP, COMPONENTS CM 
                        WHERE CP.COMPONENT_ID=CM.COMPONENT_ID
                          AND CM.CONVERTER_ID=CR.CONVERTER_ID
                          AND CM.PARAM_ID=3002 /* Отметка галереи */) AS MARK,
					  OT.OBJECT_PATHS,
					  P.COORDINATE_Z
 
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
                  AND JF.MEASURE_TYPE_ID=GET_HMZ_JOURNAL_FIELDS.MEASURE_TYPE_ID
                  AND JF.PARAM_ID IN (3060, /* pH */
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
				  AND C.IS_CLOSE=GET_HMZ_JOURNAL_FIELDS.IS_CLOSE
                GROUP BY JF.DATE_OBSERVATION, JF.MEASURE_TYPE_ID, JF.CYCLE_ID, C.CYCLE_NUM, JF.POINT_ID, 
				         P.NAME, CR.CONVERTER_ID, CR.NAME, JF.GROUP_ID, RP.PRIORITY, CR.DATE_ENTER, 
						 OT.OBJECT_PATHS, P.COORDINATE_Z
                ORDER BY JF.DATE_OBSERVATION, JF.GROUP_ID, RP.PRIORITY) LOOP
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



/* Создание просмотра Химанализа в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2600,1))

--

/* Обновление просмотра Химанализа в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O');
END;

--

/* Создание индекса на цикл просмотра Химанализа в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O_1
 ON S_HMZ_JOURNAL_FIELDS_O(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Химанализа в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O_2
 ON S_HMZ_JOURNAL_FIELDS_O(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Химанализа в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O_3
 ON S_HMZ_JOURNAL_FIELDS_O(MEASURE_TYPE_ID)

--

/* Создание просмотра Химанализа в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2600,0))

--

/* Создание просмотра Химанализа в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS
AS
  SELECT JFO.*
    FROM S_HMZ_JOURNAL_FIELDS_O JFO
   UNION
  SELECT JFN.*
    FROM S_HMZ_JOURNAL_FIELDS_N JFN

--

/* Фиксация изменений БД */

COMMIT
