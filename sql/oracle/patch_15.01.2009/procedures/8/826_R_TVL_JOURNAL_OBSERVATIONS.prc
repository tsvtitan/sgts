/* Создание процедуры обновления журнала наблюдений старых данных температуры и влажности */

CREATE OR REPLACE PROCEDURE R_TVL_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_TVL_JOURNAL_OBSERVATIONS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
