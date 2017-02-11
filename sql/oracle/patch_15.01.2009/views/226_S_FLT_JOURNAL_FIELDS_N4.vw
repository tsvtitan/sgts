/* Создание просмотра полевого журнала 4 новых данных фильтрации */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_N4
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
       MARK,
       VOLUME,
       TIME,
       EXPENSE,
       T_WATER,
       OBJECT_PATHS,
       SECTION_PRIORITY,
       JOINT_PRIORITY,
       COORDINATE_Z
  FROM TABLE (GET_FLT_JOURNAL_FIELDS (2584, 0))

--

/* Фиксация изменений */

COMMIT


