/* Удаление просмотра таблицы видов измерений маршрутов */

DROP VIEW S_MEASURE_TYPE_ROUTES

--

/* Удаление процедуры добавления вида измерения маршруту */

DROP PROCEDURE I_MEASURE_TYPE_ROUTE

--

/* Удаление процедуры изменения вида измерения маршрута */

DROP PROCEDURE U_MEASURE_TYPE_ROUTE

--

/* Удаление процедуры удаления вида измерения маршрута */

DROP PROCEDURE D_MEASURE_TYPE_ROUTE

--

/* Удаление таблицы видов измерений маршрутов */

DROP TABLE MEASURE_TYPE_ROUTES

--

/* Фиксация изменений БД */

COMMIT