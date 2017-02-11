/* Создание процедуры обновления полевого журнала 5 старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_FIELDS_O5
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NDS_JOURNAL_FIELDS_O5'); 
END;

--

/* Фиксация изменений */

COMMIT
