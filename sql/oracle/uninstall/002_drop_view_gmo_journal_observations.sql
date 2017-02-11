/* Удаление просмотра Гидрометеорологии в журнале наблюдений */

DROP VIEW S_GMO_JOURNAL_OBSERVATIONS

--

/* Удаление просмотра Гидрометеорологии в журнале наблюдений новых данных */

DROP VIEW S_GMO_JOURNAL_OBSERVATIONS_NEW

--

/* Удаление просмотра Гидрометеорологии в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_GMO_JOURNAL_OBSERVATIONS_OLD

--

/* Удаление функции просмотра Гидрометеорологии в журнале наблюдений */

DROP FUNCTION GET_GMO_JOURNAL_OBSERVATIONS

--

/* Удаление типа таблицы Гидрометеорологии журнала наблюдений */

DROP TYPE GMO_JOURNAL_OBSERVATION_TABLE 

--

/* Удаление типа объекта Гидрометеорологии журнала наблюдений */

DROP TYPE GMO_JOURNAL_OBSERVATION_OBJECT

--

/* Фиксация изменений БД */

COMMIT
