/* �������� ���� ������� ������������ ��� ������� �������� */

ALTER TABLE OBJECTS
ADD SHORT_NAME VARCHAR2(30)

--

/* �������� ��������� ������� �������� */

CREATE OR REPLACE VIEW S_OBJECTS
AS
  SELECT O1.*
    FROM OBJECTS O1

--

/* �������� ��������� �������� ������� */


CREATE OR REPLACE PROCEDURE I_OBJECT
(
  OBJECT_ID IN INTEGER,
  NAME IN VARCHAR2,
  DESCRIPTION IN VARCHAR2,
  SHORT_NAME IN VARCHAR2
)
AS
BEGIN
  INSERT INTO OBJECTS (OBJECT_ID,NAME,DESCRIPTION,SHORT_NAME)
       VALUES (OBJECT_ID,NAME,DESCRIPTION,SHORT_NAME);
  COMMIT;
END;

--

/* �������� ��������� ��������� ������� */

CREATE OR REPLACE PROCEDURE U_OBJECT
(
  OBJECT_ID IN INTEGER,
  NAME IN VARCHAR2,
  DESCRIPTION IN VARCHAR2,
  SHORT_NAME IN VARCHAR2,
  OLD_OBJECT_ID IN INTEGER
)
AS
BEGIN
  UPDATE OBJECTS 
     SET OBJECT_ID=U_OBJECT.OBJECT_ID,
         NAME=U_OBJECT.NAME, 
         DESCRIPTION=U_OBJECT.DESCRIPTION,
		 SHORT_NAME=U_OBJECT.SHORT_NAME 
   WHERE OBJECT_ID=OLD_OBJECT_ID;
  COMMIT;        
END;

--

/* �������� ��������� �������� ������� */

CREATE OR REPLACE PROCEDURE D_OBJECT
(
  OLD_OBJECT_ID IN INTEGER
)
AS
BEGIN
  DELETE FROM OBJECTS
        WHERE OBJECT_ID=OLD_OBJECT_ID;
  COMMIT;        
END;

--

/* �������� ��������� �� */


COMMIT