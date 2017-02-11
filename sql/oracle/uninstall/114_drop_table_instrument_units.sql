/* Удаление функции генерации для таблицы единиц прибора */

DROP VIEW S_INSTRUMENT_UNITS

--

/* Удаление процедуры создания единицы прибора */

DROP PROCEDURE I_INSTRUMENT_UNIT

--

/* Удаление процедуры изменения единицы прибора */

DROP PROCEDURE U_INSTRUMENT_UNIT

--

/* Удаление процедуры удаления единицы прибора */

DROP PROCEDURE D_INSTRUMENT_UNIT

--

/* Удаление последовательности для таблицы единиц прибора */

DROP TABLE INSTRUMENT_UNITS

--

/* Фиксация изменений БД */

COMMIT