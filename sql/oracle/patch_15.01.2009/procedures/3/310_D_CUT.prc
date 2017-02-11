/* Создание процедуры удаления среза */

CREATE OR REPLACE PROCEDURE D_CUT
( 
  OLD_CUT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM CUTS 
        WHERE CUT_ID=OLD_CUT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

