/* Создание процедуры обновления журнала наблюдений 3 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_3
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O3'); 
END;

--

/* Фиксация изменений */

COMMIT
