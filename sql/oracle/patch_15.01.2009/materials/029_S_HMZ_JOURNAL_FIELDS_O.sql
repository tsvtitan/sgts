/* Создание просмотра полевого журнала старых данных химанализа */

CREATE MATERIALIZED VIEW S_HMZ_JOURNAL_FIELDS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_HMZ_JOURNAL_FIELDS(2600,1))

--

/* Создание индекса на цикл полевого журнала старых данных химанализа */

CREATE INDEX IDX_HMZ_JF_O_1 ON S_HMZ_JOURNAL_FIELDS_O
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала старых данных химанализа */

CREATE INDEX IDX_HMZ_JF_O_2 ON S_HMZ_JOURNAL_FIELDS_O
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала старых данных химанализа */

CREATE INDEX IDX_HMZ_JF_O_3 ON S_HMZ_JOURNAL_FIELDS_O
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT