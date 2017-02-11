/* Создание просмотра суммирования расхода фильтрации DR2 OB */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_DR2_OB
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE_OB
    FROM S_FLT_SUM_EXPENSE_DR2
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


