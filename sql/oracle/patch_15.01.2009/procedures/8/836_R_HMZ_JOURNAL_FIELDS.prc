/* Создание процедуры обновления полевого журнала старых данных химанализа */

CREATE OR REPLACE PROCEDURE R_HMZ_JOURNAL_FIELDS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
