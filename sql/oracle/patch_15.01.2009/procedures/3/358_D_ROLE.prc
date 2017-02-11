/* Создание процедуры удаления роли */

CREATE OR REPLACE PROCEDURE D_ROLE
( 
  OLD_ACCOUNT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM ACCOUNTS 
        WHERE ACCOUNT_ID=OLD_ACCOUNT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

