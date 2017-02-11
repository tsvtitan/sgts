/* Создание процедуры обновления полевого журнала старых данных температуры и влажности */

CREATE OR REPLACE PROCEDURE R_TVL_JOURNAL_FIELDS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_TVL_JOURNAL_FIELDS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
