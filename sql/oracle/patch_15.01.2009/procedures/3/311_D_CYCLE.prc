/* Создание процедуры удаления цикла */

CREATE OR REPLACE PROCEDURE D_CYCLE
( 
  OLD_CYCLE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM CYCLES 
        WHERE CYCLE_ID=OLD_CYCLE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

