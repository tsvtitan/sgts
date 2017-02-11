/* Создание процедуры обновления полевого журнала 1 старых данных настенных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLW_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLW_JOURNAL_FIELDS_O1');
END;

--

/* Фиксация изменений */

COMMIT
