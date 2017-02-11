/* Создание процедуры обновления полевого журнала 1 старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O1');
END;

--

/* Фиксация изменений */

COMMIT
