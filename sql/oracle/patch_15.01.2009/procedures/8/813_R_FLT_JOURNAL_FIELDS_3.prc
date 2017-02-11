/* Создание процедуры обновления полевого журнала 3 старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_3
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O3'); 
END;

--

/* Фиксация изменений */

COMMIT
