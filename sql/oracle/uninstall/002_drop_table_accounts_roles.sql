/* Удаление функции генерации для таблицы доступа к ролям */

DROP VIEW S_ACCOUNTS_ROLES

--

/* Удаление процедуры создания доступа к ролям */

DROP PROCEDURE I_ACCOUNT_ROLE

--

/* Удаление процедуры изменения доступа к ролям */

DROP PROCEDURE U_ACCOUNT_ROLE

--

/* Удаление процедуры удаления доступа к ролям */

DROP PROCEDURE D_ACCOUNT_ROLE

--

/* Удаление процедуры очистки доступа к ролям */

DROP PROCEDURE C_ACCOUNT_ROLE

--

/* Удаление последовательности для таблицы доступа к ролям */

DROP TABLE ACCOUNTS_ROLES

--

/* Фиксация изменений БД */

COMMIT