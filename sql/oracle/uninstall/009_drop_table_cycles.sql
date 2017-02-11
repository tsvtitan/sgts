/* Удаление просмотра таблицы циклов */

DROP VIEW S_CYCLES

--

/* Удаление процедуры создания цикла */

DROP PROCEDURE I_CYCLE

--

/* Удаление процедуры изменения цикла */

DROP PROCEDURE U_CYCLE

--

/* Удаление процедуры удаления цикла */

DROP PROCEDURE D_CYCLE

--

/* Удаление последовательности для таблицы циклов */

DROP SEQUENCE SEQ_CYCLES

--

/* Удаление функции генерации для таблицы циклов */

DROP FUNCTION GET_CYCLE_ID

--

/* Удаление таблицы циклов */

DROP TABLE CYCLES

--

/* Фиксация изменений БД */

COMMIT