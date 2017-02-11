/* Удаление просмотра таблицы паспортов объектов */

DROP VIEW S_OBJECT_PASSPORTS

--

/* Удаление процедуры создания паспорта объекта */

DROP PROCEDURE I_OBJECT_PASSPORT

--

/* Удаление процедуры изменения паспорта объекта */

DROP PROCEDURE U_OBJECT_PASSPORT

--

/* Удаление процедуры удаления паспорта объекта */

DROP PROCEDURE D_OBJECT_PASSPORT

--

/* Удаление последовательности для таблицы паспортов объектов */

DROP SEQUENCE SEQ_OBJECT_PASSPORTS

--

/* Удаление функции генерации для таблицы паспортов объектов */

DROP FUNCTION GET_OBJECT_PASSPORT_ID

--

/* Удаление таблицы паспортов объектов */

DROP TABLE OBJECT_PASSPORTS

--

/* Фиксация изменений БД */

COMMIT