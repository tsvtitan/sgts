/* Создание процедуры обновления журнала наблюдений 1 старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_OBSERVATIONS_O1
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NDS_JOURNAL_OBSERVATIONS_O1'); 
END;

--

/* Фиксация изменений */

COMMIT
