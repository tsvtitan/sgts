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



/* Создание просмотра Дренажи осн. 1го ряда в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2602,1))

--

/* Обновление просмотра Дренажи осн. 1го ряда в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание индекса на цикл просмотра Дренажи осн. 1го ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O1_1
 ON S_HMZ_JOURNAL_OBSERVATIONS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажи осн. 1го ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O1_2
 ON S_HMZ_JOURNAL_OBSERVATIONS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажи осн. 1го ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O1_3
 ON S_HMZ_JOURNAL_OBSERVATIONS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажи осн. 1го ряда в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_N1
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2602,0))

--

/* Создание просмотра Дренажи осн. 1го ряда в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_1
AS
  SELECT JOO1.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_O1 JOO1
   UNION
  SELECT JON1.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_N1 JON1

--



/* Создание просмотра Дренажи осн. 2го ряда в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2601,1))

--

/* Обновление просмотра Дренажи осн. 2го ряда в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание индекса на цикл просмотра Дренажи осн. 2го ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O2_1
 ON S_HMZ_JOURNAL_OBSERVATIONS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажи осн. 2го ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O2_2
 ON S_HMZ_JOURNAL_OBSERVATIONS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажи осн. 2го ряда в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O2_3
 ON S_HMZ_JOURNAL_OBSERVATIONS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажи осн. 2го ряда в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_N2
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2601,0))

--

/* Создание просмотра Дренажи осн. 2го ряда в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_2
AS
  SELECT JOO2.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_O2 JOO2
   UNION
  SELECT JON2.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_N2 JON2

--



/* Создание просмотра Веерные пьезометры в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2603,1))

--

/* Обновление просмотра Веерные пьезометры в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Создание индекса на цикл просмотра Веерные пьезометры в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O3_1
 ON S_HMZ_JOURNAL_OBSERVATIONS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Веерные пьезометры в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O3_2
 ON S_HMZ_JOURNAL_OBSERVATIONS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Веерные пьезометры в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O3_3
 ON S_HMZ_JOURNAL_OBSERVATIONS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра Веерные пьезометры в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_N3
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2603,0))

--

/* Создание просмотра Веерные пьезометры в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_3
AS
  SELECT JOO3.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_O3 JOO3
   UNION
  SELECT JON3.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_N3 JON3

--




/* Создание просмотра Дренажи бетона и швы в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2604,1))

--

/* Обновление просмотра Дренажи бетона и швы в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O4');
END;

--

/* Создание индекса на цикл просмотра Дренажи бетона и швы в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O4_1
 ON S_HMZ_JOURNAL_OBSERVATIONS_O4(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажи бетона и швы в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O4_2
 ON S_HMZ_JOURNAL_OBSERVATIONS_O4(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажи бетона и швы в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O4_3
 ON S_HMZ_JOURNAL_OBSERVATIONS_O4(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажи бетона и швы в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_N4
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2604,0))

--

/* Создание просмотра Дренажи бетона и швы в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_4
AS
  SELECT JOO4.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_O4 JOO4
   UNION
  SELECT JON4.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_N4 JON4

--



/* Создание просмотра Верхний бъеф в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O5
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2607,1))

--

/* Обновление просмотра Верхний бъеф в журнале наблюдений старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O5');
END;

--

/* Создание индекса на цикл просмотра Верхний бъеф в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O5_1
 ON S_HMZ_JOURNAL_OBSERVATIONS_O5(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Верхний бъеф в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O5_2
 ON S_HMZ_JOURNAL_OBSERVATIONS_O5(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Верхний бъеф в журнале наблюдений старых данных */

CREATE INDEX IDX_HMZ_JO_O5_3
 ON S_HMZ_JOURNAL_OBSERVATIONS_O5(MEASURE_TYPE_ID)

--

/* Создание просмотра Верхний бъеф в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_N5
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_OBSERVATIONS(2607,0))

--

/* Создание просмотра Верхний бъеф в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_5
AS
  SELECT JOO5.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_O5 JOO5
   UNION
  SELECT JON5.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_N5 JON5

--



/* Создание просмотра Химанализа в журнале наблюдений */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS
AS
  SELECT JO1.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_1 JO1
   UNION
  SELECT JO2.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_2 JO2
   UNION
  SELECT JO3.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_3 JO3
   UNION
  SELECT JO4.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_4 JO4
   UNION
  SELECT JO5.*
    FROM S_HMZ_JOURNAL_OBSERVATIONS_5 JO5


--


/* Фиксация изменений БД */

COMMIT
