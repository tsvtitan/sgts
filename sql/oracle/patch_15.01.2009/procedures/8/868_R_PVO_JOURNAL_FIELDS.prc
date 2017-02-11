/* Создание процедуры обновления полевого журнала старых данных планово-высотного обоснования */

CREATE OR REPLACE PROCEDURE R_PVO_JOURNAL_FIELDS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_PVO_JOURNAL_FIELDS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
