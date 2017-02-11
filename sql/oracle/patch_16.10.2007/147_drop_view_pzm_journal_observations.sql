/* Удаление просмотра Всех пьезометров в журнале наблюдений */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS

--

/* Удаление просмотра Береговых пьезометров в журнале наблюдений */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS_3

--

/* Удаление просмотра Береговых пьезометров в журнале наблюдений новых данных */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS_N3

--

/* Удаление просмотра Береговых пьезометров в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O3

--

/* Удаление просмотра Створных пьезометров в журнале наблюдений */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS_2

--

/* Удаление просмотра Створных пьезометров в журнале наблюдений новых данных */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS_N2

--

/* Удаление просмотра Створных пьезометров в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O2

--

/* Удаление просмотра Веерных пьезометров в журнале наблюдений */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS_1

--

/* Удаление просмотра Веерных пьезометров в журнале наблюдений новых данных */

DROP VIEW S_PZM_JOURNAL_OBSERVATIONS_N1

--

/* Удаление просмотра Веерных пьезометров в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O1

--

/* Удаление функции просмотра Пьезометров в журнале наблюдений */

DROP FUNCTION GET_PZM_JOURNAL_OBSERVATIONS

--

/* Удаление типа таблицы Пьезометров журнала наблюдений */

DROP TYPE PZM_JOURNAL_OBSERVATION_TABLE 

--

/* Удаление типа объекта Пьезометров журнала наблюдений */

DROP TYPE PZM_JOURNAL_OBSERVATION_OBJECT

--

/* Фиксация изменений БД */

COMMIT
