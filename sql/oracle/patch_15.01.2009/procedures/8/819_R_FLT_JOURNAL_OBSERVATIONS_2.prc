/* Создание процедуры обновления журнала наблюдений 2 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_2
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O2'); 
END;

--

/* Фиксация изменений */

COMMIT
