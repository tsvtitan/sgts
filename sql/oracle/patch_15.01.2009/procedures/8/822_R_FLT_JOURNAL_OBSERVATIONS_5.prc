/* Создание процедуры обновления журнала наблюдений 5 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_5
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O5'); 
END;

--

/* Фиксация изменений */

COMMIT
