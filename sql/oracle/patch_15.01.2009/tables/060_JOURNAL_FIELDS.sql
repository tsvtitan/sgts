/* �������� ������� �������� ������� */

CREATE TABLE JOURNAL_FIELDS
(
  JOURNAL_FIELD_ID INTEGER NOT NULL,
  CYCLE_ID INTEGER NOT NULL,
  POINT_ID INTEGER NOT NULL,
  PARAM_ID INTEGER NOT NULL,
  INSTRUMENT_ID INTEGER,
  MEASURE_UNIT_ID INTEGER,
  VALUE FLOAT NOT NULL,
  WHO_ENTER INTEGER NOT NULL,
  DATE_ENTER DATE NOT NULL,
  WHO_CONFIRM INTEGER,
  DATE_CONFIRM DATE,
  DATE_OBSERVATION DATE NOT NULL,
  GROUP_ID VARCHAR2(32) NOT NULL,
  PRIORITY INTEGER NOT NULL,
  IS_BASE INTEGER NOT NULL,
  MEASURE_TYPE_ID NOT NULL,
  JOURNAL_NUM VARCHAR2(100),
  NOTE VARCHAR2(250),
  PARENT_ID INTEGER,
  IS_CHECK INTEGER NOT NULL,
  PRIMARY KEY (JOURNAL_FIELD_ID),
  FOREIGN KEY (CYCLE_ID) REFERENCES CYCLES (CYCLE_ID),
  FOREIGN KEY (POINT_ID) REFERENCES POINTS (POINT_ID),
  FOREIGN KEY (PARAM_ID) REFERENCES PARAMS (PARAM_ID),
  FOREIGN KEY (INSTRUMENT_ID) REFERENCES INSTRUMENTS (INSTRUMENT_ID),
  FOREIGN KEY (MEASURE_UNIT_ID) REFERENCES MEASURE_UNITS (MEASURE_UNIT_ID),
  FOREIGN KEY (MEASURE_TYPE_ID) REFERENCES MEASURE_TYPES (MEASURE_TYPE_ID),
  FOREIGN KEY (WHO_ENTER) REFERENCES PERSONNELS (PERSONNEL_ID),
  FOREIGN KEY (WHO_CONFIRM) REFERENCES PERSONNELS (PERSONNEL_ID)
) 

--

/* �������� ������� �� ���� ���������� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_1
 ON JOURNAL_FIELDS(DATE_OBSERVATION)

--

/* �������� ������� �� ������ �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_2
 ON JOURNAL_FIELDS(GROUP_ID)

--

/* �������� ������� �� ���������� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_3
 ON JOURNAL_FIELDS(PRIORITY)

--

/* �������� ������� �� ��������� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_4
 ON JOURNAL_FIELDS(PARAM_ID)

--

/* �������� ������� �� ����� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_5
 ON JOURNAL_FIELDS(CYCLE_ID)

--

/* �������� ������� �� ������� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_6
 ON JOURNAL_FIELDS(INSTRUMENT_ID)

--

/* �������� ������� �� ���� ��������� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_7
 ON JOURNAL_FIELDS(MEASURE_TYPE_ID)

--

/* �������� ������� �� ������� ��������� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_8
 ON JOURNAL_FIELDS(MEASURE_UNIT_ID)

--

/* �������� ������� �� ����� �������� ������� */

CREATE INDEX IDX_JOURNAL_FIELDS_9
 ON JOURNAL_FIELDS(POINT_ID)

--

/* �������� ������� �� ������ �������� ������� */

CREATE BITMAP INDEX IDX_JOURNAL_FIELDS_10
 ON JOURNAL_FIELDS (EXTRACT(MONTH FROM DATE_OBSERVATION))

--

/* �������� ������� �� ���� �������� ������� */

CREATE BITMAP INDEX IDX_JOURNAL_FIELDS_11
 ON JOURNAL_FIELDS (EXTRACT(YEAR FROM DATE_OBSERVATION))

--

/* �������� ��������� */

COMMIT