/* �������� ������� ���������� �������� */

CREATE TABLE OBJECT_DOCUMENTS 
(
  OBJECT_ID INTEGER NOT NULL, 
  DOCUMENT_ID INTEGER NOT NULL, 
  PRIORITY INTEGER NOT NULL,
  PRIMARY KEY (OBJECT_ID,DOCUMENT_ID),
  FOREIGN KEY (OBJECT_ID) REFERENCES OBJECTS (OBJECT_ID),
  FOREIGN KEY (DOCUMENT_ID) REFERENCES DOCUMENTS (DOCUMENT_ID)
)


--

/* �������� ��������� ������� ���������� �������� */

CREATE OR REPLACE VIEW S_OBJECT_DOCUMENTS
AS
  SELECT OD.*, 
         O.NAME AS OBJECT_NAME, 
		 D.NAME AS DOCUMENT_NAME,
		 D.DESCRIPTION AS DOCUMENT_DESCRIPTION,
		 D.FILE_NAME
    FROM OBJECT_DOCUMENTS OD, OBJECTS O, DOCUMENTS D
   WHERE O.OBJECT_ID=OD.OBJECT_ID 
     AND D.DOCUMENT_ID=OD.DOCUMENT_ID

--

/* �������� ��������� ���������� ��������� ������� */

CREATE PROCEDURE I_OBJECT_DOCUMENT
(
  OBJECT_ID IN INTEGER,
  DOCUMENT_ID IN INTEGER,
  PRIORITY IN INTEGER
)
AS
BEGIN
  INSERT INTO OBJECT_DOCUMENTS (OBJECT_ID,DOCUMENT_ID,PRIORITY)
       VALUES (OBJECT_ID,DOCUMENT_ID,PRIORITY);
  COMMIT;
END;

--

/* �������� ��������� ��������� ��������� � ������� */

CREATE OR REPLACE PROCEDURE U_OBJECT_DOCUMENT
(
  OBJECT_ID IN INTEGER,
  DOCUMENT_ID IN INTEGER,
  PRIORITY IN INTEGER,
  OLD_OBJECT_ID IN INTEGER,
  OLD_DOCUMENT_ID IN INTEGER
)
AS
BEGIN
  UPDATE OBJECT_DOCUMENTS 
     SET OBJECT_ID=U_OBJECT_DOCUMENT.OBJECT_ID,
         DOCUMENT_ID=U_OBJECT_DOCUMENT.DOCUMENT_ID,
         PRIORITY=U_OBJECT_DOCUMENT.PRIORITY
   WHERE OBJECT_ID=OLD_OBJECT_ID 
     AND DOCUMENT_ID=OLD_DOCUMENT_ID;
  COMMIT;        
END;

--

/* �������� ��������� �������� ��������� � ������� */

CREATE PROCEDURE D_OBJECT_DOCUMENT
(
  OLD_OBJECT_ID IN INTEGER,
  OLD_DOCUMENT_ID IN INTEGER
)
AS
BEGIN
  DELETE FROM OBJECT_DOCUMENTS
        WHERE OBJECT_ID=OLD_OBJECT_ID
          AND DOCUMENT_ID=OLD_DOCUMENT_ID;
  COMMIT;        
END;

--

/* �������� ��������� �� */

COMMIT