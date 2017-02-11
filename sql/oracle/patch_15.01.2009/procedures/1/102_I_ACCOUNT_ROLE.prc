/* Создание процедуры добавления роли учетной записи */

CREATE OR REPLACE PROCEDURE I_ACCOUNT_ROLE
( 
  ACCOUNT_ID IN INTEGER, 
  ROLE_ID IN INTEGER 
) 
AS 
BEGIN 
  INSERT INTO ACCOUNTS_ROLES (ACCOUNT_ID,ROLE_ID) 
       VALUES (ACCOUNT_ID,ROLE_ID); 
  COMMIT; 
END;

--

/* Фиксация изменений */

COMMIT
