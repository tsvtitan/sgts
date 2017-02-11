/* Удаление просмотра таблицы алгоритмов видов измерений */

DROP VIEW S_MEASURE_TYPE_ALGORITHMS

--

/* Удаление процедуры добавления алгоритма виду измерения */

DROP PROCEDURE I_MEASURE_TYPE_ALGORITHM

--

/* Удаление процедуры изменения алгоритма вида измерения */

DROP PROCEDURE U_MEASURE_TYPE_ALGORITHM

--

/* Удаление процедуры удаления алгоритма вида измерения */

DROP PROCEDURE D_MEASURE_TYPE_ALGORITHM

--

/* Удаление таблицы алгоритмов видов измерений */

DROP TABLE MEASURE_TYPE_ALGORITHMS

--

/* Фиксация изменений БД */

COMMIT