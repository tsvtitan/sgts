/* Удаление просмотра таблицы точек устройств */

DROP VIEW S_DEVICE_POINTS

--

/* Удаление процедуры добавления точки устройству */

DROP PROCEDURE I_DEVICE_POINT

--

/* Удаление процедуры изменения точки у устройства */

DROP PROCEDURE U_DEVICE_POINT

--

/* Удаление процедуры удаления точки у устройства */

DROP PROCEDURE D_DEVICE_POINT

--

/* Удаление таблицы точек устройств */

DROP TABLE DEVICE_POINTS

--

/* Фиксация изменений БД */

COMMIT