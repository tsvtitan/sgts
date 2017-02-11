/* Создание просмотра полевого журнала 3 старых данных одноосных щелемеров */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_FIELDS_O3
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30003,1))

--

/* Создание индекса на цикл полевого журнала 3 старых данных одноосных щелемеров */

CREATE INDEX IDX_SL1_JF_O3_1 ON S_SL1_JOURNAL_FIELDS_O3
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала 3 старых данных одноосных щелемеров */

CREATE INDEX IDX_SL1_JF_O3_2 ON S_SL1_JOURNAL_FIELDS_O3
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала 3 старых данных одноосных щелемеров */

CREATE INDEX IDX_SL1_JF_O3_3 ON S_SL1_JOURNAL_FIELDS_O3
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT