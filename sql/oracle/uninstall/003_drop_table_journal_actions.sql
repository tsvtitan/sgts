/* Удаление просмотра таблицы журнала действий */

DROP VIEW S_JOURNAL_ACTIONS

--

/* Удаление процедуры создания записи в журнале действий */

DROP PROCEDURE I_JOURNAL_ACTION

--

/* Удаление процедуры изменения записи в журнале действий */

DROP PROCEDURE U_JOURNAL_ACTION

--

/* Удаление процедуры удаления записи в журнале действий */

DROP PROCEDURE D_JOURNAL_ACTION

--

/* Удаление последовательности для таблицы журнала действий */

DROP SEQUENCE SEQ_JOURNAL_ACTIONS

--

/* Удаление функции генерации для таблицы журнала действий */

DROP FUNCTION GET_JOURNAL_ACTION_ID

--

/* Удаление таблицы журнала действий */

DROP TABLE JOURNAL_ACTIONS

--

/* Фиксация изменений БД */

COMMIT
