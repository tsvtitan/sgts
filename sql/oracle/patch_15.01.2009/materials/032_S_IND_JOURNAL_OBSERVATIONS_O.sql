/* Создание просмотра журнала наблюдений старых данных индикаторов прогиба */

CREATE MATERIALIZED VIEW S_IND_JOURNAL_OBSERVATIONS_O
NOLOGGING
NOCACHE
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE
START WITH TO_DATE('01.01.2007','DD.MM.YYYY')
DISABLE QUERY REWRITE AS
SELECT * FROM TABLE(GET_IND_JOURNAL_OBSERVATIONS(1))

--

/* Создание индекса на цикл журнала наблюдений старых данных индикаторов прогиба */

CREATE INDEX IDX_IND_JO_O_1 ON S_IND_JOURNAL_OBSERVATIONS_O
(CYCLE_ID)

--

/* Создание индекса на дату наблюдения журнала наблюдений старых данных индикаторов прогиба */

CREATE INDEX IDX_IND_JO_O_2 ON S_IND_JOURNAL_OBSERVATIONS_O
(DATE_OBSERVATION)

--

/* Фиксация изменений */

COMMIT