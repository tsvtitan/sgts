/* Создание процедуры обновления полевого журнала 1 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_1
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O1'); 
END;

--

/* Фиксация изменений */

COMMIT
