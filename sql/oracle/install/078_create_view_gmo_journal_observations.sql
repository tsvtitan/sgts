/* Создание типа объекта Гидрометеорологии журнала наблюдений */

CREATE OR REPLACE TYPE GMO_JOURNAL_OBSERVATION_OBJECT AS OBJECT
(
  CYCLE_ID INTEGER,
  CYCLE_NUM INTEGER,
  DATE_OBSERVATION DATE,
  MEASURE_TYPE_ID INTEGER,
  POINT_ID INTEGER,
  UVB FLOAT,
  UNB FLOAT,
  T_AIR FLOAT,
  T_WATER FLOAT,
  RAIN_DAY FLOAT,
  PREC FLOAT,
  UNSET FLOAT,
  INFLUX FLOAT,
  V_VAULT FLOAT,
  UVB_INC FLOAT,
  RAIN_YEAR FLOAT,
  T_AIR_10 FLOAT,
  T_AIR_30 FLOAT  
)

--

/* Создание типа таблицы Гидрометеорологии журнала наблюдений */

CREATE OR REPLACE TYPE GMO_JOURNAL_OBSERVATION_TABLE 
AS TABLE OF GMO_JOURNAL_OBSERVATION_OBJECT

--

/* Создание функции просмотра Гидрометеорологии в журнале наблюдений */

CREATE OR REPLACE FUNCTION GET_GMO_JOURNAL_OBSERVATIONS
(
  IS_CLOSE INTEGER
)
RETURN GMO_JOURNAL_OBSERVATION_TABLE
PIPELINED
IS
  INC2 GMO_JOURNAL_OBSERVATION_OBJECT:=GMO_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_GMO_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    
   
  FOR INC1 IN (SELECT /*+ INDEX (JO) INDEX (C) */
                      JO.PARAM_ID, 
                      JO.DATE_OBSERVATION, 
                      JO.VALUE, 
                      JO.GROUP_ID,
                      JO.MEASURE_TYPE_ID,
					  JO.POINT_ID,
                      C.CYCLE_NUM,
                      JO.CYCLE_ID  
                FROM JOURNAL_OBSERVATIONS JO, CYCLES C
               WHERE JO.CYCLE_ID=C.CYCLE_ID
                 AND JO.MEASURE_TYPE_ID=2520 /* Гидрометеорология  */
                 AND JO.PARAM_ID IN (2900 /* УВБ */,
			                         2901 /* УНБ */,
                                     2902 /* T воды */,
                                     2903 /* T воздуха */,
                                     2904 /* Сброс */,
                                     2905 /* Приток */,
                                     2906 /* Объем водохранилища */,
                                     2907 /* Осадков за сутки */,
                                     2908 /* Вид осадков */,
                                     2912 /* Приращение УВБ */,
                                     2910 /* Осадков с начала года */,
                                     2909 /* Т воздуха за 10 суток */,
                                     2913 /* Т воздуха за 30 суток */)
                 AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
                 AND C.IS_CLOSE=GET_GMO_JOURNAL_OBSERVATIONS.IS_CLOSE								  
               ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, JO.PRIORITY, JO.PARAM_ID) LOOP
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
	IF (OLD_GROUP_ID=INC1.GROUP_ID) THEN
	  IF (INC1.PARAM_ID=2900) THEN INC2.UVB:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2901) THEN INC2.UNB:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2902) THEN INC2.T_WATER:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2903) THEN INC2.T_AIR:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2904) THEN INC2.UNSET:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2905) THEN INC2.INFLUX:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2906) THEN INC2.V_VAULT:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2907) THEN INC2.RAIN_DAY:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2908) THEN INC2.PREC:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2912) THEN INC2.UVB_INC:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2910) THEN INC2.RAIN_YEAR:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2909) THEN INC2.T_AIR_10:=INC1.VALUE; END IF;
	  IF (INC1.PARAM_ID=2913) THEN INC2.T_AIR_30:=INC1.VALUE; END IF;
	END IF;
	OLD_GROUP_ID:=INC1.GROUP_ID;
  END LOOP;
  IF (FLAG=1) THEN
    PIPE ROW (INC2);
  END IF;
  RETURN;
END;

--

/* Создание просмотра Гидрометеорологии в журнале наблюдений старых данных */

CREATE MATERIALIZED VIEW S_GMO_JOURNAL_OBSERVATIONS_OLD
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_GMO_JOURNAL_OBSERVATIONS(1))

--

/* Обновление просмотра Гидрометеорологии в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_OBSERVATIONS_OLD');
END;

--

/* Создание индекса на цикл быстрого просмотра Гидрометеорологии в журнале наблюдений старых данных */

CREATE INDEX IDX_GMO_JO_OLD_1
 ON S_GMO_JOURNAL_OBSERVATIONS_OLD(CYCLE_ID)

--

/* Создание индекса на дату наблюдения быстрого просмотра Гидрометеорологии в журнале наблюдений старых данных */

CREATE INDEX IDX_GMO_JO_OLD_2
 ON S_GMO_JOURNAL_OBSERVATIONS_OLD(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения быстрого просмотра Гидрометеорологии в журнале наблюдений старых данных */

CREATE INDEX IDX_GMO_JO_OLD_3
 ON S_GMO_JOURNAL_OBSERVATIONS_OLD(MEASURE_TYPE_ID)

--

/* Создание просмотра Гидрометеорологии в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_OBSERVATIONS_NEW
AS
  SELECT * FROM TABLE(GET_GMO_JOURNAL_OBSERVATIONS(0))

--

/* Создание просмотра Гидрометеорологии в журнале наблюдений */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_OBSERVATIONS
AS
  SELECT JOO.*,
         (CASE 
		  WHEN JOO.PREC=1 THEN 'дождь'
		  WHEN JOO.PREC=2 THEN 'снег'  
		  WHEN JOO.PREC=3 THEN 'снег+дождь'  
		  WHEN JOO.PREC=4 THEN 'б/осадков'  
		  ELSE '' END) AS PREC_NAME 
    FROM S_GMO_JOURNAL_OBSERVATIONS_OLD JOO
   UNION
  SELECT JON.*,
         (CASE 
		  WHEN JON.PREC=1 THEN 'дождь'
		  WHEN JON.PREC=2 THEN 'снег'  
		  WHEN JON.PREC=3 THEN 'снег+дождь'  
		  WHEN JON.PREC=4 THEN 'б/осадков'  
		  ELSE '' END) AS PREC_NAME 
    FROM S_GMO_JOURNAL_OBSERVATIONS_NEW JON

--

/* Фиксация изменений БД */

COMMIT
