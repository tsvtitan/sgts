/* �������� ������� ��������� */

CREATE TABLE DEVICES
(
  DEVICE_ID INTEGER NOT NULL, 
  NAME VARCHAR2(100) NOT NULL,
  DESCRIPTION VARCHAR2(250),
  DATE_ENTER DATE NOT NULL,
  PRIMARY KEY (DEVICE_ID)
)

--

/* �������� ��������� */

COMMIT