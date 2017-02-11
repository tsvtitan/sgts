/* Создание процедуры удаления вида измерения */

CREATE OR REPLACE PROCEDURE D_MEASURE_TYPE
( 
  OLD_MEASURE_TYPE_ID IN INTEGER 
) 
AS 
BEGIN 
  D_MEASURE_TYPE_EX (OLD_MEASURE_TYPE_ID); 
  COMMIT; 
END;

--

/* Фиксация изменений */

COMMIT

