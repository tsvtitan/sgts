/* Удаление просмотра Химанализа в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS

--


/* Удаление просмотра Верхний бъеф в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS_5

--

/* Удаление просмотра Верхний бъеф в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O5

--

/* Удаление просмотра Верхний бъеф в полевом журнале новых данных */

DROP VIEW S_HMZ_JOURNAL_FIELDS_N5

--



/* Удаление просмотра Дренажи бетона и швы в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS_4

--

/* Удаление просмотра Дренажи бетона и швы в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O4

--

/* Удаление просмотра Дренажи бетона и швы в полевом журнале новых данных */

DROP VIEW S_HMZ_JOURNAL_FIELDS_N4

--



/* Удаление просмотра Веерные пьезометры в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS_3

--

/* Удаление просмотра Веерные пьезометры в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O3

--

/* Удаление просмотра Веерные пьезометры в полевом журнале новых данных */

DROP VIEW S_HMZ_JOURNAL_FIELDS_N3

--



/* Удаление просмотра Дренажи осн. 2го ряда в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS_2

--

/* Удаление просмотра Дренажи осн. 2го ряда в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O2

--

/* Удаление просмотра Дренажи осн. 2го ряда в полевом журнале новых данных */

DROP VIEW S_HMZ_JOURNAL_FIELDS_N2

--



/* Удаление просмотра Дренажи осн. 1го ряда в полевом журнале */

DROP VIEW S_HMZ_JOURNAL_FIELDS_1

--

/* Удаление просмотра Дренажи осн. 1го ряда в полевом журнале старых данных */

DROP MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O1

--

/* Удаление просмотра Дренажи осн. 1го ряда в полевом журнале новых данных */

DROP VIEW S_HMZ_JOURNAL_FIELDS_N1

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
