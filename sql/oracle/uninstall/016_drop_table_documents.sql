/* Удаление просмотра таблицы документов */

DROP VIEW S_DOCUMENTS

--

/* Удаление процедуры создания документа */

DROP PROCEDURE I_DOCUMENT

--

/* Удаление процедуры изменения документа */

DROP PROCEDURE U_DOCUMENT

--

/* Удаление процедуры удаления документа */

DROP PROCEDURE D_DOCUMENT

--

/* Удаление последовательности для таблицы документов */

DROP SEQUENCE SEQ_DOCUMENTS

--

/* Удаление функции генерации для таблицы документов */

DROP FUNCTION GET_DOCUMENT_ID

--

/* Удаление таблицы документов */

DROP TABLE DOCUMENTS

--

/* Фиксация изменений БД */

COMMIT