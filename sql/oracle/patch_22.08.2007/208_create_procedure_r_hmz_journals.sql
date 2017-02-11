/* Создание процедуры обновления срезов по Химанализу */

CREATE OR REPLACE PROCEDURE R_HMZ_JOURNALS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_FIELDS_O');
  DBMS_REFRESH.REFRESH('S_HMZ_JOURNAL_OBSERVATIONS_O');
END;

--

/* Фиксация изменений БД */

COMMIT