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
                      JO.DATE_OBSERVATION, 
                      JO.MEASURE_TYPE_ID,
                      JO.CYCLE_ID,
                      C.CYCLE_NUM,
					  JO.POINT_ID,
                      JO.GROUP_ID,
                      MIN(DECODE(JO.PARAM_ID,2900,JO.VALUE,NULL)) AS UVB,
					  MIN(DECODE(JO.PARAM_ID,2901,JO.VALUE,NULL)) AS UNB,
					  MIN(DECODE(JO.PARAM_ID,2902,JO.VALUE,NULL)) AS T_WATER,
					  MIN(DECODE(JO.PARAM_ID,2903,JO.VALUE,NULL)) AS T_AIR,
					  MIN(DECODE(JO.PARAM_ID,2904,JO.VALUE,NULL)) AS UNSET,
					  MIN(DECODE(JO.PARAM_ID,2905,JO.VALUE,NULL)) AS INFLUX,
					  MIN(DECODE(JO.PARAM_ID,2906,JO.VALUE,NULL)) AS V_VAULT,
					  MIN(DECODE(JO.PARAM_ID,2907,JO.VALUE,NULL)) AS RAIN_DAY,
					  MIN(DECODE(JO.PARAM_ID,2908,JO.VALUE,NULL)) AS PREC,
					  MIN(DECODE(JO.PARAM_ID,2912,JO.VALUE,NULL)) AS UVB_INC,
					  MIN(DECODE(JO.PARAM_ID,2910,JO.VALUE,NULL)) AS RAIN_YEAR,
					  MIN(DECODE(JO.PARAM_ID,2909,JO.VALUE,NULL)) AS T_AIR_10,
					  MIN(DECODE(JO.PARAM_ID,2913,JO.VALUE,NULL)) AS T_AIR_30
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
               GROUP BY JO.DATE_OBSERVATION, JO.MEASURE_TYPE_ID, JO.CYCLE_ID, C.CYCLE_NUM,
			            JO.POINT_ID, JO.GROUP_ID				 								  
               ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID) LOOP

    INC2.CYCLE_ID:=INC1.CYCLE_ID;
    INC2.CYCLE_NUM:=INC1.CYCLE_NUM;
	INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION;
	INC2.MEASURE_TYPE_ID:=INC1.MEASURE_TYPE_ID;
	INC2.POINT_ID:=INC1.POINT_ID;
	INC2.UVB:=INC1.UVB;
	INC2.UNB:=INC1.UNB;
	INC2.T_WATER:=INC1.T_WATER;
	INC2.T_AIR:=INC1.T_AIR;
	INC2.UNSET:=INC1.UNSET;
	INC2.INFLUX:=INC1.INFLUX;
	INC2.V_VAULT:=INC1.V_VAULT;
	INC2.RAIN_DAY:=INC1.RAIN_DAY;
	INC2.PREC:=INC1.PREC;
	INC2.UVB_INC:=INC1.UVB_INC;
	INC2.RAIN_YEAR:=INC1.RAIN_YEAR;
	INC2.T_AIR_10:=INC1.T_AIR_10;
	INC2.T_AIR_30:=INC1.T_AIR_30;
	
	PIPE ROW (INC2);
  END LOOP;
  RETURN;
END;

--

/* Обновление просмотра Гидрометеорологии в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_OBSERVATIONS_OLD');
END;

--

/* Фиксация изменений БД */

COMMIT
