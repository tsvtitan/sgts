/* �������� ��������� ������ */

CREATE OR REPLACE VIEW S_CYCLES
AS 
SELECT C.CYCLE_ID,C.CYCLE_NUM,C.CYCLE_YEAR,C.CYCLE_MONTH,C.DESCRIPTION,C.IS_CLOSE
  FROM CYCLES C

--

/* �������� ��������� */

COMMIT


