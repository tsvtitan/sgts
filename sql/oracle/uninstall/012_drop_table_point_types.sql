/* Удаление просмотра таблицы типов точек */

DROP VIEW S_POINT_TYPES


--

/* Удаление процедуры создания типа точки */

DROP PROCEDURE I_POINT_TYPE

--

/* Удаление процедуры изменения типа точки */

DROP PROCEDURE U_POINT_TYPE

--

/* Удаление процедуры удаления типа точки */

DROP PROCEDURE D_POINT_TYPE

--

/* Удаление последовательности для таблицы типов точек */

DROP SEQUENCE SEQ_POINT_TYPES

--

/* Удаление функции генерации для таблицы типов точек */

DROP FUNCTION GET_POINT_TYPE_ID

--

/* Удаление таблицы типов точек */

DROP TABLE POINT_TYPES

--

/* Фиксация изменений БД */

COMMIT