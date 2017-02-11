/* Создание просмотра Веерных пьезометров в журнале наблюдений новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_OBSERVATIONS_N1
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       CONVERTER_ID,
       CONVERTER_NAME,
       MARK_HEAD,
       PRESSURE_ACTIVE,
       MARK_WATER,
       PRESSURE_OPPOSE,
       PRESSURE_BROUGHT,
       OBJECT_PATHS,
       SECTION_PRIORITY,
       COORDINATE_Z
  FROM TABLE (GET_PZM_JOURNAL_OBSERVATIONS (2561, 0))

--

/* Фиксация изменений */

COMMIT


