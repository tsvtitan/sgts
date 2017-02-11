/* �������� ������������������ ��� ������� ���������� */

CREATE SEQUENCE SEQ_ALGORITHMS
INCREMENT BY 1 
START WITH 2700 
MAXVALUE 1.0E28 
MINVALUE 2700
NOCYCLE 
CACHE 20 
NOORDER

--

/* �������� ������ ��������� �������������� ��� ������� ���������� */


CREATE OR REPLACE FUNCTION GET_ALGORITHM_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_ALGORITHMS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* �������� ������� ���������� */

CREATE TABLE ALGORITHMS
(
  ALGORITHM_ID INTEGER NOT NULL, 
  NAME VARCHAR2(100) NOT NULL,
  PROC_NAME VARCHAR2(100) NOT NULL,
  DESCRIPTION VARCHAR2(250),
  PRIMARY KEY (ALGORITHM_ID)
)

--

/* �������� ��������� ������� ���������� */

CREATE VIEW S_ALGORITHMS
AS
  SELECT A.*
    FROM ALGORITHMS A

--

/* �������� ��������� �������� ��������� */

CREATE OR REPLACE PROCEDURE I_ALGORITHM
(
  ALGORITHM_ID IN INTEGER,
  NAME IN VARCHAR2,
  PROC_NAME IN VARCHAR2,
  DESCRIPTION IN VARCHAR2
)
AS
BEGIN
  INSERT INTO ALGORITHMS (ALGORITHM_ID,NAME,PROC_NAME,DESCRIPTION)
       VALUES (ALGORITHM_ID,NAME,PROC_NAME,DESCRIPTION);
  COMMIT;
END;

--

/* �������� ��������� ��������� ��������� */

CREATE PROCEDURE U_ALGORITHM
(
  ALGORITHM_ID IN INTEGER,
  NAME IN VARCHAR2,
  PROC_NAME IN VARCHAR2,
  DESCRIPTION IN VARCHAR2,
  OLD_ALGORITHM_ID IN INTEGER
)
AS
BEGIN
  UPDATE ALGORITHMS 
     SET ALGORITHM_ID=U_ALGORITHM.ALGORITHM_ID,
         NAME=U_ALGORITHM.NAME, 
         PROC_NAME=U_ALGORITHM.PROC_NAME, 
         DESCRIPTION=U_ALGORITHM.DESCRIPTION 
   WHERE ALGORITHM_ID=OLD_ALGORITHM_ID;
  COMMIT;        
END;

--

/* �������� ��������� �������� ��������� */

CREATE PROCEDURE D_ALGORITHM
(
  OLD_ALGORITHM_ID IN INTEGER
)
AS
BEGIN
  DELETE FROM ALGORITHMS
        WHERE ALGORITHM_ID=OLD_ALGORITHM_ID;
  COMMIT;        
END;

--

/* �������� ��������� �� */

COMMIT