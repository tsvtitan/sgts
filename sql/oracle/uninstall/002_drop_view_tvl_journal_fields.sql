/* Удалени просмотра Влажности в полевом журнале */

DROP VIEW S_TVL_JOURNAL_FIELDS

--

/* Удалени просмотра Влажности в полевом журнале новых данных */

DROP VIEW S_TVL_JOURNAL_FIELDS_N

--

/* Удалени просмотра Влажности в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_TVL_JOURNAL_FIELDS_O

--

/* Удалени функции просмотра Влажности в полевом журнале */

DROP FUNCTION GET_TVL_JOURNAL_FIELDS

--

/* Удалени типа таблицы Влажности полевого журнала */

DROP TYPE TVL_JOURNAL_FIELD_TABLE 

--

/* Удалени типа объекта Влажности полевого журнала */

DROP TYPE TVL_JOURNAL_FIELD_OBJECT 

--

/* Фиксация изменений БД */

COMMIT
