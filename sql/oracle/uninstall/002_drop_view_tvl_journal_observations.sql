/* Удалени просмотра Влажности в журнале наблюдений */

DROP VIEW S_TVL_JOURNAL_OBSERVATIONS

--

/* Удалени просмотра Влажности в журнале наблюдений новых данных */

DROP VIEW S_TVL_JOURNAL_OBSERVATIONS_N

--

/* Удалени просмотра Влажности в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_TVL_JOURNAL_OBSERVATIONS_O

--

/* Удалени функции просмотра Влажности в журнале наблюдений */

DROP FUNCTION GET_TVL_JOURNAL_OBSERVATIONS

--

/* Удалени типа таблицы Влажности журнала наблюдений */

DROP TYPE TVL_JOURNAL_OBSERVATION_TABLE 

--

/* Удалени типа объекта Влажности журнала наблюдений */

DROP TYPE TVL_JOURNAL_OBSERVATION_OBJECT 

--

/* Фиксация изменений БД */

COMMIT
