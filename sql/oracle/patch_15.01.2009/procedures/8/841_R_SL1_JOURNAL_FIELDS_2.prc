/* Создание процедуры обновления полевого журнала 2 старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_FIELDS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O2');
END;

--

/* Фиксация изменений */

COMMIT
