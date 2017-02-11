/* Создание просмотра полевого журнала химанализа */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS
AS
SELECT JFO.CYCLE_ID,
       JFO.CYCLE_NUM,
       JFO.JOURNAL_NUM,
       JFO.DATE_OBSERVATION,
       JFO.MEASURE_TYPE_ID,
       JFO.POINT_ID,
       JFO.POINT_NAME,
       JFO.CONVERTER_ID,
       JFO.CONVERTER_NAME,
       JFO.MARK,
       JFO.PH,
       JFO.CO2SV,
       JFO.CO3_2,
       JFO.CO2AGG,
       JFO.ALKALI,
       JFO.ACERBITY,
       JFO.CA,
       JFO.MG,
       JFO.CL,
       JFO.SO4_2,
       JFO.HCO3,
       JFO.NA_K,
       JFO.AGGRESSIV,
       JFO.OBJECT_PATHS,
       JFO.SECTION_PRIORITY,
       JFO.COORDINATE_Z
  FROM S_HMZ_JOURNAL_FIELDS_O JFO
UNION
SELECT JFN.CYCLE_ID,
       JFN.CYCLE_NUM,
       JFN.JOURNAL_NUM,
       JFN.DATE_OBSERVATION,
       JFN.MEASURE_TYPE_ID,
       JFN.POINT_ID,
       JFN.POINT_NAME,
       JFN.CONVERTER_ID,
       JFN.CONVERTER_NAME,
       JFN.MARK,
       JFN.PH,
       JFN.CO2SV,
       JFN.CO3_2,
       JFN.CO2AGG,
       JFN.ALKALI,
       JFN.ACERBITY,
       JFN.CA,
       JFN.MG,
       JFN.CL,
       JFN.SO4_2,
       JFN.HCO3,
       JFN.NA_K,
       JFN.AGGRESSIV,
       JFN.OBJECT_PATHS,
       JFN.SECTION_PRIORITY,
       JFN.COORDINATE_Z
  FROM S_HMZ_JOURNAL_FIELDS_N JFN

--

/* Фиксация изменений */

COMMIT


