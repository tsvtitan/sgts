/* Создание функции просмотра температуры и влажности в журнале наблюдений */

CREATE OR REPLACE FUNCTION GET_TVL_JOURNAL_OBSERVATIONS 
( 
  IS_CLOSE INTEGER 
) 
RETURN TVL_JOURNAL_OBSERVATION_TABLE 
PIPELINED 
IS 
  INC2 TVL_JOURNAL_OBSERVATION_OBJECT:=TVL_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL); 
  NUM_MIN INTEGER:=NULL; 
  NUM_MAX INTEGER:=NULL; 
BEGIN 
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX  
                FROM CYCLES 
               WHERE IS_CLOSE=GET_TVL_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP 
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
                      MIN(DECODE(JO.PARAM_ID,3101,JO.VALUE,NULL)) AS VALUE_DRY, 
                      MIN(DECODE(JO.PARAM_ID,3104,JO.VALUE,NULL)) AS ADJUSTMENT_DRY, 
                      MIN(DECODE(JO.PARAM_ID,3106,JO.VALUE,NULL)) AS T_DRY, 
                      MIN(DECODE(JO.PARAM_ID,3102,JO.VALUE,NULL)) AS VALUE_WET, 
                      MIN(DECODE(JO.PARAM_ID,3105,JO.VALUE,NULL)) AS ADJUSTMENT_WET, 
                      MIN(DECODE(JO.PARAM_ID,3107,JO.VALUE,NULL)) AS T_WET, 
                      MIN(DECODE(JO.PARAM_ID,3109,JO.VALUE,NULL)) AS MOISTURE, 
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
                  AND JO.MEASURE_TYPE_ID=2660 /* Влажность */ 
                  AND JO.PARAM_ID IN (3101, /* Отсчет сухой */ 
                                      3104, /* Поправка сухая */ 
                                      3106, /* Т сухая */ 
                                      3102, /* Отсчет мокрый */ 
                                      3105, /* Поправка мокрая */ 
                                      3107, /* Т мокрая */ 
                                      3109 /* Влажность */) 
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX 
      AND C.IS_CLOSE=GET_TVL_JOURNAL_OBSERVATIONS.IS_CLOSE           
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
 INC2.VALUE_DRY:=INC1.VALUE_DRY; 
 INC2.ADJUSTMENT_DRY:=INC1.ADJUSTMENT_DRY; 
 INC2.T_DRY:=INC1.T_DRY; 
 INC2.VALUE_WET:=INC1.VALUE_WET; 
 INC2.ADJUSTMENT_WET:=INC1.ADJUSTMENT_WET; 
 INC2.T_WET:=INC1.T_WET; 
 INC2.MOISTURE:=INC1.MOISTURE; 
    INC2.OBJECT_PATHS:=INC1.OBJECT_PATHS; 
    INC2.COORDINATE_Z:=INC1.COORDINATE_Z; 
   
    PIPE ROW (INC2); 
  END LOOP; 
  RETURN; 
END;

--

/* Фиксация изменений */

COMMIT

