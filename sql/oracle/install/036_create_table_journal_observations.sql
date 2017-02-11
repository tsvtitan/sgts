/* �������� ������������������ ��� ������� ������� ���������� */

CREATE SEQUENCE SEQ_JOURNAL_OBSERVATIONS
INCREMENT BY 1 
START WITH 2500 
MAXVALUE 1.0E28 
MINVALUE 2500
NOCYCLE 
CACHE 20 
NOORDER

--

/* �������� ������ ��������� �������������� ������� ������� ���������� */

CREATE OR REPLACE FUNCTION GET_JOURNAL_OBSERVATION_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_JOURNAL_OBSERVATIONS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* �������� ������� ������� ���������� */

CREATE TABLE JOURNAL_OBSERVATIONS
(
  JOURNAL_OBSERVATION_ID INTEGER NOT NULL,
  JOURNAL_FIELD_ID INTEGER,
  INSTRUMENT_ID INTEGER,
  MEASURE_TYPE_ID INTEGER NOT NULL,
  MEASURE_UNIT_ID INTEGER,
  DATE_OBSERVATION DATE NOT NULL,
  CYCLE_ID INTEGER NOT NULL,
  POINT_ID INTEGER,
  PARAM_ID INTEGER,
  VALUE FLOAT NOT NULL,
  WHO_ENTER INTEGER NOT NULL,
  DATE_ENTER DATE NOT NULL,
  ALGORITHM_ID INTEGER NOT NULL,
  GROUP_ID VARCHAR2(32) NOT NULL,
  PRIORITY INTEGER NOT NULL,
  PRIMARY KEY (JOURNAL_OBSERVATION_ID),
  FOREIGN KEY (JOURNAL_FIELD_ID) REFERENCES JOURNAL_FIELDS (JOURNAL_FIELD_ID),
  FOREIGN KEY (CYCLE_ID) REFERENCES CYCLES (CYCLE_ID),
  FOREIGN KEY (POINT_ID) REFERENCES POINTS (POINT_ID),
  FOREIGN KEY (PARAM_ID) REFERENCES PARAMS (PARAM_ID),
  FOREIGN KEY (INSTRUMENT_ID) REFERENCES INSTRUMENTS (INSTRUMENT_ID),
  FOREIGN KEY (MEASURE_UNIT_ID) REFERENCES MEASURE_UNITS (MEASURE_UNIT_ID),
  FOREIGN KEY (MEASURE_TYPE_ID) REFERENCES MEASURE_TYPES (MEASURE_TYPE_ID),
  FOREIGN KEY (WHO_ENTER) REFERENCES PERSONNELS (PERSONNEL_ID),
  FOREIGN KEY (ALGORITHM_ID) REFERENCES ALGORITHMS (ALGORITHM_ID)
)

--

/* �������� ������� �� ��������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_1
 ON JOURNAL_OBSERVATIONS(ALGORITHM_ID)

--

/* �������� ������� �� ����� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_2
 ON JOURNAL_OBSERVATIONS(CYCLE_ID)

--

/* �������� ������� �� ���� ���������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_3
 ON JOURNAL_OBSERVATIONS(DATE_OBSERVATION)

--

/* �������� ������� �� ������ ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_4
 ON JOURNAL_OBSERVATIONS(GROUP_ID)

--

/* �������� ������� �� ������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_5
 ON JOURNAL_OBSERVATIONS(INSTRUMENT_ID)

--

/* �������� ������� �� �������������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_6
 ON JOURNAL_OBSERVATIONS(JOURNAL_FIELD_ID)

--

/* �������� ������� �� ���� ��������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_7
 ON JOURNAL_OBSERVATIONS(MEASURE_TYPE_ID)

--

/* �������� ������� �� ������� ��������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_8
 ON JOURNAL_OBSERVATIONS(MEASURE_UNIT_ID)

--

/* �������� ������� �� ��������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_9
 ON JOURNAL_OBSERVATIONS(PARAM_ID)

--

/* �������� ������� �� ����� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_10
 ON JOURNAL_OBSERVATIONS(POINT_ID)

--

/* �������� ������� �� ������ ������� ���������� */

CREATE BITMAP INDEX IDX_JOURNAL_OBSERVATIONS_11
 ON JOURNAL_OBSERVATIONS (EXTRACT(MONTH FROM DATE_OBSERVATION))

--

/* �������� ������� �� ���� ������� ���������� */

CREATE BITMAP INDEX IDX_JOURNAL_OBSERVATIONS_12
 ON JOURNAL_OBSERVATIONS (EXTRACT(YEAR FROM DATE_OBSERVATION))

--

/* �������� ������� �� ���������� ������� ���������� */

CREATE INDEX IDX_JOURNAL_OBSERVATIONS_13
 ON JOURNAL_OBSERVATIONS (PRIORITY)

--

/* �������� ��������� ������� ������� ���������� */

CREATE OR REPLACE VIEW S_JOURNAL_OBSERVATIONS
AS
  SELECT JO.*, 
         MT.NAME AS MEASURE_TYPE_NAME,
         C.CYCLE_NUM,
         PR.NAME AS PARAM_NAME,
		 A.NAME AS ALGORITHM_NAME,
         P.FNAME||' '||P.NAME||' '||P.SNAME AS WHO_ENTER_NAME,
         PT.NAME AS POINT_NAME,
		 I.NAME AS INSTRUMENT_NAME,
		 MU.NAME AS MEASURE_UNIT_NAME
    FROM JOURNAL_OBSERVATIONS JO, MEASURE_TYPES MT, CYCLES C,  
	     PARAMS PR, ALGORITHMS A, PERSONNELS P, POINTS PT, INSTRUMENTS I,
		 MEASURE_UNITS MU 
   WHERE JO.MEASURE_TYPE_ID=MT.MEASURE_TYPE_ID
     AND JO.CYCLE_ID=C.CYCLE_ID  
     AND JO.ALGORITHM_ID=A.ALGORITHM_ID
     AND JO.WHO_ENTER=P.PERSONNEL_ID
     AND JO.PARAM_ID=PR.PARAM_ID (+)
     AND JO.POINT_ID=PT.POINT_ID (+)
	 AND JO.INSTRUMENT_ID=I.INSTRUMENT_ID (+)
	 AND JO.MEASURE_UNIT_ID=MU.MEASURE_UNIT_ID (+)

