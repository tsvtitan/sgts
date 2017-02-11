/* Создание процедуры обновления полевого журнала старых данных напольных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_FIELDS
AS
BEGIN
  R_SLF_JOURNAL_FIELDS_1;
  R_SLF_JOURNAL_FIELDS_2;
END;

--

/* Фиксация изменений */

COMMIT
