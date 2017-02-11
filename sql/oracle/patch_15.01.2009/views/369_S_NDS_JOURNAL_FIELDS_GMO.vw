/* Создание просмотра полевого журнала напряженно-деформированного состояния вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_NDS_JOURNAL_FIELDS_GMO
AS
SELECT NDS.CYCLE_ID,
       NDS.CYCLE_NUM,
       NDS.JOURNAL_NUM,
       NDS.DATE_OBSERVATION,
       NDS.MEASURE_TYPE_ID,
       NDS.POINT_ID,
       NDS.POINT_NAME,
       NDS.COORDINATE_Z,
       NDS.CONVERTER_ID,
       NDS.CONVERTER_NAME,
       NDS.NOTE,
       NDS.TYPE_INSTRUMENT,
       NDS.VALUE_RESISTANCE_LINE,
       NDS.VALUE_RESISTANCE,
       NDS.VALUE_FREQUENCY,
       NDS.VALUE_PERIOD,
       NDS.VALUE_STATER_CARRIE,
       NDS.OBJECT_PATHS,
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
  FROM S_NDS_JOURNAL_FIELDS NDS,
       S_GMO_JOURNAL_FIELDS GMO
 WHERE NDS.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT


