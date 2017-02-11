/* Удаление просмотра таблицы приборов параметров */

DROP VIEW S_PARAM_INSTRUMENTS

--

/* Удаление процедуры добавления прибора параметру */

DROP PROCEDURE I_PARAM_INSTRUMENT

--

/* Удаление процедуры изменения прибора параметра */

DROP PROCEDURE U_PARAM_INSTRUMENT

--

/* Удаление процедуры удаления прибора параметра */

DROP PROCEDURE D_PARAM_INSTRUMENT

--

/* Удаление таблицы приборов параметров */

DROP TABLE PARAM_INSTRUMENTS

--

/* Фиксация изменений БД */

COMMIT