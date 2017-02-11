/* Создание просмотра гидрометеорологии с суммированием значений по циклам */

CREATE OR REPLACE VIEW S_GMO_CYCLE_VALUES
AS 
SELECT   CYCLE_NUM,
         ROUND (SUM (UVB) / COUNT (*) * 100) / 100 AS UVB,
         ROUND (SUM (UNB) / COUNT (*) * 100) / 100 AS UNB,
         ROUND (SUM (T_AIR) / COUNT (*) * 10) / 10 AS T_AIR,
         ROUND (SUM (T_WATER) / COUNT (*) * 10) / 10 AS T_WATER,
         ROUND (SUM (RAIN_DAY) / COUNT (*) * 10) / 10 AS RAIN_DAY,
         ROUND (SUM (UNSET) / COUNT (*)) AS UNSET,
         ROUND (SUM (INFLUX) / COUNT (*)) AS INFLUX,
         ROUND (SUM (V_VAULT) / COUNT (*) * 1000) / 1000 AS V_VAULT,
         ROUND (SUM (UVB_INC) / COUNT (*) * 100) / 100 AS UVB_INC,
         ROUND (SUM (RAIN_YEAR) / COUNT (*) * 10) / 10 AS RAIN_YEAR,
         ROUND (SUM (T_AIR_10) / COUNT (*) * 100) / 100 AS T_AIR_10,
         ROUND (SUM (T_AIR_30) / COUNT (*) * 100) / 100 AS T_AIR_30
    FROM S_GMO_JOURNAL_OBSERVATIONS
GROUP BY CYCLE_NUM
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


