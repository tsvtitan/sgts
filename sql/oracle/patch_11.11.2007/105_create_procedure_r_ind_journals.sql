/* Создание процедуры обновления среза полевого журнала Индикаторов прогиба */

CREATE OR REPLACE PROCEDURE R_IND_JOURNAL_FIELDS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_IND_JOURNAL_FIELDS_O');
END;

--

/* Создание процедуры обновления среза журнала наблюдений Индикаторов прогиба */

CREATE OR REPLACE PROCEDURE R_IND_JOURNAL_OBSERVATIONS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_IND_JOURNAL_OBSERVATIONS_O');
END;

--

/* Фиксация изменений БД */

COMMIT