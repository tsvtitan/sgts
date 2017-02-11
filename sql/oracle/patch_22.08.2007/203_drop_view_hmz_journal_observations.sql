/* Удаление просмотра Химанализа в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS

--



/* Удаление просмотра Верхний бъеф в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_5

--

/* Удаление просмотра Верхний бъеф в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O5

--

/* Удаление просмотра Верхний бъеф в журнале наблюдений новых данных */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_N5

--



/* Удаление просмотра Дренажи бетона и швы в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_4

--

/* Удаление просмотра Дренажи бетона и швы в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O4

--

/* Удаление просмотра Дренажи бетона и швы в журнале наблюдений новых данных */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_N4

--




/* Удаление просмотра Веерные пьезометры в журнале наблюдений новых данных */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_N3

--

/* Удаление просмотра Веерные пьезометры в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_3

--

/* Удаление просмотра Веерные пьезометры в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O3

--




/* Удаление просмотра Дренажи осн. 2го ряда в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_2

--

/* Удаление просмотра Дренажи осн. 2го ряда в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O2
--

/* Удаление просмотра Дренажи осн. 2го ряда в журнале наблюдений новых данных */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_N2

--



/* Удаление просмотра Дренажи осн. 1го ряда в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_1

--

/* Удаление просмотра Дренажи осн. 1го ряда в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O1

--

/* Удаление просмотра Дренажи осн. 1го ряда в журнале наблюдений новых данных */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_N1

--




/* Удаление функции просмотра Химанализа в журнале наблюдений */

DROP FUNCTION GET_HMZ_JOURNAL_OBSERVATIONS
 
--

/* Удаление типа таблицы Химанализа журнала наблюдений */

DROP TYPE HMZ_JOURNAL_OBSERVATION_TABLE 

--

/* Удаление типа объекта Химанализа журнала наблюдений */

DROP TYPE HMZ_JOURNAL_OBSERVATION_OBJECT

--


/* Фиксация изменений БД */

COMMIT
