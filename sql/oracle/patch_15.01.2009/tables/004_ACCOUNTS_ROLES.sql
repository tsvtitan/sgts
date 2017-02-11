/* �������� ������� ������� � ����� */

CREATE TABLE ACCOUNTS_ROLES 
(
  ACCOUNT_ID INTEGER NOT NULL, 
  ROLE_ID INTEGER NOT NULL, 
  PRIMARY KEY (ACCOUNT_ID,ROLE_ID),
  FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNTS (ACCOUNT_ID),
  FOREIGN KEY (ROLE_ID) REFERENCES ACCOUNTS (ACCOUNT_ID)
)

--

/* �������� ��������� */

COMMIT
