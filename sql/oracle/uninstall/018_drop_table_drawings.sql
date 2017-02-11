/* Удаление просмотра таблицы чертежей */

DROP VIEW S_DRAWINGS

--

/* Удаление процедуры создания чертежа */

DROP PROCEDURE I_DRAWING

--

/* Удаление процедуры изменения чертежа */

DROP PROCEDURE U_DRAWING

--

/* Удаление процедуры удаления чертежа */

DROP PROCEDURE D_DRAWING

--

/* Удаление последовательности для таблицы чертежей */

DROP SEQUENCE SEQ_DRAWINGS

--

/* Удаление функции генерации для таблицы чертежей */

DROP FUNCTION GET_DRAWING_ID

--

/* Удаление таблицы чертежей */

DROP TABLE DRAWINGS

--

/* Фиксация изменений БД */

COMMIT