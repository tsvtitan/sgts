/* Создание просмотра полевого журнала с ошибкой для струнно-оптического створа */

CREATE OR REPLACE VIEW S_SOS_JOURNAL_FIELDS_ERR_MARK
AS 
SELECT   jf.CYCLE_ID, jf.CYCLE_NUM, jf.JOURNAL_NUM, 
            jf.DATE_OBSERVATION, jf.POINT_ID, jf.POINT_NAME, 
            jf.CONVERTER_ID, jf.CONVERTER_NAME, jf.PLACE_ZERO, 
            jf.DIRECTION_MOVE, jf.VALUE, jf.DIFFERENCE_MOVE, 
            jf.OBJECT_PATHS,jf.error_mark, jf.value_average
       FROM s_sos_journal_fields jf

--

/* Фиксация изменений */

COMMIT


