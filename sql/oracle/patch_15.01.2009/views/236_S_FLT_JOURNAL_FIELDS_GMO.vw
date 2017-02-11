/* Создание просмотра полевого журнала  фильтрации вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_GMO
AS 
SELECT FLT.CYCLE_ID,
       FLT.CYCLE_NUM,
       FLT.JOURNAL_NUM,
       FLT.DATE_OBSERVATION,
       FLT.MEASURE_TYPE_ID,
       FLT.POINT_ID,
       FLT.POINT_NAME,
       FLT.CONVERTER_ID,
       FLT.CONVERTER_NAME,
       FLT.MARK,
       FLT.VOLUME,
       FLT.TIME,
       FLT.EXPENSE,
       FLT.T_WATER,
       FLT.OBJECT_PATHS,
       FLT.SECTION_PRIORITY,
       FLT.JOINT_PRIORITY,
       FLT.COORDINATE_Z,
       GMO.UVB,
       GMO.UNB,
       GMO.T_AIR,
       GMO.T_WATER AS GMO_T_WATER,
       GMO.RAIN_DAY,
       GMO.PREC,
       GMO.PREC_NAME,
       GMO.UNSET,
       GMO.INFLUX,
       GMO.V_VAULT
  FROM S_FLT_JOURNAL_FIELDS FLT,
       S_GMO_JOURNAL_FIELDS GMO
 WHERE FLT.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT


