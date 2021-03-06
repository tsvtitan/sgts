/* �������� ������� ��������� ��������� ��������� � ������� ���������� */

CREATE OR REPLACE FUNCTION GET_SLW_JOURNAL_OBSERVATIONS 
( 
  MEASURE_TYPE_ID INTEGER, 
  IS_CLOSE INTEGER 
) 
RETURN SLW_JOURNAL_OBSERVATION_TABLE 
PIPELINED 
IS 
  INC2 SLW_JOURNAL_OBSERVATION_OBJECT:=SLW_JOURNAL_OBSERVATION_OBJECT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
                                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL); 
  NUM_MIN INTEGER:=NULL; 
  NUM_MAX INTEGER:=NULL; 
BEGIN 
  FOR INC IN (SELECT MIN(CYCLE_NUM) AS NUM_MIN, MAX(CYCLE_NUM) AS NUM_MAX  
                FROM CYCLES 
               WHERE IS_CLOSE=GET_SLW_JOURNAL_OBSERVATIONS.IS_CLOSE) LOOP 
    NUM_MIN:=INC.NUM_MIN; 
 NUM_MAX:=INC.NUM_MAX;           
    EXIT;       
  END LOOP;        
    
  FOR INC1 IN (SELECT /*+ INDEX (JO) INDEX (JF) INDEX (C) INDEX (P) INDEX (RP) INDEX (CR) */ 
                      JO.DATE_OBSERVATION,  
                      JO.MEASURE_TYPE_ID, 
                      JO.CYCLE_ID, 
                      C.CYCLE_NUM, 
                      JO.POINT_ID, 
                      P.NAME AS POINT_NAME, 
                      CR.CONVERTER_ID, 
                      CR.NAME AS CONVERTER_NAME, 
                      JO.GROUP_ID, 
                      MIN(DECODE(JO.PARAM_ID,30006,JO.VALUE,NULL)) AS VALUE_X, 
       MIN(DECODE(JO.PARAM_ID,30008,JO.VALUE,NULL)) AS VALUE_Y, 
       MIN(DECODE(JO.PARAM_ID,30009,JO.VALUE,NULL)) AS VALUE_Z, 
       MIN(DECODE(JO.PARAM_ID,30010,JO.VALUE,NULL)) AS OPENING_X, 
       MIN(DECODE(JO.PARAM_ID,30011,JO.VALUE,NULL)) AS OPENING_Y, 
       MIN(DECODE(JO.PARAM_ID,30012,JO.VALUE,NULL)) AS OPENING_Z, 
       MIN(DECODE(JO.PARAM_ID,30035,JO.VALUE,NULL)) AS CURRENT_OPENING_X, 
       MIN(DECODE(JO.PARAM_ID,30036,JO.VALUE,NULL)) AS CURRENT_OPENING_Y, 
       MIN(DECODE(JO.PARAM_ID,30037,JO.VALUE,NULL)) AS CURRENT_OPENING_Z, 
       MIN(DECODE(JO.PARAM_ID,30039,JO.VALUE,NULL)) AS CYCLE_NULL_OPENING_X, 
       MIN(DECODE(JO.PARAM_ID,30040,JO.VALUE,NULL)) AS CYCLE_NULL_OPENING_Y, 
       MIN(DECODE(JO.PARAM_ID,30041,JO.VALUE,NULL)) AS CYCLE_NULL_OPENING_Z, 
       OT.OBJECT_PATHS, 
     (SELECT GO.PRIORITY AS OBJECT_PRIORITY 
        FROM GROUP_OBJECTS GO 
       WHERE GO.GROUP_ID=2503 
         AND JO.MEASURE_TYPE_ID=30006 
         AND GO.OBJECT_ID= 
         (SELECT PARENT_ID 
              FROM OBJECT_TREES 
           WHERE OBJECT_ID=P.OBJECT_ID)) AS SECTION_JOINT_PRIORITY, 
            
  (SELECT GO.PRIORITY AS OBJECT_PRIORITY 
        FROM GROUP_OBJECTS GO 
       WHERE GO.GROUP_ID=30004 
         AND JO.MEASURE_TYPE_ID=30007 
         AND GO.OBJECT_ID= 
         (SELECT OBJECT_ID 
              FROM OBJECT_TREES 
           WHERE OBJECT_TREE_ID= 
          (SELECT PARENT_ID 
               FROM OBJECT_TREES 
            WHERE OBJECT_ID=P.OBJECT_ID))) AS JOINT_PRIORITY,       P.COORDINATE_Z, 
       JF.JOURNAL_NUM 
                 FROM JOURNAL_OBSERVATIONS JO, JOURNAL_FIELDS JF, CYCLES C, POINTS P, 
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
                  AND JO.MEASURE_TYPE_ID=GET_SLW_JOURNAL_OBSERVATIONS.MEASURE_TYPE_ID 
      AND JF.MEASURE_TYPE_ID=JO.MEASURE_TYPE_ID 
                  AND JO.PARAM_ID IN (30006, /* ������ �� X */ 
                          30008, /* ������ �� Y */ 
           30009, /* ������ �� Z */ 
                                      30010, /* ��������� � ������ ���������� �� X*/ 
                                      30011, /* ��������� � ������ ���������� �� Y*/ 
                                      30012, /* ��������� � ������ ���������� �� Z*/ 
                                      30035, /* ������� ��������� �� X */ 
                                      30036, /* ������� ��������� �� Y */ 
                                      30037, /* ������� ��������� �� Z */ 
                                      30039, /* ��������� � �������� ����� �� X */ 
                                      30040, /* ��������� � �������� ����� �� Y */ 
                                      30041 /* ��������� � �������� ����� �� Z */) 
                  AND C.CYCLE_NUM>=NUM_MIN AND C.CYCLE_NUM<=NUM_MAX 
      AND C.IS_CLOSE=GET_SLW_JOURNAL_OBSERVATIONS.IS_CLOSE 
                GROUP BY JO.DATE_OBSERVATION, JO.MEASURE_TYPE_ID, JO.CYCLE_ID, C.CYCLE_NUM, JO.POINT_ID,  
             P.NAME, CR.CONVERTER_ID, CR.NAME, JO.GROUP_ID, RP.PRIORITY, CR.DATE_ENTER,  
       OT.OBJECT_PATHS, P.OBJECT_ID, P.COORDINATE_Z, JF.JOURNAL_NUM                 
                ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, RP.PRIORITY) LOOP 
    INC2.CYCLE_ID:=INC1.CYCLE_ID; 
    INC2.CYCLE_NUM:=INC1.CYCLE_NUM; 
    INC2.JOURNAL_NUM:=INC1.JOURNAL_NUM; 
 INC2.DATE_OBSERVATION:=INC1.DATE_OBSERVATION; 
 INC2.MEASURE_TYPE_ID:=INC1.MEASURE_TYPE_ID; 
 INC2.POINT_ID:=INC1.POINT_ID; 
 INC2.POINT_NAME:=INC1.POINT_NAME; 
 INC2.CONVERTER_ID:=INC1.CONVERTER_ID; 
 INC2.CONVERTER_NAME:=INC1.CONVERTER_NAME; 
    INC2.OBJECT_PATHS:=INC1.OBJECT_PATHS; 
    INC2.SECTION_JOINT_PRIORITY:=INC1.SECTION_JOINT_PRIORITY; 
    INC2.JOINT_PRIORITY:=INC1.JOINT_PRIORITY; 
    INC2.COORDINATE_Z:=INC1.COORDINATE_Z; 
    INC2.VALUE_X:=INC1.VALUE_X; 
 INC2.VALUE_Y:=INC1.VALUE_Y; 
 INC2.VALUE_Z:=INC1.VALUE_Z; 
 INC2.OPENING_X:=INC1.OPENING_X; 
 INC2.OPENING_Y:=INC1.OPENING_Y; 
 INC2.OPENING_Z:=INC1.OPENING_Z; 
 INC2.CURRENT_OPENING_X:=INC1.CURRENT_OPENING_X; 
 INC2.CURRENT_OPENING_Y:=INC1.CURRENT_OPENING_Y; 
 INC2.CURRENT_OPENING_Z:=INC1.CURRENT_OPENING_Z; 
 INC2.CYCLE_NULL_OPENING_X:=INC1.CYCLE_NULL_OPENING_X; 
 INC2.CYCLE_NULL_OPENING_Y:=INC1.CYCLE_NULL_OPENING_Y; 
 INC2.CYCLE_NULL_OPENING_Z:=INC1.CYCLE_NULL_OPENING_Z; 
          
    PIPE ROW (INC2); 
  END LOOP; 
  RETURN; 
END;

--

/* �������� ��������� */

COMMIT

