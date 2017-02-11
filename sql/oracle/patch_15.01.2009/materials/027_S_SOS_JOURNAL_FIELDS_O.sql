/* Создание просмотра полевого журнала старых данных струнно-оптического створа */

CREATE MATERIALIZED VIEW S_SOS_JOURNAL_FIELDS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_SOS_JOURNAL_FIELDS(1))

--

/* Создание индекса на цикл полевого журнала старых данных струнно-оптического створа */

CREATE INDEX IDX_SOS_JF_O_1 ON S_SOS_JOURNAL_FIELDS_O
(CYCLE_ID)

--


/* Создание индекса на дату наблюдения полевого журнала старых данных струнно-оптического створа */

CREATE INDEX IDX_SOS_JF_O_2 ON S_SOS_JOURNAL_FIELDS_O
(DATE_OBSERVATION)

--

/* Фиксация изменений */

COMMIT
