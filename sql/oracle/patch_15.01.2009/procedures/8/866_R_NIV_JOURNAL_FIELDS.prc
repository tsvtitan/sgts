/* Создание процедуры обновления полевого журнала старых данных нивелирования */

CREATE OR REPLACE PROCEDURE R_NIV_JOURNAL_FIELDS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NIV_JOURNAL_FIELDS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
