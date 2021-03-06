/* �������� ������� ���������� ����� ��������� */

CREATE TABLE MEASURE_TYPE_PARAMS 
(
  MEASURE_TYPE_ID INTEGER NOT NULL, 
  PARAM_ID INTEGER NOT NULL, 
  PRIORITY INTEGER NOT NULL,
  PRIMARY KEY (MEASURE_TYPE_ID,PARAM_ID),
  FOREIGN KEY (MEASURE_TYPE_ID) REFERENCES MEASURE_TYPES (MEASURE_TYPE_ID),
  FOREIGN KEY (PARAM_ID) REFERENCES PARAMS (PARAM_ID)
)

--

/* �������� ������� �� ���������� ������� ���������� ����� ��������� */

CREATE INDEX IDX_MEASURE_TYPE_PARAMS_1
 ON MEASURE_TYPE_PARAMS(PRIORITY)

--

/* �������� ��������� ������� ���������� ����� ��������� */

CREATE OR REPLACE VIEW S_MEASURE_TYPE_PARAMS
AS
  SELECT MTP.*, 
         MT.NAME AS MEASURE_TYPE_NAME, 
         P.NAME AS PARAM_NAME,
		 P.DESCRIPTION AS PARAM_DESCRIPTION,
		 P.PARAM_TYPE,
		 P.FORMAT AS PARAM_FORMAT,
		 P.ALGORITHM_ID,
		 A.NAME AS ALGORITHM_NAME,
		 A.PROC_NAME AS ALGORITHM_PROC_NAME
    FROM MEASURE_TYPE_PARAMS MTP, MEASURE_TYPES MT, PARAMS P, ALGORITHMS A
   WHERE MT.MEASURE_TYPE_ID=MTP.MEASURE_TYPE_ID 
     AND P.PARAM_ID=MTP.PARAM_ID
	 AND P.ALGORITHM_ID=A.ALGORITHM_ID (+)
ORDER BY MTP.PRIORITY

--

/* �������� ��������� ���������� ��������� ���� ��������� */

CREATE PROCEDURE I_MEASURE_TYPE_PARAM
(
  MEASURE_TYPE_ID IN INTEGER,
  PARAM_ID IN INTEGER,
  PRIORITY IN INTEGER
)
AS
BEGIN
  INSERT INTO MEASURE_TYPE_PARAMS (MEASURE_TYPE_ID,PARAM_ID,PRIORITY)
       VALUES (MEASURE_TYPE_ID,PARAM_ID,PRIORITY);
  COMMIT;
END;

--

/* �������� ��������� ��������� ��������� ���� ��������� */

CREATE OR REPLACE PROCEDURE U_MEASURE_TYPE_PARAM
(
  MEASURE_TYPE_ID IN INTEGER,
  PARAM_ID IN INTEGER,
  PRIORITY IN INTEGER,
  OLD_MEASURE_TYPE_ID IN INTEGER,
  OLD_PARAM_ID IN INTEGER
)
AS
BEGIN
  UPDATE MEASURE_TYPE_PARAMS 
     SET MEASURE_TYPE_ID=U_MEASURE_TYPE_PARAM.MEASURE_TYPE_ID,
         PARAM_ID=U_MEASURE_TYPE_PARAM.PARAM_ID,
         PRIORITY=U_MEASURE_TYPE_PARAM.PRIORITY
   WHERE MEASURE_TYPE_ID=OLD_MEASURE_TYPE_ID 
     AND PARAM_ID=OLD_PARAM_ID;
  COMMIT;        
END;

--

/* �������� ��������� �������� ��������� ���� ��������� */

CREATE PROCEDURE D_MEASURE_TYPE_PARAM
(
  OLD_MEASURE_TYPE_ID IN INTEGER,
  OLD_PARAM_ID IN INTEGER
)
AS
BEGIN
  DELETE FROM MEASURE_TYPE_PARAMS
        WHERE MEASURE_TYPE_ID=OLD_MEASURE_TYPE_ID
          AND PARAM_ID=OLD_PARAM_ID;
  COMMIT;        
END;

--

/* �������� ��������� �� */

COMMIT