/* Удаление просмотра таблицы паспортов точек */

DROP VIEW S_POINT_PASSPORTS

--

/* Удаление процедуры создания паспорта точки */

DROP PROCEDURE I_POINT_PASSPORT

--

/* Удаление процедуры изменения паспорта точки */

DROP PROCEDURE U_POINT_PASSPORT

--

/* Удаление процедуры удаления паспорта точки */

DROP PROCEDURE D_POINT_PASSPORT

--

/* Удаление последовательности для таблицы паспортов точек */

DROP SEQUENCE SEQ_POINT_PASSPORTS

--

/* Удаление функции генерации для таблицы паспортов точек */

DROP FUNCTION GET_POINT_PASSPORT_ID

--

/* Удаление таблицы паспортов точек */

DROP TABLE POINT_PASSPORTS

--

/* Фиксация изменений БД */

COMMIT