/* Создание процедуры удаления единицы измерения */

CREATE OR REPLACE PROCEDURE D_MEASURE_UNIT
( 
  OLD_MEASURE_UNIT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM MEASURE_UNITS 
        WHERE MEASURE_UNIT_ID=OLD_MEASURE_UNIT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

