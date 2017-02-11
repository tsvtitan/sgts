/* �������� ��������� �������� ������� �������-����������� ������ */

CREATE OR REPLACE VIEW S_SOS_JOURNAL_FIELDS
AS
SELECT JFO.CYCLE_ID,JFO.CYCLE_NUM,JFO.JOURNAL_NUM,JFO.DATE_OBSERVATION,JFO.POINT_ID,JFO.POINT_NAME,JFO.CONVERTER_ID,
      JFO.CONVERTER_NAME,JFO.PLACE_ZERO,JFO.DIRECTION_MOVE,JFO.VALUE,JFO.DIFFERENCE_MOVE,JFO.ERROR_MARK,JFO.VALUE_AVERAGE,JFO.OBJECT_PATHS
    FROM S_SOS_JOURNAL_FIELDS_O JFO
   UNION
  SELECT JFN.CYCLE_ID,JFN.CYCLE_NUM,JFN.JOURNAL_NUM,JFN.DATE_OBSERVATION,JFN.POINT_ID,JFN.POINT_NAME,JFN.CONVERTER_ID,
     JFN.CONVERTER_NAME,JFN.PLACE_ZERO,JFN.DIRECTION_MOVE,JFN.VALUE,JFN.DIFFERENCE_MOVE,JFN.ERROR_MARK,JFN.VALUE_AVERAGE,JFN.OBJECT_PATHS
    FROM S_SOS_JOURNAL_FIELDS_N JFN

--

/* �������� ��������� */

COMMIT

