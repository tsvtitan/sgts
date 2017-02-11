/* Создание процедуры обновления полевого журнала 6 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_6
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O6'); 
END;

--

/* Фиксация изменений */

COMMIT
