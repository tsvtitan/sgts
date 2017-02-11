/* Создание процедуры удаления роли у учетной записи */

CREATE OR REPLACE PROCEDURE D_ACCOUNT_ROLE
( 
  OLD_ACCOUNT_ID IN INTEGER, 
  OLD_ROLE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM ACCOUNTS_ROLES 
        WHERE ACCOUNT_ID=OLD_ACCOUNT_ID 
          AND ROLE_ID=OLD_ROLE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

