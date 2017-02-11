/* Создание просмотра суммирования расхода фильтрации по секциям 29-58 VO */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_SEC_29_58_VO
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE
    FROM S_FLT_JOURNAL_OBSERVATIONS_5
   WHERE POINT_ID = 3500
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


