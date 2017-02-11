/* Удаление просмотра Химанализа в журнале наблюдений */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS

--

/* Удаление просмотра Химанализа в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_OBSERVATIONS_O

--

/* Удаление просмотра Химанализа в журнале наблюдений новых данных */

DROP VIEW S_HMZ_JOURNAL_OBSERVATIONS_N

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
