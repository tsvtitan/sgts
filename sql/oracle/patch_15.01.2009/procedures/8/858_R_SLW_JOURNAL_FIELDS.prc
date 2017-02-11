/* Создание процедуры обновления полевого журнала старых данных настенных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLW_JOURNAL_FIELDS
AS
BEGIN
  R_SLW_JOURNAL_FIELDS_1;
  R_SLW_JOURNAL_FIELDS_2;
END;

--

/* Фиксация изменений */

COMMIT
