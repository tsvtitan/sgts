/* Создание процедуры обновления полевого журнала старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_FIELDS
AS
BEGIN
  R_SL1_JOURNAL_FIELDS_1;
  R_SL1_JOURNAL_FIELDS_2;
  R_SL1_JOURNAL_FIELDS_3;
  R_SL1_JOURNAL_FIELDS_4;
END;

--

/* Фиксация изменений */

COMMIT
