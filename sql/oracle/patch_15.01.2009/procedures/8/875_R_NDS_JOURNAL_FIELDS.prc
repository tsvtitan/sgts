/* Создание процедуры обновления полевого журнала старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_FIELDS
AS 
BEGIN 
  R_NDS_JOURNAL_FIELDS_O1;
  R_NDS_JOURNAL_FIELDS_O2;
  R_NDS_JOURNAL_FIELDS_O3;
  R_NDS_JOURNAL_FIELDS_O4;
  R_NDS_JOURNAL_FIELDS_O5;  
END;

--

/* Фиксация изменений */

COMMIT