--

/* �������� ��������� �������� ������ � ������� ���������� */

CREATE OR REPLACE PROCEDURE I_JOURNAL_OBSERVATION
(
  JOURNAL_OBSERVATION_ID IN INTEGER,
  JOURNAL_FIELD_ID IN INTEGER,
  INSTRUMENT_ID IN INTEGER,
  MEASURE_TYPE_ID IN INTEGER,
  MEASURE_UNIT_ID IN INTEGER,
  DATE_OBSERVATION IN DATE,
  CYCLE_ID IN INTEGER,
  POINT_ID IN INTEGER,
  PARAM_ID IN INTEGER,
  VALUE IN FLOAT,
  WHO_ENTER IN INTEGER,
  DATE_ENTER IN DATE,
  ALGORITHM_ID IN INTEGER,
  GROUP_ID IN VARCHAR2,
  PRIORITY IN INTEGER
)
AS
BEGIN
  INSERT INTO JOURNAL_OBSERVATIONS (JOURNAL_OBSERVATION_ID,JOURNAL_FIELD_ID,
                                    INSTRUMENT_ID,MEASURE_TYPE_ID,MEASURE_UNIT_ID,
                                    DATE_OBSERVATION,CYCLE_ID,POINT_ID,PARAM_ID,
                                    VALUE,WHO_ENTER,DATE_ENTER,ALGORITHM_ID,GROUP_ID,PRIORITY)
       VALUES (JOURNAL_OBSERVATION_ID,JOURNAL_FIELD_ID,
               INSTRUMENT_ID,MEASURE_TYPE_ID,MEASURE_UNIT_ID,
               DATE_OBSERVATION,CYCLE_ID,POINT_ID,PARAM_ID,
               VALUE,WHO_ENTER,DATE_ENTER,ALGORITHM_ID,GROUP_ID,PRIORITY);
  COMMIT;
END;

--

/* �������� ��������� ��������� ������ � ������� ���������� */


CREATE OR REPLACE PROCEDURE U_JOURNAL_OBSERVATION
(
  JOURNAL_OBSERVATION_ID IN INTEGER,
  JOURNAL_FIELD_ID IN INTEGER,
  INSTRUMENT_ID IN INTEGER,
  MEASURE_TYPE_ID IN INTEGER,
  MEASURE_UNIT_ID IN INTEGER,
  DATE_OBSERVATION IN DATE,
  CYCLE_ID IN INTEGER,
  POINT_ID IN INTEGER,
  PARAM_ID IN INTEGER,
  VALUE IN FLOAT,
  WHO_ENTER IN INTEGER,
  DATE_ENTER IN DATE,
  ALGORITHM_ID IN INTEGER,
  GROUP_ID IN VARCHAR2,
  PRIORITY IN INTEGER,
  OLD_JOURNAL_OBSERVATION_ID IN INTEGER
)
AS
BEGIN
  UPDATE JOURNAL_OBSERVATIONS 
     SET JOURNAL_OBSERVATION_ID=U_JOURNAL_OBSERVATION.JOURNAL_OBSERVATION_ID,
         JOURNAL_FIELD_ID=U_JOURNAL_OBSERVATION.JOURNAL_FIELD_ID,
         INSTRUMENT_ID=U_JOURNAL_OBSERVATION.INSTRUMENT_ID,
         MEASURE_TYPE_ID=U_JOURNAL_OBSERVATION.MEASURE_TYPE_ID,
         MEASURE_UNIT_ID=U_JOURNAL_OBSERVATION.MEASURE_UNIT_ID,
         DATE_OBSERVATION=U_JOURNAL_OBSERVATION.DATE_OBSERVATION,
         CYCLE_ID=U_JOURNAL_OBSERVATION.CYCLE_ID,
         POINT_ID=U_JOURNAL_OBSERVATION.POINT_ID,
         PARAM_ID=U_JOURNAL_OBSERVATION.PARAM_ID,
         VALUE=U_JOURNAL_OBSERVATION.VALUE,
         WHO_ENTER=U_JOURNAL_OBSERVATION.WHO_ENTER,
         DATE_ENTER=U_JOURNAL_OBSERVATION.DATE_ENTER,
         ALGORITHM_ID=U_JOURNAL_OBSERVATION.ALGORITHM_ID,
		 GROUP_ID=U_JOURNAL_OBSERVATION.GROUP_ID,
		 PRIORITY=U_JOURNAL_OBSERVATION.PRIORITY
   WHERE JOURNAL_OBSERVATION_ID=OLD_JOURNAL_OBSERVATION_ID;
  COMMIT;        
END;

--

/* �������� ��������� �������� ������ � ������� ���������� */

CREATE OR REPLACE PROCEDURE D_JOURNAL_OBSERVATION
(
  OLD_JOURNAL_OBSERVATION_ID IN INTEGER
)
AS
BEGIN
  DELETE FROM JOURNAL_OBSERVATIONS
        WHERE JOURNAL_OBSERVATION_ID=OLD_JOURNAL_OBSERVATION_ID;
  COMMIT;        
END;

--

/* �������� ��������� �� */

COMMIT