/* Создание процедуры обновления полевого журнала старых данных отвесов */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_FIELDS
AS 
BEGIN 
  R_OTV_JOURNAL_FIELDS_1; 
  R_OTV_JOURNAL_FIELDS_2; 
END;

--

/* Фиксация изменений */

COMMIT
