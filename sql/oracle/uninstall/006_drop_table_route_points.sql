/* Удаление просмотра таблицы точек маршрутов */

DROP VIEW S_ROUTE_POINTS

--

/* Удаление просмотра таблицы преобразователей маршрутов */

DROP VIEW S_ROUTE_CONVERTERS

--

/* Удаление процедуры добавления точек маршруту */

DROP PROCEDURE I_ROUTE_POINT

--

/* Удаление процедуры изменения точек маршруту */

DROP PROCEDURE U_ROUTE_POINT

--

/* Удаление процедуры удаления точек маршруту */

DROP PROCEDURE D_ROUTE_POINT

--

/* Удаление таблицы точек маршрутов */

DROP TABLE ROUTE_POINTS

--

/* Фиксация изменений БД */

COMMIT