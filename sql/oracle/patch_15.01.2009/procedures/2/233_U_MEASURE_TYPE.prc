/* �������� ��������� ��������� ���� ��������� */

CREATE OR REPLACE PROCEDURE U_MEASURE_TYPE
( 
  MEASURE_TYPE_ID IN INTEGER, 
  PARENT_ID IN INTEGER,  
  NAME IN VARCHAR2, 
  DESCRIPTION IN VARCHAR2, 
  DATE_BEGIN IN DATE, 
  IS_ACTIVE IN INTEGER, 
  PRIORITY IN INTEGER, 
  IS_VISUAL IN INTEGER, 
  IS_BASE IN INTEGER, 
  OLD_MEASURE_TYPE_ID IN INTEGER 
) 
AS 
BEGIN 
  A_MEASURE_TYPE_PARENT_ID (MEASURE_TYPE_ID,PARENT_ID); 
  UPDATE MEASURE_TYPES  
     SET MEASURE_TYPE_ID=U_MEASURE_TYPE.MEASURE_TYPE_ID, 
         PARENT_ID=U_MEASURE_TYPE.PARENT_ID,  
         NAME=U_MEASURE_TYPE.NAME,  
         DESCRIPTION=U_MEASURE_TYPE.DESCRIPTION, 
   DATE_BEGIN=U_MEASURE_TYPE.DATE_BEGIN, 
   IS_ACTIVE=U_MEASURE_TYPE.IS_ACTIVE,  
         PRIORITY=U_MEASURE_TYPE.PRIORITY, 
   IS_VISUAL=U_MEASURE_TYPE.IS_VISUAL, 
   IS_BASE=U_MEASURE_TYPE.IS_BASE 
   WHERE MEASURE_TYPE_ID=OLD_MEASURE_TYPE_ID; 
  COMMIT;         
END;

--

/* �������� ��������� */

COMMIT
