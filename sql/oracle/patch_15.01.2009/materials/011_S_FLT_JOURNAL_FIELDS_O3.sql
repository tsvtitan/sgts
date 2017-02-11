/* Создание просмотра полевого журнала 3 старых данных фильтрации */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_FIELDS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_FIELDS(2581,1))

--

/* Создание индекса на цикл полевого журнала 3 старых данных фильтрации */

CREATE INDEX IDX_FLT_JF_O3_1 ON S_FLT_JOURNAL_FIELDS_O3
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала 3 старых данных фильтрации */

CREATE INDEX IDX_FLT_JF_O3_2 ON S_FLT_JOURNAL_FIELDS_O3
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала 3 старых данных фильтрации */

CREATE INDEX IDX_FLT_JF_O3_3 ON S_FLT_JOURNAL_FIELDS_O3
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT