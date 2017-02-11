/* Создание просмотра таблицы учетные записи */

CREATE OR REPLACE VIEW S_ACCOUNTS
AS 
SELECT A.ACCOUNT_ID,
       A.PERSONNEL_ID,
       A.NAME,
       A.PASS,
       A.DESCRIPTION,
       A.DB_USER,
       A.DB_PASS,
       A.IS_ROLE,
       A.ADJUSTMENT,
       P.FNAME || ' ' || P.NAME || ' ' || P.SNAME AS PERSONNEL_NAME,
       P.FNAME AS FIRST_NAME,
       P.NAME AS SECOND_NAME,
       P.SNAME AS LAST_NAME
  FROM ACCOUNTS A,
       PERSONNELS P
 WHERE A.PERSONNEL_ID = P.PERSONNEL_ID(+)
   AND IS_ROLE = 0

--

/* Фиксация изменений */

COMMIT
