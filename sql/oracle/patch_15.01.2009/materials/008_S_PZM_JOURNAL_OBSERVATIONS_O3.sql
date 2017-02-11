/* Создание просмотра журнала наблюдений 3 старых данных пьезометров */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2563,1))

--

/* Создание индекса на цикл журнала наблюдений 3 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O3_1 ON S_PZM_JOURNAL_OBSERVATIONS_O3
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений 3 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O3_2 ON S_PZM_JOURNAL_OBSERVATIONS_O3
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения журнала наблюдений 3 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O3_3 ON S_PZM_JOURNAL_OBSERVATIONS_O3
(MEASURE_TYPE_ID)

--

/* Создание индекса на точку журнала наблюдений 3 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O3_4 ON S_PZM_JOURNAL_OBSERVATIONS_O3
(POINT_ID)

--

/* Фиксация изменений */

COMMIT