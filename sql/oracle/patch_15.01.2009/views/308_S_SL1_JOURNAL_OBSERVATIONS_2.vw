/* �������� ��������� ������������� � ������� ���������� ��������� ��������� */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_OBSERVATIONS_2
AS
SELECT JOO2.CYCLE_ID, JOO2.CYCLE_NUM, JOO2.JOURNAL_NUM, JOO2.DATE_OBSERVATION,
       JOO2.MEASURE_TYPE_ID, JOO2.POINT_ID, JOO2.POINT_NAME,
       JOO2.CONVERTER_ID, JOO2.CONVERTER_NAME, JOO2.OBJECT_PATHS,
       JOO2.SECTION_JOINT_PRIORITY, JOO2.AXES_PRIORITY, JOO2.SECTION_PRIORITY,
       JOO2.OUTFALL_PRIORITY, JOO2.COORDINATE_Z, JOO2.VALUE, JOO2.OPENING,
       JOO2.CURRENT_OPENING, JOO2.CYCLE_NULL_OPENING
  FROM S_SL1_JOURNAL_OBSERVATIONS_O2 JOO2
UNION
SELECT JON2.CYCLE_ID, JON2.CYCLE_NUM, JON2.JOURNAL_NUM, JON2.DATE_OBSERVATION,
       JON2.MEASURE_TYPE_ID, JON2.POINT_ID, JON2.POINT_NAME,
       JON2.CONVERTER_ID, JON2.CONVERTER_NAME, JON2.OBJECT_PATHS,
       JON2.SECTION_JOINT_PRIORITY, JON2.AXES_PRIORITY, JON2.SECTION_PRIORITY,
       JON2.OUTFALL_PRIORITY, JON2.COORDINATE_Z, JON2.VALUE, JON2.OPENING,
       JON2.CURRENT_OPENING, JON2.CYCLE_NULL_OPENING
  FROM S_SL1_JOURNAL_OBSERVATIONS_N2 JON2

--

/* �������� ��������� */

COMMIT

