/* Создание просмотра журнала наблюдений 2 старых данных отвесов */

CREATE MATERIALIZED VIEW S_OTV_JOURNAL_OBSERVATIONS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_OTV_JOURNAL_OBSERVATIONS(4622,1))

--

/* Создание индекса на цикл журнала наблюдений 2 старых данных отвесов */

CREATE INDEX IDX_OTV_JO_O2_1 ON S_OTV_JOURNAL_OBSERVATIONS_O2
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений 2 старых данных отвесов */

CREATE INDEX IDX_OTV_JO_O2_2 ON S_OTV_JOURNAL_OBSERVATIONS_O2
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения журнала наблюдений 2 старых данных отвесов */

CREATE INDEX IDX_OTV_JO_O2_3 ON S_OTV_JOURNAL_OBSERVATIONS_O2
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT