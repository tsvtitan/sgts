/* Создание процедуры обновления журнала наблюдений 1 старых данных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS_1
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O1'); 
END;

--

/* Фиксация изменений */

COMMIT
