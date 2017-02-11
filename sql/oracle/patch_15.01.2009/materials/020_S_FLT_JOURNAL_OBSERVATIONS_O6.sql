/* Создание просмотра журнала наблюдений 6 старых данных фильтрации */

CREATE MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O6
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_FLT_JOURNAL_OBSERVATIONS(2626,1))

--

/* Создание индекса на цикл журнала наблюдений 6 старых данных фильтрации */

CREATE INDEX IDX_FLT_JO_O6_1 ON S_FLT_JOURNAL_OBSERVATIONS_O6
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений 6 старых данных фильтрации */

CREATE INDEX IDX_FLT_JO_O6_2 ON S_FLT_JOURNAL_OBSERVATIONS_O6
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения журнала наблюдений 6 старых данных фильтрации */

CREATE INDEX IDX_FLT_JO_O6_3 ON S_FLT_JOURNAL_OBSERVATIONS_O6
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT