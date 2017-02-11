/* �������� ������������������ ��� ������� �������� */

CREATE SEQUENCE SEQ_OBJECTS
INCREMENT BY 1 
START WITH 2500 
MAXVALUE 1.0E28 
MINVALUE 2500
NOCYCLE 
CACHE 20 
NOORDER

--

/* �������� ������ ��������� �������������� ��� ������� �������� */


CREATE FUNCTION GET_OBJECT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_OBJECTS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* �������� ������� �������� */

CREATE TABLE OBJECTS
(
  OBJECT_ID INTEGER NOT NULL, 
  NAME VARCHAR2(100) NOT NULL,
  DESCRIPTION VARCHAR2(250),
  PRIMARY KEY (OBJECT_ID)
)

--

/* �������� ��������� ������� �������� */

CREATE VIEW S_OBJECTS
AS
  SELECT O1.*
    FROM OBJECTS O1


--

/* �������� ��������� �������� ������� */


CREATE PROCEDURE I_OBJECT
(
  OBJECT_ID IN INTEGER,
  NAME IN VARCHAR2,
  DESCRIPTION IN VARCHAR2
)
AS
BEGIN
  INSERT INTO OBJECTS (OBJECT_ID,NAME,DESCRIPTION)
       VALUES (OBJECT_ID,NAME,DESCRIPTION);
  COMMIT;
END;

--

/* �������� ��������� ��������� ������� */

CREATE PROCEDURE U_OBJECT
(
  OBJECT_ID IN INTEGER,
  NAME IN VARCHAR2,
  DESCRIPTION IN VARCHAR2,
  OLD_OBJECT_ID IN INTEGER
)
AS
BEGIN
  UPDATE OBJECTS 
     SET OBJECT_ID=U_OBJECT.OBJECT_ID,
         NAME=U_OBJECT.NAME, 
         DESCRIPTION=U_OBJECT.DESCRIPTION 
   WHERE OBJECT_ID=OLD_OBJECT_ID;
  COMMIT;        
END;

--

/* �������� ��������� �������� ������� */

CREATE PROCEDURE D_OBJECT
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