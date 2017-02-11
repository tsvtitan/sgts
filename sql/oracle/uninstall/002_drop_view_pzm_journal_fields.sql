/* Удаление просмотра Всех пьезометров в полевом журнале */

DROP VIEW S_PZM_JOURNAL_FIELDS

--

/* Удаление просмотра Береговых пьезометров в полевом журнале */

DROP VIEW S_PZM_JOURNAL_FIELDS_3

--

/* Удаление просмотра Береговых пьезометров в полевом журнале новых данных */

DROP VIEW S_PZM_JOURNAL_FIELDS_N3

--

/* Удаление просмотра Береговых пьезометров в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O3

--

/* Удаление просмотра Створных пьезометров в полевом журнале */

DROP VIEW S_PZM_JOURNAL_FIELDS_2

--

/* Удаление просмотра Створных пьезометров в полевом журнале новых данных */

DROP VIEW S_PZM_JOURNAL_FIELDS_N2

--

/* Удаление просмотра Створных пьезометров в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O2

--

/* Удаление просмотра Веерных пьезометров в полевом журнале */

DROP VIEW S_PZM_JOURNAL_FIELDS_1

--

/* Удаление просмотра Веерных пьезометров в полевом журнале новых данных */

DROP VIEW S_PZM_JOURNAL_FIELDS_N1

--

/* Удаление просмотра Веерных пьезометров в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O1

--

/* Удаление функции просмотра Пьезометров в полевом журнале */

DROP FUNCTION GET_PZM_JOURNAL_FIELDS

--

/* Удаление типа таблицы Пьезометров полевого журнала */

DROP TYPE PZM_JOURNAL_FIELD_TABLE 

--

/* Удаление типа объекта Пьезометров полевого журнала */

DROP TYPE PZM_JOURNAL_FIELD_OBJECT

--

/* Фиксация изменений БД */

COMMIT
