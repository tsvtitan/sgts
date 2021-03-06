/* �������� ��������� �������� ������� 3 ����� ������ ����������-���������������� ��������� */

CREATE OR REPLACE VIEW S_NDS_JOURNAL_FIELDS_N3
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       JOURNAL_FIELD_ID,
       JOURNAL_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       COORDINATE_Z,
       CONVERTER_ID,
       CONVERTER_NAME,
       NOTE,
       TYPE_INSTRUMENT,
       VALUE_RESISTANCE_LINE,
       VALUE_RESISTANCE,
       VALUE_FREQUENCY,
       VALUE_PERIOD,
       VALUE_STATER_CARRIE,
       OBJECT_PATHS
  FROM TABLE (GET_NDS_JOURNAL_FIELDS (60003, 0))


--

/* �������� ��������� */

COMMIT


