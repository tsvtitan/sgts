/*  Создание процедуры очистки ролей учетной записи */

CREATE OR REPLACE PROCEDURE C_ACCOUNT_ROLE
( 
  OLD_ACCOUNT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM ACCOUNTS_ROLES 
        WHERE ACCOUNT_ID=OLD_ACCOUNT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

