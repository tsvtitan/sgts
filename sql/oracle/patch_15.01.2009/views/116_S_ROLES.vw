/* Создание просмотра ролей */

CREATE OR REPLACE VIEW S_ROLES
AS 
SELECT ACCOUNT_ID,
       PERSONNEL_ID,
       NAME,
       PASS,
       DESCRIPTION,
       DB_USER,
       DB_PASS,
       IS_ROLE,
       ADJUSTMENT
  FROM ACCOUNTS
 WHERE IS_ROLE = 1

--

/* Фиксация изменений */

COMMIT


