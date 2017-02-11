/* Создание просмотра журнала наблюдений 2 старых данных пьезометров */

CREATE MATERIALIZED VIEW S_PZM_JOURNAL_OBSERVATIONS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_PZM_JOURNAL_OBSERVATIONS(2562,1))

--

/* Создание индекса на цикл журнала наблюдений 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O2_1 ON S_PZM_JOURNAL_OBSERVATIONS_O2
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O2_2 ON S_PZM_JOURNAL_OBSERVATIONS_O2
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения журнала наблюдений 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O2_3 ON S_PZM_JOURNAL_OBSERVATIONS_O2
(MEASURE_TYPE_ID)

--

/* Создание индекса на точку журнала наблюдений 2 старых данных пьезометров */

CREATE INDEX IDX_PZM_JO_O2_4 ON S_PZM_JOURNAL_OBSERVATIONS_O2
(POINT_ID)

--

/* Фиксация изменений */

COMMIT