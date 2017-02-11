/* Создание просмотра полевого журнала старых данных гидрометеорологии */

CREATE MATERIALIZED VIEW S_GMO_JOURNAL_FIELDS_OLD
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_GMO_JOURNAL_FIELDS(1))

--

/* Создание индекса на цикл полевого журнала старых данных гидрометеорологии */

CREATE INDEX IDX_GMO_JF_OLD_1 ON S_GMO_JOURNAL_FIELDS_OLD
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения полевого журнала старых данных гидрометеорологии */

CREATE INDEX IDX_GMO_JF_OLD_2 ON S_GMO_JOURNAL_FIELDS_OLD
(DATE_OBSERVATION)

--

/* Фиксация изменений */

COMMIT