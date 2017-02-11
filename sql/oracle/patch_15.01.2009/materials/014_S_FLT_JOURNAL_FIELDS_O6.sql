/* Создание просмотра полевого журнала 6 старых данных фильтрации */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O6
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2626,1))

--

/* Создание индекса на цикл полевого журнала 6 старых данных фильтрации */

CREATE INDEX IDX_FLT_JF_O6_1 ON S_FLT_JOURNAL_FIELDS_O6
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала 6 старых данных фильтрации */

CREATE INDEX IDX_FLT_JF_O6_2 ON S_FLT_JOURNAL_FIELDS_O6
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала 6 старых данных фильтрации */

CREATE INDEX IDX_FLT_JF_O6_3 ON S_FLT_JOURNAL_FIELDS_O6
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT