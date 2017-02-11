/* Создание просмотра журнала наблюдений 1 старых данных пьезометров */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2561,1))

--

/* Создание индекса на цикл журнала наблюдений 1 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O1_1 ON S_PZM_JOURNAL_OBSERVATIONS_O1
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений 1 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O1_2 ON S_PZM_JOURNAL_OBSERVATIONS_O1
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения журнала наблюдений 1 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O1_3 ON S_PZM_JOURNAL_OBSERVATIONS_O1
(MEASURE_TYPE_ID)

--

/* Создание индекса на точку журнала наблюдений 1 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O1_4 ON S_PZM_JOURNAL_OBSERVATIONS_O1
(POINT_ID)

--

/* Фиксация изменений */

COMMIT