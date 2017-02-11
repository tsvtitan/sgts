/* �������� ������� ������� ������� */

CREATE TABLE ACCOUNTS 
(
  ACCOUNT_ID INTEGER NOT NULL, 
  PERSONNEL_ID INTEGER, 
  NAME VARCHAR2(50) NOT NULL,
  PASS VARCHAR2(50), 
  DESCRIPTION VARCHAR2(250), 
  DB_USER VARCHAR2(50),
  DB_PASS VARCHAR2(50),
  IS_ROLE INTEGER NOT NULL, 
  ADJUSTMENT CLOB,
  PRIMARY KEY (ACCOUNT_ID),
  FOREIGN KEY (PERSONNEL_ID) REFERENCES PERSONNELS (PERSONNEL_ID)
)  

--

/* �������� ��������� */

COMMIT