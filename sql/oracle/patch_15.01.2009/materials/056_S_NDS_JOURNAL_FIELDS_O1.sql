/* —оздание просмотра полевого журнала 1 старых данных напр€женно-деформированного состо€ни€ */

CREATE MATERIALIZED VIEW S_NDS_JOURNAL_FIELDS_O1
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_NDS_JOURNAL_FIELDS(60001,1))

--

/* —оздание индекса на цикл полевого журнала 1 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O1_1 ON S_NDS_JOURNAL_FIELDS_O1
(CYCLE_ID)

--

/* —оздание индекса на дату наблюдени€ полевого журнала 1 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O1_2 ON S_NDS_JOURNAL_FIELDS_O1
(DATE_OBSERVATION)

--

/* —оздание индекса на вид измерени€ полевого журнала 1 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O1_3 ON S_NDS_JOURNAL_FIELDS_O1
(MEASURE_TYPE_ID)

--

/* ‘иксаци€ изменений */

COMMIT