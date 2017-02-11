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
                      JF.DATE_OBSERVATION, 
                      JF.MEASURE_TYPE_ID,
                      JF.CYCLE_ID,
                      C.CYCLE_NUM,
                      JF.POINT_ID,
                      JF.GROUP_ID,
                      MIN(DECODE(JF.PARAM_ID,2900,JF.VALUE,NULL)) AS UVB,
					  MIN(DECODE(JF.PARAM_ID,2901,JF.VALUE,NULL)) AS UNB,
					  MIN(DECODE(JF.PARAM_ID,2902,JF.VALUE,NULL)) AS T_WATER,
					  MIN(DECODE(JF.PARAM_ID,2903,JF.VALUE,NULL)) AS T_AIR,
					  MIN(DECODE(JF.PARAM_ID,2904,JF.VALUE,NULL)) AS UNSET,
					  MIN(DECODE(JF.PARAM_ID,2905,JF.VALUE,NULL)) AS INFLUX,
					  MIN(DECODE(JF.PARAM_ID,2906,JF.VALUE,NULL)) AS V_VAULT,
					  MIN(DECODE(JF.PARAM_ID,2907,JF.VALUE,NULL)) AS RAIN_DAY,
					  MIN(DECODE(JF.PARAM_ID,2908,JF.VALUE,NULL)) AS PREC
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
                GROUP BY JF.DATE_OBSERVATION, JF.MEASURE_TYPE_ID, JF.CYCLE_ID, C.CYCLE_NUM,
				         JF.POINT_ID, JF.GROUP_ID				  								  
                ORDER BY JF.DATE_OBSERVATION, JF.GROUP_ID) LOOP

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
	
    PIPE ROW (INC2);
	
  END LOOP;
  RETURN;
END;

--

/* Обновление просмотра Гидрометеорологии в полевом журнале старых данных */

BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_FIELDS_OLD');
END;

--

/* Фиксация изменений БД */

COMMIT
