/* Создание просмотра суммирования расхода фильтрации DR1 OB */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_DR1_OB
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE_OB
    FROM S_FLT_SUM_EXPENSE_DR1
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


