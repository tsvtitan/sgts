/* Создание просмотра полевого журнала гидрометеорологии */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_FIELDS
AS 
SELECT JFO.CYCLE_ID,
       JFO.CYCLE_NUM,
       JFO.DATE_OBSERVATION,
       JFO.MEASURE_TYPE_ID,
       JFO.POINT_ID,
       JFO.UVB,
       JFO.UNB,
       JFO.T_AIR,
       JFO.T_WATER,
       JFO.RAIN_DAY,
       JFO.PREC,
       JFO.UNSET,
       JFO.INFLUX,
       JFO.V_VAULT,
       (CASE
           WHEN JFO.PREC = 1
              THEN 'дождь'
           WHEN JFO.PREC = 2
              THEN 'снег'
           WHEN JFO.PREC = 3
              THEN 'снег+дождь'
           WHEN JFO.PREC = 4
              THEN 'б/осадков'
           ELSE ''
        END
       ) AS PREC_NAME
  FROM S_GMO_JOURNAL_FIELDS_OLD JFO
UNION
SELECT JFN.CYCLE_ID,
       JFN.CYCLE_NUM,
       JFN.DATE_OBSERVATION,
       JFN.MEASURE_TYPE_ID,
       JFN.POINT_ID,
       JFN.UVB,
       JFN.UNB,
       JFN.T_AIR,
       JFN.T_WATER,
       JFN.RAIN_DAY,
       JFN.PREC,
       JFN.UNSET,
       JFN.INFLUX,
       JFN.V_VAULT,
       (CASE
           WHEN JFN.PREC = 1
              THEN 'дождь'
           WHEN JFN.PREC = 2
              THEN 'снег'
           WHEN JFN.PREC = 3
              THEN 'снег+дождь'
           WHEN JFN.PREC = 4
              THEN 'б/осадков'
           ELSE ''
        END
       ) AS PREC_NAME
  FROM S_GMO_JOURNAL_FIELDS_NEW JFN

--

/* Фиксация изменений */

COMMIT


