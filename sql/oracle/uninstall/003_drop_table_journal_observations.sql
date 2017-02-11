/* Удаление просмотра таблицы журнала наблюдений */

DROP VIEW S_JOURNAL_OBSERVATIONS

--

/* Удаление процедуры создания записи в журнале наблюдений */

DROP PROCEDURE I_JOURNAL_OBSERVATION

--

/* Удаление процедуры изменения записи в журнале наблюдений */

DROP PROCEDURE U_JOURNAL_OBSERVATION

--

/* Удаление процедуры удаления записи в журнале наблюдений */

DROP PROCEDURE D_JOURNAL_OBSERVATION

--

/* Удаление последовательности для таблицы журнала наблюдений */

DROP SEQUENCE SEQ_JOURNAL_OBSERVATIONS

--

/* Удаление функции генерации для таблицы журнала наблюдений */

DROP FUNCTION GET_JOURNAL_OBSERVATION_ID

--

/* Удаление таблицы журнала наблюдений */

DROP TABLE JOURNAL_OBSERVATIONS

--

/* Фиксация изменений БД */

COMMIT
