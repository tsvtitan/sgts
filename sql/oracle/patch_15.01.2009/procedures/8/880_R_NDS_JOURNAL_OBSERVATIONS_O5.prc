/* Создание процедуры обновления журнала наблюдений 5 старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_OBSERVATIONS_O5
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NDS_JOURNAL_OBSERVATIONS_O5'); 
END;

--

/* Фиксация изменений */

COMMIT
