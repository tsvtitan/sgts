/* Создание просмотра журнала наблюдений химанализа вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_OBSERVATIONS_GMO
AS 
SELECT HMZ.CYCLE_ID,
       HMZ.CYCLE_NUM,
       HMZ.JOURNAL_NUM,
       HMZ.DATE_OBSERVATION,
       HMZ.MEASURE_TYPE_ID,
       HMZ.POINT_ID,
       HMZ.POINT_NAME,
       HMZ.CONVERTER_ID,
       HMZ.CONVERTER_NAME,
       HMZ.MARK,
       HMZ.PH,
       HMZ.CO2SV,
       HMZ.CO3_2,
       HMZ.CO2AGG,
       HMZ.ALKALI,
       HMZ.ACERBITY,
       HMZ.CA,
       HMZ.MG,
       HMZ.CL,
       HMZ.SO4_2,
       HMZ.HCO3,
       HMZ.NA_K,
       HMZ.AGGRESSIV,
       HMZ.OBJECT_PATHS,
       HMZ.OBJECT_PRIORITY,
       HMZ.COORDINATE_Z,
       GMO.UVB,
       GMO.UNB,
       GMO.T_AIR,
       GMO.T_WATER,
       GMO.RAIN_DAY,
       GMO.PREC,
       GMO.PREC_NAME,
       GMO.UNSET,
       GMO.INFLUX,
       GMO.V_VAULT,
       GMO.UVB_INC,
       GMO.RAIN_YEAR,
       GMO.T_AIR_10,
       GMO.T_AIR_30
  FROM S_HMZ_JOURNAL_OBSERVATIONS HMZ,
       S_GMO_JOURNAL_OBSERVATIONS GMO
 WHERE HMZ.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT


