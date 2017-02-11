/* Создание просмотра плана-графика полевого журнала */

CREATE OR REPLACE VIEW S_PLAN_GRAPH_JF
AS 
SELECT   C.CYCLE_ID,
         JF.MEASURE_TYPE_ID,
         MIN (JF.CYCLE_NUM) AS CYCLE_NUM
    FROM CYCLES C,
         S_JOURNAL_FIELDS JF
   WHERE C.CYCLE_ID = JF.CYCLE_ID
GROUP BY C.CYCLE_ID,
         JF.MEASURE_TYPE_ID

--

/* Фиксация изменений */

COMMIT


