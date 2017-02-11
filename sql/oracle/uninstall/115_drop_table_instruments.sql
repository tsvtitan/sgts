/* Удаление просмотра таблицы приборов */

DROP VIEW S_INSTRUMENTS

--

/* Удаление процедуры создания прибора */

DROP PROCEDURE I_INSTRUMENT

--

/* Удаление процедуры изменения прибора */

DROP PROCEDURE U_INSTRUMENT

--

/* Удаление процедуры удаления прибора */

DROP PROCEDURE D_INSTRUMENT

--

/* Удаление последовательности для таблицы приборов */

DROP SEQUENCE SEQ_INSTRUMENTS

--

/* Удаление функции генерации для таблицы приборов */

DROP FUNCTION GET_INSTRUMENT_ID

--

/* Удаление таблицы приборов */

DROP TABLE INSTRUMENTS

--

/* Фиксация изменений БД */

COMMIT