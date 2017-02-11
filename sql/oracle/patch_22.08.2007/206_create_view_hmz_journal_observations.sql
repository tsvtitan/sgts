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
  SECTION VARCHAR2(100),
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
  AGGRESSIV FLOAT
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
			               											  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
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
        INC2.MARK:=TO_NUMBER(REPLACE(INC.VALUE,',','.'),'FM999.999');
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
  	
	  IF (INC1.PARAM_ID=3060) THEN INC2.PH:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3061) THEN INC2.CO2SV:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3062) THEN INC2.CO3_2:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3063) THEN INC2.CO2AGG:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3065) THEN INC2.ALKALI:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3066) THEN INC2.ACERBITY:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3067) THEN INC2.CA:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3068) THEN INC2.MG:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3069) THEN INC2.CL:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3070) THEN INC2.SO4_2:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3071) THEN INC2.HCO3:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3072) THEN INC2.NA_K:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=3100) THEN INC2.AGGRESSIV:=INC1.VALUE; END IF;
	  						
	END IF;
	OLD_GROUP_ID:=INC1.GROUP_ID;
  END LOOP;
  IF (FLAG=1) THEN
    PIPE ROW (INC2);
  END IF;
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


/* Фиксация изменений БД */

COMMIT

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
