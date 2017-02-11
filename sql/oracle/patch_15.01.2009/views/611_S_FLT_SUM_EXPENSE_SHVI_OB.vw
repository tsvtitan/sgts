/* Создание просмотра суммирования расхода фильтрации по швам OB */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_SHVI_OB
AS 
SELECT   CYCLE_NUM,
         SUM (EXPENSE) EXPENSE_OB
    FROM S_FLT_SUM_EXPENSE_SHVI
   WHERE COORDINATE_Z IN (131, 153)
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


