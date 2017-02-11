/* Создание процедуры обновления журнала наблюдений 3 старых данных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS_3
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O3'); 
END;

--

/* Фиксация изменений */

COMMIT
