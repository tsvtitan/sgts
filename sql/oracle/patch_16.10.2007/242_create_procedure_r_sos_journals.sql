/* Создание процедуры обновления среза полевого журнала Струнно-оптического створа */

CREATE OR REPLACE PROCEDURE R_SOS_JOURNAL_FIELDS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SOS_JOURNAL_FIELDS_O');
END;

--

/* Создание процедуры обновления среза журнала наблюдений Струнно-оптического створа */

CREATE OR REPLACE PROCEDURE R_SOS_JOURNAL_OBSERVATIONS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SOS_JOURNAL_OBSERVATIONS_O');
END;

--

/* Фиксация изменений БД */

COMMIT