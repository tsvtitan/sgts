/* Удаление просмотра таблицы единиц измерения */

DROP VIEW S_MEASURE_UNITS

--

/* Удаление процедуры создания единицы измерения */

DROP PROCEDURE I_MEASURE_UNIT

--

/* Удаление процедуры изменения единицы измерения */

DROP PROCEDURE U_MEASURE_UNIT

--

/* Удаление процедуры удаления единицы измерения */

DROP PROCEDURE D_MEASURE_UNIT

--

/* Удаление последовательности для таблицы единиц измерения */

DROP SEQUENCE SEQ_MEASURE_UNITS

--

/* Удаление функции генерации для таблицы единиц измерения */

DROP FUNCTION GET_MEASURE_UNIT_ID

--

/* Удаление таблицы единиц измерения */

DROP TABLE MEASURE_UNITS

--

/* Фиксация изменений БД */

COMMIT