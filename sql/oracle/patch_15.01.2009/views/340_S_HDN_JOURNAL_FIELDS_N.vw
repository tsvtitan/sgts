/* —оздание просмотра полевого журнала новых данных гидронивелиров */

CREATE OR REPLACE VIEW S_HDN_JOURNAL_FIELDS_N
AS 
SELECT CYCLE_ID,
       CYCLE_NUM,
       JOURNAL_NUM,
       JOURNAL_FIELD_ID,
       DATE_OBSERVATION,
       MEASURE_TYPE_ID,
       POINT_ID,
       POINT_NAME,
       CONVERTER_ID,
       CONVERTER_NAME,
       VALUE_MOTION_FORWARD,
       VALUE_MOTION_BACK,
       VALUE_AVERAGE,
       VALUE_ERROR,
       DATE_MOTION_BACK,
       HDN_NAME,
       HDN_NUMBER,
       OBJECT_SHORT_NAME
  FROM TABLE (GET_HDN_JOURNAL_FIELDS (49984, 0))


--

/* ‘иксаци€ изменений */

COMMIT


