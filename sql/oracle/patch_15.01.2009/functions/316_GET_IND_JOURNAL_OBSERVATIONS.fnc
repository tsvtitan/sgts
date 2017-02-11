/* �������� ������� ��������� ����������� ������� � ������� ���������� */

CREATE OR REPLACE FUNCTION GET_IND_JOURNAL_OBSERVATIONS 
( 
  IS_CLOSE INTEGER 
) 
RETURN IND_JOURNAL_OBSERVATION_TABLE 
PIPELINED 
IS 
  INC2 IND_JOURNAL_OBSERVATION_OBJECT:=IND_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL); 
  NUM_MIN INTEGER:=NULL; 
  NUM_MAX INTEGER:=NULL; 
BEGIN 
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX  
                FROM CYCLES 
               WHERE IS_CLOSE=GET_IND_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP 
    NUM_MIN:=INC.NUM_MIN; 
 NUM_MAX:=INC.NUM_MAX;           
    EXIT;       
  END LOOP;        
    
  FOR INC1 IN (SELECT /*+ INDEX (JO) INDEX (JF) INDEX (C) INDEX (P) INDEX (RP) INDEX (CR) */ 
                      JO.DATE_OBSERVATION, 
                      JO.CYCLE_ID, 
                      C.CYCLE_NUM, 
                      JO.POINT_ID, 
                      P.NAME AS POINT_NAME, 
                      CR.CONVERTER_ID, 
                      CR.NAME AS CONVERTER_NAME, 
         MIN(DECODE(JO.PARAM_ID,30015,JO.VALUE,NULL)) AS VALUE,   
         MIN(DECODE(JO.PARAM_ID,30017,JO.VALUE,NULL)) AS OFFSET_BEGIN,   
         MIN(DECODE(JO.PARAM_ID,30030,JO.VALUE,NULL)) AS CURRENT_OFFSET, 
                      (SELECT TO_NUMBER(CP.VALUE)  
          FROM CONVERTER_PASSPORTS CP, COMPONENTS CM  
                        WHERE CP.COMPONENT_ID=CM.COMPONENT_ID 
                          AND CM.CONVERTER_ID=CR.CONVERTER_ID 
                          AND CM.PARAM_ID=30014 /* ��� ���������� */ ) AS INDICATOR_TYPE,        
       OT.OBJECT_PATHS, 
      (SELECT GO.PRIORITY AS OBJECT_PRIORITY 
        FROM GROUP_OBJECTS GO 
       WHERE GO.GROUP_ID=30001 
         AND GO.OBJECT_ID=P.OBJECT_ID) AS OBJECT_PRIORITY, 
       P.COORDINATE_Z, 
       JF.JOURNAL_NUM 
                 FROM JOURNAL_OBSERVATIONS JO, JOURNAL_FIELDS JF,  
          CYCLES C, POINTS P, 
                      ROUTE_POINTS RP, CONVERTERS CR, 
                      (SELECT OT1.OBJECT_ID, SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS 
                         FROM OBJECT_TREES OT1, OBJECTS O1 
                        WHERE OT1.OBJECT_ID=O1.OBJECT_ID 
                        START WITH OT1.PARENT_ID IS NULL 
                      CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID 
         GROUP BY OT1.OBJECT_ID) OT 
                WHERE JO.JOURNAL_FIELD_ID=JF.JOURNAL_FIELD_ID 
      AND JO.CYCLE_ID=C.CYCLE_ID 
                  AND JO.POINT_ID=P.POINT_ID 
                  AND RP.POINT_ID=JO.POINT_ID 
                  AND CR.CONVERTER_ID=P.POINT_ID  
      AND P.OBJECT_ID=OT.OBJECT_ID 
      AND JO.MEASURE_TYPE_ID=30008 /* ���������� ������� */ 
                  AND JO.PARAM_ID IN (30015, /* ������ */ 
                                      30017, /* �������� � ������ ���������� */ 
                                      30030 /* ������� �������� */) 
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX 
      AND C.IS_CLOSE=GET_IND_JOURNAL_OBSERVATIONS.IS_CLOSE           
    GROUP BY JO.DATE_OBSERVATION, JO.CYCLE_ID, C.CYCLE_NUM, JO.POINT_ID,  
             P.NAME, CR.CONVERTER_ID, CR.NAME, JO.GROUP_ID, RP.PRIORITY,   
       OT.OBJECT_PATHS, P.OBJECT_ID, P.COORDINATE_Z, JF.JOURNAL_NUM 
                ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, RP.PRIORITY) LOOP 
 INC2.CYCLE_ID:=INC1.CYCLE_ID; 
 INC2.CYCLE_NUM:=INC1.CYCLE_NUM; 
 INC2.JOURNAL_NUM:=INC1.JOURNAL_NUM; 
 INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION; 
 INC2.POINT_ID:=INC1.POINT_ID; 
 INC2.POINT_NAME:=INC1.POINT_NAME; 
 INC2.CONVERTER_ID:=INC1.CONVERTER_ID; 
 INC2.CONVERTER_NAME:=INC1.CONVERTER_NAME; 
 INC2.OBJECT_PATHS:=INC1.OBJECT_PATHS; 
 INC2.OBJECT_PRIORITY:=INC1.OBJECT_PRIORITY; 
 INC2.COORDINATE_Z:=INC1.COORDINATE_Z; 
    INC2.INDICATOR_TYPE:=INC1.INDICATOR_TYPE; 
    INC2.VALUE:=INC1.VALUE; 
    INC2.OFFSET_BEGIN:=INC1.OFFSET_BEGIN; 
    INC2.CURRENT_OFFSET:=INC1.CURRENT_OFFSET; 
  
    PIPE ROW (INC2); 
  END LOOP;  
  RETURN; 
END;

--

/* �������� ��������� */

COMMIT