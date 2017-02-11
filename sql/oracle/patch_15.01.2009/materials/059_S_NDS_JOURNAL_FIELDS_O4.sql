/* —оздание просмотра полевого журнала 4 старых данных напр€женно-деформированного состо€ни€ */

CREATE MATERIALIZED VIEW S_NDS_JOURNAL_FIELDS_O4
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_NDS_JOURNAL_FIELDS(60004,1))

--

/* —оздание индекса на цикл полевого журнала 4 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O4_1 ON S_NDS_JOURNAL_FIELDS_O4
(CYCLE_ID)

--

/* —оздание индекса на дату наблюдени€ полевого журнала 4 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O4_2 ON S_NDS_JOURNAL_FIELDS_O4
(DATE_OBSERVATION)

--

/* —оздание индекса на вид измерени€ полевого журнала 4 старых данных напр€женно-деформированного состо€ни€ */

CREATE INDEX IDX_NDS_JF_O4_3 ON S_NDS_JOURNAL_FIELDS_O4
(MEASURE_TYPE_ID)

--

/* ‘иксаци€ изменений */

COMMIT