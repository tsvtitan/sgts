/* Удаление просмотра Химанализа в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS

--

/* Удаление просмотра Химанализа в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O

--

/* Удаление просмотра Химанализа в полевом журнале новых данных */

DROP VIEW S_HMZ_JOURNAL_FIELDS_N

--

/* Удаление функции просмотра Химанализа в полевом журнале */

DROP FUNCTION GET_HMZ_JOURNAL_FIELDS

--

/* Удаление типа таблицы Химанализа полевого журнала */

DROP TYPE HMZ_JOURNAL_FIELD_TABLE 

--

/* Удаление типа объекта Химанализа полевого журнала */

DROP TYPE HMZ_JOURNAL_FIELD_OBJECT

--


/* Фиксация изменений БД */

COMMIT
