/* Удаление просмотра таблицы уровней */

DROP VIEW S_LEVELS

--

/* Удаление процедуры создания уровня */

DROP PROCEDURE I_LEVEL

--

/* Удаление процедуры изменения уровня */

DROP PROCEDURE U_LEVEL

--

/* Удаление процедуры удаления уровня */

DROP PROCEDURE D_LEVEL

--

/* Удаление последовательности для таблицы уровней */

DROP SEQUENCE SEQ_LEVELS

--

/* Удаление функции генерации для таблицы уровней */

DROP FUNCTION GET_LEVEL_ID

--

/* Удаление таблицы уровней */

DROP TABLE LEVELS

--

/* Фиксация изменений БД */

COMMIT