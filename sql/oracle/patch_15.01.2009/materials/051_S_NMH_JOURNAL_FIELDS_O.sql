/* Создание просмотра полевого журнала старых данных нивелирования марок гидронивелира */

CREATE MATERIALIZED VIEW S_NMH_JOURNAL_FIELDS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_NMH_JOURNAL_FIELDS(49985,1))

--

/* Создание индекса на цикл полевого журнала старых данных нивелирования марок гидронивелира */

CREATE INDEX IDX_NMH_JF_O1_1 ON S_NMH_JOURNAL_FIELDS_O
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала старых данных нивелирования марок гидронивелира */

CREATE INDEX IDX_NMH_JF_O1_2 ON S_NMH_JOURNAL_FIELDS_O
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала старых данных нивелирования марок гидронивелира */

CREATE INDEX IDX_NMH_JF_O1_3 ON S_NMH_JOURNAL_FIELDS_O
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT