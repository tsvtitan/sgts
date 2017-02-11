/* —оздание просмотра журнала наблюдений новых данных нивелировани€ */

CREATE OR REPLACE VIEW S_NIV_JOURNAL_OBSERVATIONS_N
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       ROUTE_ID,
       COORDINATE_Z,
       DISPLACE,
       CUR_DISPLACE,
       CONVERTER_ID,
       CONVERTER_NAME,
       DESCRIPTION,
       OBJECT_PATHS,
       OBJECT_PRIORITY
  FROM TABLE (GET_NIV_JOURNAL_OBSERVATIONS (50000, 0))


--

/* ‘иксаци€ изменений */

COMMIT


