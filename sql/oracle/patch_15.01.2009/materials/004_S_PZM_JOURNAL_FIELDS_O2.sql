/* Создание просмотра полевого журнала 2 старых данных пьезометров */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_FIELDS(2562,1))

--

/* Создание индекса на цикл полевого журнала 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JF_O2_1 ON S_PZM_JOURNAL_FIELDS_O2
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JF_O2_2 ON S_PZM_JOURNAL_FIELDS_O2
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JF_O2_3 ON S_PZM_JOURNAL_FIELDS_O2
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT