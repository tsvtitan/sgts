/* �������� ��������� ������������ ������� ���������� DR1 RUSL */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_DR1_RUSL
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE_RUSL
    FROM S_FLT_SUM_EXPENSE_DR1
   WHERE COORDINATE_Z IN (131, 153)
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM
--

/* �������� ��������� */

COMMIT

