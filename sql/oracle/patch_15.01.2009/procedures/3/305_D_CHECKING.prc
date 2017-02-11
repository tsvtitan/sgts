/* Создание процедуры удаления контроля */

CREATE OR REPLACE PROCEDURE D_CHECKING
( 
  OLD_CHECKING_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM CHECKINGS 
        WHERE CHECKING_ID=OLD_CHECKING_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

