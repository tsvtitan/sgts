/* Создание процедуры обновления журнала наблюдений старых данных индикаторов прогиба */

CREATE OR REPLACE PROCEDURE R_IND_JOURNAL_OBSERVATIONS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_IND_JOURNAL_OBSERVATIONS_O');
END;

--

/* Фиксация изменений */

COMMIT
