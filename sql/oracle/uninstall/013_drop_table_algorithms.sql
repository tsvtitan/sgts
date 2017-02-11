/* Удаление просмотра таблицы алгоритмов */

DROP VIEW S_ALGORITHMS


--

/* Удаление процедуры создания алгоритма */

DROP PROCEDURE I_ALGORITHM

--

/* Удаление процедуры изменения алгоритма */

DROP PROCEDURE U_ALGORITHM

--

/* Удаление процедуры удаления алгоритма */

DROP PROCEDURE D_ALGORITHM

--

/* Удаление последовательности для таблицы алгоритмов */

DROP SEQUENCE SEQ_ALGORITHMS

--

/* Удаление функции генерации для таблицы алгоритмов */

DROP FUNCTION GET_ALGORITHM_ID

--

/* Удаление таблицы алгоритмов */

DROP TABLE ALGORITHMS

--

/* Фиксация изменений БД */

COMMIT