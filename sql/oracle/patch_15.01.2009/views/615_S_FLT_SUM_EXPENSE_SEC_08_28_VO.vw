/* Создание просмотра суммирования расхода фильтрации по секциям 08-28 VO */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_SEC_08_28_VO
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE
    FROM S_FLT_JOURNAL_OBSERVATIONS_5
   WHERE POINT_ID = 3499
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM


--

/* Фиксация изменений */

COMMIT


