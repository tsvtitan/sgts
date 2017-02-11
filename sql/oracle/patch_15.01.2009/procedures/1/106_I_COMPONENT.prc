/* �������� ��������� ���������� ���������� */

CREATE OR REPLACE PROCEDURE I_COMPONENT
( 
  COMPONENT_ID IN INTEGER, 
  CONVERTER_ID IN INTEGER, 
  PARAM_ID IN INTEGER,    
  NAME IN VARCHAR2, 
  DESCRIPTION IN VARCHAR2 
) 
AS 
BEGIN 
  INSERT INTO COMPONENTS (COMPONENT_ID,CONVERTER_ID,PARAM_ID,NAME,DESCRIPTION) 
       VALUES (COMPONENT_ID,CONVERTER_ID,PARAM_ID,NAME,DESCRIPTION); 
  COMMIT; 
END;

--

/* �������� ��������� */

COMMIT