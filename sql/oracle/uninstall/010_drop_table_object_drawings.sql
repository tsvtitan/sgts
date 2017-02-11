/* Удаление просмотра таблицы чертежей объектов */

DROP VIEW S_OBJECT_DRAWINGS

--

/* Удаление процедуры добавления чертежа объекту */

DROP PROCEDURE I_OBJECT_DRAWING

--

/* Удаление процедуры изменения чертежа объекта */

DROP PROCEDURE U_OBJECT_DRAWING

--

/* Удаление процедуры удаления чертежа у объекта */

DROP PROCEDURE D_OBJECT_DRAWING

--

/* Удаление таблицы чертежей объектов */

DROP TABLE OBJECT_DRAWINGS

--

/* Фиксация изменений БД */

COMMIT