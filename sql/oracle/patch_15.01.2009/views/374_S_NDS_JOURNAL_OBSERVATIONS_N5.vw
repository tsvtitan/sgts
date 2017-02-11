/* Создание просмотра журнала наблюдений 5 новых данных напряженно-деформированного состояния */

CREATE OR REPLACE VIEW S_NDS_JOURNAL_OBSERVATIONS_N5
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       CONVERTER_ID,
       CONVERTER_NAME,
       TYPE,
       COORDINATE_Z,
       VALUE_STATER_CARRIE,
       VALUE_EXERTION,
       VALUE_EXERTION_ACCOUNT,
       VALUE_TEMPERATURE,
       VALUE_OPENING,
       VALUE_RESISTANCE,
       VALUE_FREQUENCY,
       OBJECT_PATHS
  FROM TABLE (GET_NDS_JOURNAL_OBSERVATIONS (60005, 0))


--

/* Фиксация изменений */

COMMIT



