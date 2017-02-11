/* Создание процедуры обновления среза полевого журнала Влажности */

CREATE OR REPLACE PROCEDURE R_TVL_JOURNAL_FIELDS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_TVL_JOURNAL_FIELDS_O');
END;

--

/* Создание процедуры обновления среза журнала наблюдений Влажности */

CREATE OR REPLACE PROCEDURE R_TVL_JOURNAL_OBSERVATIONS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_TVL_JOURNAL_OBSERVATIONS_O');
END;

--

/* Фиксация изменений БД */

COMMIT