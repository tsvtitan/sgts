/* Создание просмотра полевого журнала индикаторов прогиба вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_IND_JOURNAL_FIELDS_GMO
AS
SELECT IND.CYCLE_ID,
       IND.CYCLE_NUM,
       IND.JOURNAL_NUM,
       IND.DATE_OBSERVATION,
       IND.POINT_ID,
       IND.POINT_NAME,
       IND.CONVERTER_ID,
       IND.CONVERTER_NAME,
       IND.OBJECT_PATHS,
       IND.OBJECT_PRIORITY,
       IND.COORDINATE_Z,
       IND.INDICATOR_TYPE,
       IND.VALUE,
       IND.OFFSET_BEGIN,
       IND.CURRENT_OFFSET,
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
  FROM S_IND_JOURNAL_FIELDS IND,
       S_GMO_JOURNAL_FIELDS GMO
 WHERE IND.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT


