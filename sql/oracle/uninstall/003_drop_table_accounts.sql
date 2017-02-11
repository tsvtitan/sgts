/* Удаление просмотра таблицы учетные записи */

DROP VIEW S_ACCOUNTS

--

/* Удаление процедуры создания учетной записи */

DROP PROCEDURE I_ACCOUNT

--

/* Удаление процедуры изменения учетной записи */

DROP PROCEDURE U_ACCOUNT

--

/* Удаление процедуры удаления учетной записи */

DROP PROCEDURE D_ACCOUNT

--

/* Удаление просмотра ролей */

DROP VIEW S_ROLES

--

/* Удаление процедуры создания роли */

DROP PROCEDURE I_ROLE


--

/* Удаление процедуры изменения роли */

DROP PROCEDURE U_ROLE

--

/* Удаление процедуры удаления роли */

DROP PROCEDURE D_ROLE

--

/* Удаление последовательности для таблицы учетные записи */

DROP SEQUENCE SEQ_ACCOUNTS

--

/* Удаление функции генерации для таблицы учетные записи */

DROP FUNCTION GET_ACCOUNT_ID

--

/* Удаление таблицы учетные записи */

DROP TABLE ACCOUNTS

--


/* Фиксация изменений БД */

COMMIT