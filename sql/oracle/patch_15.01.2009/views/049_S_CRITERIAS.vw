/* �������� ��������� ��������� ������������ */

CREATE OR REPLACE VIEW S_CRITERIAS
AS 
SELECT C.CRITERIA_ID,
       C.ALGORITHM_ID,
       C.MEASURE_UNIT_ID,
       C.NAME,
       C.DESCRIPTION,
       C.FIRST_MIN_VALUE,
       C.FIRST_MAX_VALUE,
       C.FIRST_MODULO,
       C.SECOND_MIN_VALUE,
       C.SECOND_MAX_VALUE,
       C.SECOND_MODULO,
       C.ENABLED,
       C.PRIORITY,
       A.NAME AS ALGORITHM_NAME,
       A.PROC_NAME,
       M.NAME AS MEASURE_UNIT_NAME
  FROM CRITERIAS C,
       ALGORITHMS A,
       MEASURE_UNITS M
 WHERE C.ALGORITHM_ID = A.ALGORITHM_ID
   AND C.MEASURE_UNIT_ID = M.MEASURE_UNIT_ID(+)

--

/* �������� ��������� */

COMMIT

