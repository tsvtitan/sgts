/* Удаление просмотра таблицы точек */

DROP VIEW S_POINTS

--

/* Удаление процедуры создания точки */

DROP PROCEDURE I_POINT

--

/* Удаление процедуры изменения точки */

DROP PROCEDURE U_POINT

--

/* Удаление процедуры удаления точки */

DROP PROCEDURE D_POINT

--

/* Удаление последовательности для таблицы точек */

DROP SEQUENCE SEQ_POINTS

--

/* Удаление функции генерации для таблицы точек */

DROP FUNCTION GET_POINT_ID

--

/* Удаление таблицы точек */

DROP TABLE POINTS

--

/* Фиксация изменений БД */

COMMIT