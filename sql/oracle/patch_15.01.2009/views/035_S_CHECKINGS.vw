/* �������� ��������� */

CREATE OR REPLACE VIEW S_CHECKINGS
AS 
SELECT C.CHECKING_ID,
       C.MEASURE_TYPE_ID,
       C.POINT_ID,
       C.PARAM_ID,
       C.NAME,
       C.DESCRIPTION,
       C.PRIORITY,
       C.ALGORITHM_ID,
       C.ENABLED,
       MT.NAME AS MEASURE_TYPE_NAME,
       MT2.PATH AS MEASURE_TYPE_PATH,
       A.NAME AS ALGORITHM_NAME,
       A.PROC_NAME,
       PT.NAME AS POINT_NAME,
       P.NAME AS PARAM_NAME
  FROM CHECKINGS C,
       MEASURE_TYPES MT,
       ALGORITHMS A,
       PARAMS P,
       POINTS PT,
       (SELECT     MT.MEASURE_TYPE_ID,
                   SUBSTR (MAX (SYS_CONNECT_BY_PATH (MT.NAME, '\')), 2) AS PATH
              FROM MEASURE_TYPES MT
        START WITH MT.PARENT_ID IS NULL
        CONNECT BY MT.PARENT_ID = PRIOR MT.MEASURE_TYPE_ID
          GROUP BY MT.MEASURE_TYPE_ID) MT2
 WHERE C.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID
   AND C.ALGORITHM_ID = A.ALGORITHM_ID
   AND C.PARAM_ID = P.PARAM_ID
   AND MT.MEASURE_TYPE_ID = MT2.MEASURE_TYPE_ID
   AND C.POINT_ID = PT.POINT_ID(+)

--

/* �������� ��������� */

COMMIT

