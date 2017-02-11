/* Создание процедуры утверждения и расчета приращения УВБ */

CREATE OR REPLACE PROCEDURE CONFIRM_UVB_INC
( 
  JOURNAL_FIELD_ID IN INTEGER, 
  ALGORITHM_ID IN INTEGER 
) 
AS 
  JOURNAL_OBSERVATION_ID INTEGER; 
  AMEASURE_TYPE_ID INTEGER; 
  ACYCLE_ID INTEGER; 
  AWHO_CONFIRM INTEGER; 
  ADATE_CONFIRM DATE; 
  AGROUP_ID VARCHAR2(32); 
  APRIORITY INTEGER; 
  APOINT_ID INTEGER; 
  APARAM_ID INTEGER; 
  UVB_OLD FLOAT; 
  UVB FLOAT; 
  UVB_INC FLOAT; 
  ADATE_OBSERVATION DATE; 
BEGIN 
  SELECT MEASURE_TYPE_ID,CYCLE_ID,WHO_CONFIRM,DATE_CONFIRM,GROUP_ID,PRIORITY,POINT_ID, 
         DATE_OBSERVATION, VALUE, PARAM_ID   
    INTO AMEASURE_TYPE_ID,ACYCLE_ID,AWHO_CONFIRM,ADATE_CONFIRM,AGROUP_ID,APRIORITY,APOINT_ID, 
         ADATE_OBSERVATION, UVB, APARAM_ID 
    FROM JOURNAL_FIELDS 
   WHERE JOURNAL_FIELD_ID=CONFIRM_UVB_INC.JOURNAL_FIELD_ID; 
 
  IF (APARAM_ID=2900)/* УВБ */ THEN  
 
     DELETE FROM JOURNAL_OBSERVATIONS 
        WHERE JOURNAL_FIELD_ID=CONFIRM_UVB_INC.JOURNAL_FIELD_ID 
             AND ALGORITHM_ID=CONFIRM_UVB_INC.ALGORITHM_ID  
             AND MEASURE_TYPE_ID=AMEASURE_TYPE_ID 
             AND CYCLE_ID=ACYCLE_ID 
             AND DATE_OBSERVATION=ADATE_OBSERVATION 
             AND GROUP_ID=AGROUP_ID 
             AND POINT_ID=APOINT_ID 
             AND PARAM_ID=2912; /* Приращение УВБ */ 
    COMMIT; 
     
    IF (AWHO_CONFIRM IS NOT NULL) THEN 
      UVB_OLD:=NULL; 
      FOR INC IN (SELECT /*+ FIRST_ROWS (20) */ VALUE  
                    FROM JOURNAL_FIELDS 
                   WHERE MEASURE_TYPE_ID=AMEASURE_TYPE_ID 
                     AND PARAM_ID=2900 /* УВБ */ 
                     AND DATE_OBSERVATION<ADATE_OBSERVATION 
                ORDER BY DATE_OBSERVATION DESC) LOOP 
        UVB_OLD:=INC.VALUE;    
        EXIT WHEN UVB_OLD IS NOT NULL; 
      END LOOP; 
      IF UVB_OLD IS NOT NULL THEN 
        UVB_INC:=UVB-UVB_OLD; 
        I_JOURNAL_OBSERVATION(GET_JOURNAL_OBSERVATION_ID, 
                              JOURNAL_FIELD_ID, 
                              NULL, 
                              AMEASURE_TYPE_ID, 
                              NULL, 
                              ADATE_OBSERVATION, 
                              ACYCLE_ID, 
                              APOINT_ID, 
                              2912,/* Приращение УВБ */ 
                              UVB_INC, 
                              AWHO_CONFIRM, 
                              ADATE_CONFIRM, 
                              ALGORITHM_ID, 
                              AGROUP_ID, 
                              APRIORITY); 
      END IF; 
 END IF;   
  END IF;    
END;

--

/* Фиксация */

COMMIT
