/* —оздание просмотра полевого журнала 2 старых данных напр€женно-деформированного состо€ни€ */

CREATE MATERIALIZED VIEW S_NDS_JOURNAL_FIELDS_O2
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_NDS_JOURNAL_FIELDS(60002,1))

--

/* —оздание индекса на цикл полевого журнала 2 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O2_1 ON S_NDS_JOURNAL_FIELDS_O2
(CYCLE_ID)

--

/* —оздание индекса на дату наблюдени€ полевого журнала 2 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O2_2 ON S_NDS_JOURNAL_FIELDS_O2
(DATE_OBSERVATION)

--

/* —оздание индекса на вид измерени€ полевого журнала 2 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O2_3 ON S_NDS_JOURNAL_FIELDS_O2
(MEASURE_TYPE_ID)

--

/* ‘иксаци€ изменений */

COMMIT