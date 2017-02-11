/* Создание процедуры обновления полевого журнала 4 старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_FIELDS_4
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O4');
END;

--

/* Фиксация изменений */

COMMIT
