/* Удаление просмотра таблицы контроля */

DROP VIEW S_CHECKINGS

--

/* Удаление процедуры создания контроля */

DROP PROCEDURE I_CHECKING

--

/* Удаление процедуры изменения контроля */

DROP PROCEDURE U_CHECKING

--

/* Удаление процедуры удаления контроля */

DROP PROCEDURE D_CHECKING

--

/* Удаление последовательности для таблицы контроля */

DROP SEQUENCE SEQ_CHECKINGS

--

/* Удаление функции генерации для таблицы контроля */

DROP FUNCTION GET_CHECKING_ID

--

/* Удаление таблицы контроля */

DROP TABLE CHECKINGS

--

/* Фиксация изменений БД */

COMMIT