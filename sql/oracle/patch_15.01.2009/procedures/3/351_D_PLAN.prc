/* Создание процедуры удаления плана */

CREATE OR REPLACE PROCEDURE D_PLAN
( 
  OLD_MEASURE_TYPE_ID IN INTEGER, 
  OLD_CYCLE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM PLANS 
        WHERE MEASURE_TYPE_ID=OLD_MEASURE_TYPE_ID 
          AND CYCLE_ID=OLD_CYCLE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

