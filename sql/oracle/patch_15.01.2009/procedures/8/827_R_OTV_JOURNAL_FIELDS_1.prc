/* Создание процедуры обновления полевого журнала 1 старых данных отвесов */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_FIELDS_1
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_OTV_JOURNAL_FIELDS_O1'); 
END;

--

/* Фиксация изменений */

COMMIT
