/* Удаление просмотра таблицы приборов точек */

DROP VIEW S_POINT_INSTRUMENTS

--

/* Удаление процедуры добавления прибора точке */

DROP PROCEDURE I_POINT_INSTRUMENT

--

/* Удаление процедуры изменения прибора точки */

DROP PROCEDURE U_POINT_INSTRUMENT

--

/* Удаление процедуры удаления прибора точки */

DROP PROCEDURE D_POINT_INSTRUMENT

--

/* Удаление таблицы приборов точек */

DROP TABLE POINT_INSTRUMENTS

--

/* Фиксация изменений БД */

COMMIT