/* Создание процедуры обновления журнала наблюдений 4 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_4
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O4'); 
END;

--

/* Фиксация изменений */

COMMIT
