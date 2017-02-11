/* Удаление просмотра таблицы полевого журнала */

DROP VIEW S_JOURNAL_FIELDS

--

/* Удаление процедуры утверждения полевого журнала */

DROP PROCEDURE CONFIRM_JOURNAL_FIELD

--

/* Удаление процедуры создания записи в полевом журнале */

DROP PROCEDURE I_JOURNAL_FIELD

--

/* Удаление процедуры изменения записи в полевом журнале */

DROP PROCEDURE U_JOURNAL_FIELD

--

/* Удаление процедуры удаления записи в полевом журнале */

DROP PROCEDURE D_JOURNAL_FIELD

--

/* Удаление последовательности для таблицы полевого журнала */

DROP SEQUENCE SEQ_JOURNAL_FIELDS

--

/* Удаление функции генерации для таблицы полевого журнала */

DROP FUNCTION GET_JOURNAL_FIELD_ID

--

/* Удаление таблицы полевого журнала */

DROP TABLE JOURNAL_FIELDS

--

/* Фиксация изменений БД */

COMMIT
