/* �������� ��������� ��������� �������� ������� */

CREATE OR REPLACE PROCEDURE U_OBJECT_PASSPORT
( 
  OBJECT_PASSPORT_ID IN INTEGER, 
  OBJECT_ID IN INTEGER, 
  DATE_PASSPORT IN DATE, 
  PARAM_NAME IN VARCHAR2, 
  VALUE IN FLOAT,   
  DESCRIPTION IN VARCHAR2, 
  OLD_OBJECT_PASSPORT_ID IN INTEGER 
) 
AS 
BEGIN 
  UPDATE OBJECT_PASSPORTS  
     SET OBJECT_PASSPORT_ID=U_OBJECT_PASSPORT.OBJECT_PASSPORT_ID, 
      OBJECT_ID=U_OBJECT_PASSPORT.OBJECT_ID, 
   DATE_PASSPORT=U_OBJECT_PASSPORT.DATE_PASSPORT, 
   PARAM_NAME=U_OBJECT_PASSPORT.PARAM_NAME, 
   VALUE=U_OBJECT_PASSPORT.VALUE, 
         DESCRIPTION=U_OBJECT_PASSPORT.DESCRIPTION  
   WHERE OBJECT_PASSPORT_ID=OLD_OBJECT_PASSPORT_ID; 
  COMMIT;         
END;

--

/* �������� ��������� */

COMMIT
