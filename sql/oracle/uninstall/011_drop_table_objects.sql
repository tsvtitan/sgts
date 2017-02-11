/* Удаление просмотра таблицы объектов*/

DROP VIEW S_OBJECTS

--

/* Удаление процедуры создания объекта */

DROP PROCEDURE I_OBJECT

--

/* Удаление процедуры изменения объекта */

DROP PROCEDURE U_OBJECT

--

/* Удаление процедуры удаления объекта */

DROP PROCEDURE D_OBJECT

--

/* Удаление последовательности для таблицы объектов */

DROP SEQUENCE SEQ_OBJECTS

--

/* Удаление функции генерации для таблицы объектов*/

DROP FUNCTION GET_OBJECT_ID

--

/* Удаление таблицы объектов*/

DROP TABLE OBJECTS

--

/* Фиксация изменений БД */

COMMIT