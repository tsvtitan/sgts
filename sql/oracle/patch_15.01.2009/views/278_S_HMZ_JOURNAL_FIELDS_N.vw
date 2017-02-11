/* Создание просмотра полевого журнала новых данных химанализа */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_N
AS
SELECT CYCLE_ID,
       CYCLE_NUM,
       JOURNAL_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       CONVERTER_ID,
       CONVERTER_NAME,
       MARK,
       PH,
       CO2SV,
       CO3_2,
       CO2AGG,
       ALKALI,
       ACERBITY,
       CA,
       MG,
       CL,
       SO4_2,
       HCO3,
       NA_K,
       AGGRESSIV,
       OBJECT_PATHS,
       SECTION_PRIORITY,
       COORDINATE_Z
  FROM TABLE (GET_HMZ_JOURNAL_FIELDS (2600, 0))


--

/* Фиксация изменений */

COMMIT


