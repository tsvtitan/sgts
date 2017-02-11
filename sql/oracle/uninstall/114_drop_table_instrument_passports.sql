/* Удаление просмотра таблицы паспортов приборов */

DROP VIEW S_INSTRUMENT_PASSPORTS

--

/* Удаление процедуры создания паспорта прибора */

DROP PROCEDURE I_INSTRUMENT_PASSPORT

--

/* Удаление процедуры изменения паспорта прибора */

DROP PROCEDURE U_INSTRUMENT_PASSPORT

--

/* Удаление процедуры удаления паспорта прибора */

DROP PROCEDURE D_INSTRUMENT_PASSPORT

--

/* Удаление последовательности для таблицы паспортов приборов */

DROP SEQUENCE SEQ_INSTRUMENT_PASSPORTS

--

/* Удаление функции генерации для таблицы паспортов приборов */

DROP FUNCTION GET_INSTRUMENT_PASSPORT_ID

--

/* Удаление таблицы паспортов приборов */

DROP TABLE INSTRUMENT_PASSPORTS

--

/* Фиксация изменений БД */

COMMIT