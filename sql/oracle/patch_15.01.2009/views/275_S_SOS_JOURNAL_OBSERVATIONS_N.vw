/* �������� ��������� ������� ���������� ����� ������ ��� �������-����������� ������ */

CREATE OR REPLACE VIEW S_SOS_JOURNAL_OBSERVATIONS_N
AS 
SELECT CYCLE_ID,CYCLE_NUM,DATE_OBSERVATION,POINT_ID,POINT_NAME,CONVERTER_ID,CONVERTER_NAME,PLACE_ZERO,DIRECTION_MOVE,
      VALUE,DIFFERENCE_MOVE,OFFSET_MARK_BEGIN_OBSERV,OFFSET_MARK_CYCLE_ZERO,ERROR_MARK,VALUE_AVERAGE,CURRENT_OFFSET_MARK,OBJECT_PATHS
FROM TABLE(GET_SOS_JOURNAL_OBSERVATIONS(0))

--

/* �������� ��������� */

COMMIT

