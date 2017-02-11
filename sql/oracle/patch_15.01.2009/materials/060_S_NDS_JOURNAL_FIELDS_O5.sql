/* —оздание просмотра полевого журнала 5 старых данных напр€женно-деформированного состо€ни€ */

CREATE MATERIALIZED VIEW S_NDS_JOURNAL_FIELDS_O5
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_NDS_JOURNAL_FIELDS(60005,1))

--

/* —оздание индекса на цикл полевого журнала 5 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O5_1 ON S_NDS_JOURNAL_FIELDS_O5
(CYCLE_ID)

--

/* —оздание индекса на дату наблюдени€ полевого журнала 5 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O5_2 ON S_NDS_JOURNAL_FIELDS_O5
(DATE_OBSERVATION)

--

/* —оздание индекса на вид измерени€ полевого журнала 5 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O5_3 ON S_NDS_JOURNAL_FIELDS_O5
(MEASURE_TYPE_ID)

--

/* ‘иксаци€ изменений */

COMMIT