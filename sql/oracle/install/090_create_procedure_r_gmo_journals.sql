/* Создание процедуры обновления срезов по Гидрометеорологии */

CREATE OR REPLACE PROCEDURE R_GMO_JOURNALS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_FIELDS_OLD');
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_OBSERVATIONS_OLD');
END;

--

/* Фиксация изменений БД */

COMMIT