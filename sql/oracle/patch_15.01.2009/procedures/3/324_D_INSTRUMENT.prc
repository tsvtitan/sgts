/* Создание процедуры удаления прибора */

CREATE OR REPLACE PROCEDURE D_INSTRUMENT
( 
  OLD_INSTRUMENT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM INSTRUMENTS 
        WHERE INSTRUMENT_ID=OLD_INSTRUMENT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

