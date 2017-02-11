/* Удаление просмотра таблицы параметров видов измерений */

DROP VIEW S_MEASURE_TYPE_PARAMS

--

/* Удаление процедуры добавления параметра виду измерения */

DROP PROCEDURE I_MEASURE_TYPE_PARAM

--

/* Удаление процедуры изменения параметра вида измерения */

DROP PROCEDURE U_MEASURE_TYPE_PARAM

--

/* Удаление процедуры удаления параметра вида измерения */

DROP PROCEDURE D_MEASURE_TYPE_PARAM

--

/* Удаление таблицы параметра видов измерений */

DROP TABLE MEASURE_TYPE_PARAMS

--

/* Фиксация изменений БД */

COMMIT