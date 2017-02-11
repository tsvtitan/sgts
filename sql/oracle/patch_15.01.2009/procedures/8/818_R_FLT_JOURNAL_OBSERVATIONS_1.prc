/* Создание процедуры обновления журнала наблюдений 1 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_1
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O1'); 
END;

--

/* Фиксация изменений */

COMMIT
