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
														  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
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



/* Создание просмотра Дренажи осн. 1го ряда в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2602,1))

--

/* Обновление просмотра Дренажи осн. 1го ряда в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O1');
END;

--

/* Создание индекса на цикл просмотра Дренажи осн. 1го ряда в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O1_1
 ON S_HMZ_JOURNAL_FIELDS_O1(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажи осн. 1го ряда в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O1_2
 ON S_HMZ_JOURNAL_FIELDS_O1(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажи осн. 1го ряда в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O1_3
 ON S_HMZ_JOURNAL_FIELDS_O1(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажи осн. 1го ряда в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N1
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2602,0))

--

/* Создание просмотра Дренажи осн. 1го ряда в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_1
AS
  SELECT JFO1.*
    FROM S_HMZ_JOURNAL_FIELDS_O1 JFO1
   UNION
  SELECT JFN1.*
    FROM S_HMZ_JOURNAL_FIELDS_N1 JFN1

--



/* Создание просмотра Дренажи осн. 2го ряда в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2601,1))

--

/* Обновление просмотра Дренажи осн. 2го ряда в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O2');
END;

--

/* Создание индекса на цикл просмотра Дренажи осн. 2го ряда в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O2_1
 ON S_HMZ_JOURNAL_FIELDS_O2(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажи осн. 2го ряда в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O2_2
 ON S_HMZ_JOURNAL_FIELDS_O2(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажи осн. 2го ряда в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O2_3
 ON S_HMZ_JOURNAL_FIELDS_O2(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажи осн. 2го ряда в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N2
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2601,0))

--

/* Создание просмотра Дренажи осн. 2го ряда в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_2
AS
  SELECT JFO2.*
    FROM S_HMZ_JOURNAL_FIELDS_O2 JFO2
   UNION
  SELECT JFN2.*
    FROM S_HMZ_JOURNAL_FIELDS_N2 JFN2

--



/* Создание просмотра Веерные пьезометры в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2603,1))

--

/* Обновление просмотра Веерные пьезометры в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O3');
END;

--

/* Создание индекса на цикл просмотра Веерные пьезометры в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O3_1
 ON S_HMZ_JOURNAL_FIELDS_O3(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Веерные пьезометры в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O3_2
 ON S_HMZ_JOURNAL_FIELDS_O3(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Веерные пьезометры в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O3_3
 ON S_HMZ_JOURNAL_FIELDS_O3(MEASURE_TYPE_ID)

--

/* Создание просмотра Веерные пьезометры в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N3
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2603,0))

--

/* Создание просмотра Веерные пьезометры в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_3
AS
  SELECT JFO3.*
    FROM S_HMZ_JOURNAL_FIELDS_O3 JFO3
   UNION
  SELECT JFN3.*
    FROM S_HMZ_JOURNAL_FIELDS_N3 JFN3

--




/* Создание просмотра Дренажи бетона и швы в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2604,1))

--

/* Обновление просмотра Дренажи бетона и швы в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O4');
END;

--

/* Создание индекса на цикл просмотра Дренажи бетона и швы в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O4_1
 ON S_HMZ_JOURNAL_FIELDS_O4(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Дренажи бетона и швы в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O4_2
 ON S_HMZ_JOURNAL_FIELDS_O4(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Дренажи бетона и швы в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O4_3
 ON S_HMZ_JOURNAL_FIELDS_O4(MEASURE_TYPE_ID)

--

/* Создание просмотра Дренажи бетона и швы в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N4
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2604,0))

--

/* Создание просмотра Дренажи бетона и швы в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_4
AS
  SELECT JFO4.*
    FROM S_HMZ_JOURNAL_FIELDS_O4 JFO4
   UNION
  SELECT JFN4.*
    FROM S_HMZ_JOURNAL_FIELDS_N4 JFN4

--



/* Создание просмотра Верхний бъеф в полевом журнале старых данных */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O5
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2607,1))

--

/* Обновление просмотра Верхний бъеф в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O5');
END;

--

/* Создание индекса на цикл просмотра Верхний бъеф в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O5_1
 ON S_HMZ_JOURNAL_FIELDS_O5(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Верхний бъеф в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O5_2
 ON S_HMZ_JOURNAL_FIELDS_O5(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения просмотра Верхний бъеф в полевом журнале старых данных */

CREATE INDEX IDX_HMZ_JF_O5_3
 ON S_HMZ_JOURNAL_FIELDS_O5(MEASURE_TYPE_ID)

--

/* Создание просмотра Верхний бъеф в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N5
AS
  SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2607,0))

--

/* Создание просмотра Верхний бъеф в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_5
AS
  SELECT JFO5.*
    FROM S_HMZ_JOURNAL_FIELDS_O5 JFO5
   UNION
  SELECT JFN5.*
    FROM S_HMZ_JOURNAL_FIELDS_N5 JFN5

--



/* Создание просмотра Химанализа в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS
AS
  SELECT JF1.*
    FROM S_HMZ_JOURNAL_FIELDS_1 JF1
   UNION
  SELECT JF2.*
    FROM S_HMZ_JOURNAL_FIELDS_2 JF2
   UNION
  SELECT JF3.*
    FROM S_HMZ_JOURNAL_FIELDS_3 JF3
   UNION
  SELECT JF4.*
    FROM S_HMZ_JOURNAL_FIELDS_4 JF4
   UNION
  SELECT JF5.*
    FROM S_HMZ_JOURNAL_FIELDS_5 JF5


--


/* Фиксация изменений БД */

COMMIT
