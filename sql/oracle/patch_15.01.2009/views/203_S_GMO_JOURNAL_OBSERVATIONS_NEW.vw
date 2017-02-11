/* —оздание просмотра журнала наблюдений новых данных гидрометеорологии */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_OBSERVATIONS_NEW
AS
SELECT CYCLE_ID,
       CYCLE_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       UVB,
       UNB,
       T_AIR,
       T_WATER,
       RAIN_DAY,
       PREC,
       UNSET,
       INFLUX,
       V_VAULT,
       UVB_INC,
       RAIN_YEAR,
       T_AIR_10,
       T_AIR_30
  FROM TABLE (GET_GMO_JOURNAL_OBSERVATIONS (0))


--

/* ‘иксаци€ изменений */

COMMIT


