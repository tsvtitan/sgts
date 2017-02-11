/* Создание процедуры обновления полевого журнала 3 старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_FIELDS_3
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_FIELDS_O3');
END;

--

/* Фиксация изменений */

COMMIT
