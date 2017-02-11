/* Создание процедуры обновления журнала наблюдений старых данных нивелирования */

CREATE OR REPLACE PROCEDURE R_NIV_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NIV_JOURNAL_OBSERVATIONS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
