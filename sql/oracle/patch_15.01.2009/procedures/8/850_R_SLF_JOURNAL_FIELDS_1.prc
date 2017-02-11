/* Создание процедуры обновления полевого журнала 1 старых данных напольных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLF_JOURNAL_FIELDS_O1');
END;

--

/* Фиксация изменений */

COMMIT
