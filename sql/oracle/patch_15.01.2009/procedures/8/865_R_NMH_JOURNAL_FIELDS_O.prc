/* Создание процедуры обновления полевого журнала старых данных нивелирования марок гидронивелира */

CREATE OR REPLACE PROCEDURE R_NMH_JOURNAL_FIELDS_O
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NMH_JOURNAL_FIELDS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
