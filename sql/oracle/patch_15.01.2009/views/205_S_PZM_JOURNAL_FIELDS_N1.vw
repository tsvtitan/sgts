/* Создание просмотра Веерных пьезометров в полевом журнале новых данных */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_N1
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
       INSTRUMENT_ID,
       INSTRUMENT_NAME,
       VALUE,
       OBJECT_PATHS,
       COORDINATE_Z
  FROM TABLE (GET_PZM_JOURNAL_FIELDS (2561, 0))


--

/* Фиксация изменений */

COMMIT


