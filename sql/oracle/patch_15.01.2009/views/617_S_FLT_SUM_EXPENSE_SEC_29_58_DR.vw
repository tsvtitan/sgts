/* Создание просмотра суммирования расхода фильтрации по секциям 29-58 DR */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_SEC_29_58_DR
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE
    FROM S_FLT_SUM_EXPENSE_DR1
   WHERE SECTION NOT IN ('08')
     AND COORDINATE_Z = 131
GROUP BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


