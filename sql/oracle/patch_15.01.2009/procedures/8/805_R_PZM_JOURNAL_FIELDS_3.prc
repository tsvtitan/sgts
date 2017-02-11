/* Создание процедуры обновления полевого журнала 3 старых данных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_FIELDS_3
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O3'); 
END;

--

/* Фиксация изменений */

COMMIT
