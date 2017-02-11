/* —оздание просмотра полевого журнала новых данных гидрометеорологии */

CREATE OR REPLACE VIEW S_GMO_JOURNAL_FIELDS_NEW
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
       V_VAULT
  FROM TABLE (GET_GMO_JOURNAL_FIELDS (0))


--

/* ‘иксаци€ изменений */

COMMIT


