/* Удаление просмотра таблицы видов измерений */

DROP VIEW S_MEASURE_TYPES

--

/* Удаление процедуры создания вида измерения */

DROP PROCEDURE I_MEASURE_TYPE

--

/* Удаление процедуры проверки родительского вида измерения */

DROP PROCEDURE A_MEASURE_TYPE_PARENT_ID

--

/* Удаление процедуры изменения вида измерения */

DROP PROCEDURE U_MEASURE_TYPE

--

/* Удаление процедуры удаления вида измерения плюс */

DROP PROCEDURE D_MEASURE_TYPE_EX

--

/* Удаление процедуры удаления вида измерения */

DROP PROCEDURE D_MEASURE_TYPE

--

/* Удаление последовательности для таблицы видов измерений */

DROP SEQUENCE SEQ_MEASURE_TYPES

--

/* Удаление функции генерации для таблицы видов измерений */

DROP FUNCTION GET_MEASURE_TYPE_ID

--

/* Удаление таблицы видов измерений */

DROP TABLE MEASURE_TYPES

--

/* Фиксация изменений БД */

COMMIT
