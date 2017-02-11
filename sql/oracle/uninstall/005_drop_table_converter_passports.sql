/* Удаление просмотра таблицы паспортов пребразователей */

DROP VIEW S_CONVERTER_PASSPORTS

--

/* Удаление процедуры создания паспорта пребразователя */

DROP PROCEDURE I_CONVERTER_PASSPORT

--

/* Удаление процедуры изменения паспорта пребразователя */

DROP PROCEDURE U_CONVERTER_PASSPORT

--

/* Удаление процедуры удаления паспорта пребразователя */

DROP PROCEDURE D_CONVERTER_PASSPORT

--

/* Удаление последовательности для таблицы паспортов пребразователей */

DROP SEQUENCE SEQ_CONVERTER_PASSPORTS

--

/* Удаление функции генерации для таблицы паспортов пребразователей */

DROP FUNCTION GET_CONVERTER_PASSPORT_ID

--

/* Удаление таблицы паспортов пребразователей */

DROP TABLE CONVERTER_PASSPORTS

--

/* Фиксация изменений БД */

COMMIT