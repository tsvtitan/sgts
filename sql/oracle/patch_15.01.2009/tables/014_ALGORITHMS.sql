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

/* �������� ��������� */

COMMIT