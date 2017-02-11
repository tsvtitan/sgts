/* Удаление просмотра таблицы типов приборов */

DROP VIEW S_INSTRUMENT_TYPES

--

/* Удаление процедуры создания типа прибора */

DROP PROCEDURE I_INSTRUMENT_TYPE

--

/* Удаление процедуры изменения типа прибора */

DROP PROCEDURE U_INSTRUMENT_TYPE

--

/* Удаление процедуры удаления типа прибора */

DROP PROCEDURE D_INSTRUMENT_TYPE

--

/* Удаление последовательности для таблицы типов приборов */

DROP SEQUENCE SEQ_INSTRUMENT_TYPES

--

/* Удаление функции генерации для таблицы типов приборов */

DROP FUNCTION GET_INSTRUMENT_TYPE_ID

--

/* Удаление таблицы типов приборов */

DROP TABLE INSTRUMENT_TYPES

--

/* Фиксация изменений БД */

COMMIT