/* Создание просмотра журнала наблюдений гидрометеорологии */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_OBSERVATIONS
AS
SELECT JOO.CYCLE_ID,
       JOO.CYCLE_NUM,
       JOO.DATE_OBSERVATION,
       JOO.MEASURE_TYPE_ID,
       JOO.POINT_ID,
       JOO.UVB,
       JOO.UNB,
       JOO.T_AIR,
       JOO.T_WATER,
       JOO.RAIN_DAY,
       JOO.PREC,
       JOO.UNSET,
       JOO.INFLUX,
       JOO.V_VAULT,
       JOO.UVB_INC,
       JOO.RAIN_YEAR,
       JOO.T_AIR_10,
       JOO.T_AIR_30,
       (CASE
           WHEN JOO.PREC = 1
              THEN 'дождь'
           WHEN JOO.PREC = 2
              THEN 'снег'
           WHEN JOO.PREC = 3
              THEN 'снег+дождь'
           WHEN JOO.PREC = 4
              THEN 'б/осадков'
           ELSE ''
        END
       ) AS PREC_NAME
  FROM S_GMO_JOURNAL_OBSERVATIONS_OLD JOO
UNION
SELECT JON.CYCLE_ID,
       JON.CYCLE_NUM,
       JON.DATE_OBSERVATION,
       JON.MEASURE_TYPE_ID,
       JON.POINT_ID,
       JON.UVB,
       JON.UNB,
       JON.T_AIR,
       JON.T_WATER,
       JON.RAIN_DAY,
       JON.PREC,
       JON.UNSET,
       JON.INFLUX,
       JON.V_VAULT,
       JON.UVB_INC,
       JON.RAIN_YEAR,
       JON.T_AIR_10,
       JON.T_AIR_30,
       (CASE
           WHEN JON.PREC = 1
              THEN 'дождь'
           WHEN JON.PREC = 2
              THEN 'снег'
           WHEN JON.PREC = 3
              THEN 'снег+дождь'
           WHEN JON.PREC = 4
              THEN 'б/осадков'
           ELSE ''
        END
       ) AS PREC_NAME
  FROM S_GMO_JOURNAL_OBSERVATIONS_NEW JON

--

/* Фиксация изменений */

COMMIT


