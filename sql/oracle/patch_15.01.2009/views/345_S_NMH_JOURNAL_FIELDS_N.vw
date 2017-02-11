/* —оздание просмотра полевого журнала нивелировани€ марок гидронивелира N */

CREATE OR REPLACE VIEW S_NMH_JOURNAL_FIELDS_N
AS
SELECT CYCLE_ID,
       CYCLE_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       CONVERTER_ID,
       CONVERTER_NAME,
       VALUE_COORDINATE_Z,
       HDN_NUMBER,
       OBJECT_PATHS
  FROM TABLE (GET_NMH_JOURNAL_FIELDS (49985, 0))

--

/* ‘иксаци€ изменений */

COMMIT


