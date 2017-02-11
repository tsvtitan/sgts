/* Создание процедуры обновления полевого журнала 4 старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_FIELDS_O4
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_NDS_JOURNAL_FIELDS_O4'); 
END;

--

/* Фиксация изменений */

COMMIT
