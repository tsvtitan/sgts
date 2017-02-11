/* Создание просмотра журнала наблюдений новых данных планово-высотного обоснования */

CREATE OR REPLACE VIEW S_PVO_JOURNAL_OBSERVATIONS_N
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       ROUTE_ID,
       H,
       H_DISPLACE,
       H_CUR_DISPLACE,
       X,
       X_DISPLACE,
       X_CUR_DISPLACE,
       Y,
       Y_DISPLACE,
       Y_CUR_DISPLACE,
       CONVERTER_ID,
       CONVERTER_NAME,
       DESCRIPTION,
       OBJECT_PATHS,
       OBJECT_PRIORITY
  FROM TABLE (GET_PVO_JOURNAL_OBSERVATIONS (50001, 0))

--

/* Фиксация изменений */

COMMIT


