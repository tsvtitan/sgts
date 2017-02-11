/* Создание процедуры обновления полевого журнала старых данных фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS
AS 
BEGIN 
  R_FLT_JOURNAL_FIELDS_1; 
  R_FLT_JOURNAL_FIELDS_2; 
  R_FLT_JOURNAL_FIELDS_3; 
  R_FLT_JOURNAL_FIELDS_4; 
  R_FLT_JOURNAL_FIELDS_5; 
  R_FLT_JOURNAL_FIELDS_6; 
END;

--

/* Фиксация изменений */

COMMIT
