/* Создание процедуры обновления полевого журнала 1 старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_FIELDS_O1
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NDS_JOURNAL_FIELDS_O1'); 
END;

--

/* Фиксация изменений */

COMMIT
