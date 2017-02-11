/* —оздание просмотра журнала наблюдений новых данных индикаторов прогиба */

CREATE OR REPLACE VIEW S_IND_JOURNAL_OBSERVATIONS_N
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       JOURNAL_NUM,
       DATE_OBSERVATION,
       POINT_ID,
       POINT_NAME,
       CONVERTER_ID,
       CONVERTER_NAME,
       OBJECT_PATHS,
       OBJECT_PRIORITY,
       COORDINATE_Z,
       INDICATOR_TYPE,
       VALUE,
       OFFSET_BEGIN,
       CURRENT_OFFSET
  FROM TABLE (GET_IND_JOURNAL_OBSERVATIONS (0))

--

/* ‘иксаци€ изменений */

COMMIT

