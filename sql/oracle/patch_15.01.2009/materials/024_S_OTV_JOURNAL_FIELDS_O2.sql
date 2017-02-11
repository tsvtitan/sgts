/* Создание просмотра полевого журнала 2 старых данных отвесов */

CREATE MATERIALIZED VIEW S_OTV_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_OTV_JOURNAL_FIELDS(4622,1))

--

/* Создание индекса на цикл полевого журнала 2 старых данных отвесов */

CREATE INDEX IDX_OTV_JF_O2_1 ON S_OTV_JOURNAL_FIELDS_O2
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала 2 старых данных отвесов */

CREATE INDEX IDX_OTV_JF_O2_2 ON S_OTV_JOURNAL_FIELDS_O2
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала 2 старых данных отвесов */

CREATE INDEX IDX_OTV_JF_O2_3 ON S_OTV_JOURNAL_FIELDS_O2
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT