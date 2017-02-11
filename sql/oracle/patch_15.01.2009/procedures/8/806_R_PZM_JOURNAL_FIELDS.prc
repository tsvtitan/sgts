/* Создание процедуры обновления полевого журнала старых данных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_FIELDS
AS 
BEGIN 
  R_PZM_JOURNAL_FIELDS_1; 
  R_PZM_JOURNAL_FIELDS_2; 
  R_PZM_JOURNAL_FIELDS_3; 
END;

--

/* Фиксация изменений */

COMMIT
