/* Создание процедуры удаления параметра у вида измерения */

CREATE OR REPLACE PROCEDURE D_MEASURE_TYPE_PARAM
( 
  OLD_MEASURE_TYPE_ID IN INTEGER, 
  OLD_PARAM_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM MEASURE_TYPE_PARAMS 
        WHERE MEASURE_TYPE_ID=OLD_MEASURE_TYPE_ID 
          AND PARAM_ID=OLD_PARAM_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

