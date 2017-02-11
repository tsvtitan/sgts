/* Создание просмотра полевого журнала 1 старых данных одноосных щелемеров */

CREATE MATERIALIZED VIEW S_SL1_JOURNAL_FIELDS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SL1_JOURNAL_FIELDS(30001,1))

--

/* Создание индекса на цикл полевого журнала 1 старых данных одноосных щелемеров */

CREATE INDEX IDX_SL1_JF_O1_1 ON S_SL1_JOURNAL_FIELDS_O1
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала 1 старых данных одноосных щелемеров */

CREATE INDEX IDX_SL1_JF_O1_2 ON S_SL1_JOURNAL_FIELDS_O1
(DATE_OBSERVATION)

--

/* Создание индекса на вид измерения полевого журнала 1 старых данных одноосных щелемеров */

CREATE INDEX IDX_SL1_JF_O1_3 ON S_SL1_JOURNAL_FIELDS_O1
(MEASURE_TYPE_ID)

--

/* Фиксация изменений */

COMMIT