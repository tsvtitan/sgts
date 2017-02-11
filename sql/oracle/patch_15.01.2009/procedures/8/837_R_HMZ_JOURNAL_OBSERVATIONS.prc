/* Создание процедуры обновления журнала наблюдений старых данных химанализа */

CREATE OR REPLACE PROCEDURE R_HMZ_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
