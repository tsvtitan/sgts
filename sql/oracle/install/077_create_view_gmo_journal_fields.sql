/* Создание типа объекта Гидрометеорологии полевого журнала */

CREATE OR REPLACE TYPE GMO_JOURNAL_FIELD_OBJECT AS OBJECT
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
  V_VAULT FLOAT
)

--

/* Создание типа таблицы Гидрометеорологии полевого журнала */

CREATE OR REPLACE TYPE GMO_JOURNAL_FIELD_TABLE 
AS TABLE OF GMO_JOURNAL_FIELD_OBJECT

--

/* Создание функции просмотра Гидрометеорологии в полевом журнале */

CREATE OR REPLACE FUNCTION GET_GMO_JOURNAL_FIELDS
(
  IS_CLOSE INTEGER
)
RETURN GMO_JOURNAL_FIELD_TABLE
PIPELINED
IS
  INC2 GMO_JOURNAL_FIELD_OBJECT:=GMO_JOURNAL_FIELD_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                          NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  FLAG INTEGER:=0;
  OLD_GROUP_ID VARCHAR2(32):='';
  NUM_MIN INTEGER:=NULL;
  NUM_MAX INTEGER:=NULL;
BEGIN
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX 
                FROM CYCLES
               WHERE IS_CLOSE=GET_GMO_JOURNAL_FIELDS.IS_CLOSE) LOOP
    NUM_MIN:=INC.NUM_MIN;
	NUM_MAX:=INC.NUM_MAX;    			   
    EXIT;			   
  END LOOP;			    
   
  FOR INC1 IN (SELECT /*+ INDEX (JF) INDEX (C) */
                      JF.PARAM_ID, 
                      JF.DATE_OBSERVATION, 
                      JF.VALUE, 
                      JF.GROUP_ID,
                      JF.MEASURE_TYPE_ID,
                      JF.POINT_ID,
                      C.CYCLE_NUM,
                      JF.CYCLE_ID  
                 FROM JOURNAL_FIELDS JF, CYCLES C
                WHERE JF.CYCLE_ID=C.CYCLE_ID
                  AND JF.MEASURE_TYPE_ID=2520 /* Гидрометеорология  */
                  AND JF.PARAM_ID IN (2900 /* УВБ */,
                                      2901 /* УНБ */,
                                      2902 /* T воды */,
                                      2903 /* T воздуха */,
                                      2904 /* Сброс */,
                                      2905 /* Приток */,
                                      2906 /* Объем водохранилища */,
                                      2907 /* Осадков за сутки */,
                                      2908 /* Вид осадков */)
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX
				  AND C.IS_CLOSE=GET_GMO_JOURNAL_FIELDS.IS_CLOSE								  
                ORDER BY JF.DATE_OBSERVATION, JF.GROUP_ID, JF.PRIORITY, JF.PARAM_ID) LOOP
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
	END IF;
	OLD_GROUP_ID:=INC1.GROUP_ID;
  END LOOP;
  IF (FLAG=1) THEN
    PIPE ROW (INC2);
  END IF;
  RETURN;
END;

--

/* Создание просмотра Гидрометеорологии в полевом журнале старых данных */ 

CREATE MATERIALIZED VIEW S_GMO_JOURNAL_FIELDS_OLD
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.06.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_GMO_JOURNAL_FIELDS(1))

--

/* Обновление просмотра Гидрометеорологии в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_FIELDS_OLD');
END;

--

/* Создание индекса на цикл просмотра Гидрометеорологии в полевом журнале старых данных */

CREATE INDEX IDX_GMO_JF_OLD_1
 ON S_GMO_JOURNAL_FIELDS_OLD(CYCLE_ID)

--

/* Создание индекса на дату наблюдения просмотра Гидрометеорологии в полевом журнале старых данных */

CREATE INDEX IDX_GMO_JF_OLD_2
 ON S_GMO_JOURNAL_FIELDS_OLD(DATE_OBSERVATION)

--

/* Создание просмотра Гидрометеорологии в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_FIELDS_NEW
AS
  SELECT * FROM TABLE(GET_GMO_JOURNAL_FIELDS(0))

--

/* Создание просмотра Гидрометеорологии в полевом журнале */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_FIELDS
AS
  SELECT JFO.*,
         (CASE 
		  WHEN JFO.PREC=1 THEN 'дождь'
		  WHEN JFO.PREC=2 THEN 'снег'  
		  WHEN JFO.PREC=3 THEN 'снег+дождь'  
		  WHEN JFO.PREC=4 THEN 'б/осадков'  
		  ELSE '' END) AS PREC_NAME 
    FROM S_GMO_JOURNAL_FIELDS_OLD JFO
   UNION
  SELECT JFN.*,
         (CASE 
		  WHEN JFN.PREC=1 THEN 'дождь'
		  WHEN JFN.PREC=2 THEN 'снег'  
		  WHEN JFN.PREC=3 THEN 'снег+дождь'  
		  WHEN JFN.PREC=4 THEN 'б/осадков'  
		  ELSE '' END) AS PREC_NAME 
    FROM S_GMO_JOURNAL_FIELDS_NEW JFN

--

/* Фиксация изменений БД */

COMMIT
