/* Удаление просмотра таблицы прав */

DROP VIEW S_PERMISSIONS

--

/* Удаление процедуры создания права */

DROP PROCEDURE I_PERMISSION

--

/* Удаление процедуры изменения права */

DROP PROCEDURE U_PERMISSION

--

/* Удаление процедуры удаления права */

DROP PROCEDURE D_PERMISSION

--

/* Удаление последовательности для таблицы прав */

DROP SEQUENCE SEQ_PERMISSIONS

--

/* Удаление функции генерации для таблицы прав */

DROP FUNCTION GET_PERMISSION_ID

--

/* Удаление таблицы прав */

DROP TABLE PERMISSIONS

--


/* Фиксация изменений БД */

COMMIT
