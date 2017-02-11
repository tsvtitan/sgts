/* —оздание просмотра полевого журнала новых данных планово-высотного обосновани€ */

CREATE OR REPLACE VIEW S_PVO_JOURNAL_FIELDS_N
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
       H,
       X,
       Y,
       CONVERTER_ID,
       CONVERTER_NAME,
       NOTE,
       DESCRIPTION,
       OBJECT_PATHS,
       OBJECT_PRIORITY
  FROM TABLE (GET_PVO_JOURNAL_FIELDS (50001, 0))

--

/* ‘иксаци€ изменений */

COMMIT


