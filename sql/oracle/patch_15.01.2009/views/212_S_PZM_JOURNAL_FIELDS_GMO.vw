/* Создание просмотра полевого журнала пьезометров вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_GMO
AS 
SELECT PZM.CYCLE_ID,
       PZM.CYCLE_NUM,
       PZM.JOURNAL_NUM,
       PZM.DATE_OBSERVATION,
       PZM.MEASURE_TYPE_ID,
       PZM.POINT_ID,
       PZM.POINT_NAME,
       PZM.CONVERTER_ID,
       PZM.CONVERTER_NAME,
       PZM.INSTRUMENT_ID,
       PZM.INSTRUMENT_NAME,
       PZM.VALUE,
       PZM.OBJECT_PATHS,
       PZM.COORDINATE_Z,
       GMO.UVB,
       GMO.UNB,
       GMO.T_AIR,
       GMO.T_WATER,
       GMO.RAIN_DAY,
       GMO.PREC,
       GMO.PREC_NAME,
       GMO.UNSET,
       GMO.INFLUX,
       GMO.V_VAULT
  FROM S_PZM_JOURNAL_FIELDS PZM,
       S_GMO_JOURNAL_FIELDS GMO
 WHERE PZM.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT

