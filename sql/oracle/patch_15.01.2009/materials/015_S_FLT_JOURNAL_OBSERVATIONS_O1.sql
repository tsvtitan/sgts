/* Создание просмотра журнала наблюдений 1 старых данных фильтрации */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2582,1))

--

/* Создание индекса на цикл журнала наблюдений 1 старых данных фильтрации */

CREATE INDEX IDX_FLT_JO_O1_1 ON S_FLT_JOURNAL_OBSERVATIONS_O1
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений 1 старых данных фильтрации */

CREATE INDEX IDX_FLT_JO_O1_2 ON S_FLT_JOURNAL_OBSERVATIONS_O1
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения журнала наблюдений 1 старых данных фильтрации */

CREATE INDEX IDX_FLT_JO_O1_3 ON S_FLT_JOURNAL_OBSERVATIONS_O1
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT