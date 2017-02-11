/* Создание процедуры обновления срезов полевого журнала Химанализа */

CREATE OR REPLACE PROCEDURE R_HMZ_JOURNAL_FIELDS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Химанализа */

CREATE OR REPLACE PROCEDURE R_HMZ_JOURNAL_OBSERVATIONS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O');
END;

--

/* Фиксация изменений БД */

COMMIT