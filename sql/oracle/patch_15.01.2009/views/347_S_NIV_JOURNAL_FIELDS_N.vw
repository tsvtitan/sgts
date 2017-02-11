/* Создание просмотра полевого журнала новых данных нивелирования */

CREATE OR REPLACE VIEW S_NIV_JOURNAL_FIELDS_N
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       JOURNAL_FIELD_ID,
       JOURNAL_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       ROUTE_ID,
       COORDINATE_Z,
       CONVERTER_ID,
       CONVERTER_NAME,
       NOTE,
       DESCRIPTION,
       OBJECT_PATHS,
       OBJECT_PRIORITY
  FROM TABLE (GET_NIV_JOURNAL_FIELDS (50000, 0))


--

/* Фиксация изменений */

COMMIT


