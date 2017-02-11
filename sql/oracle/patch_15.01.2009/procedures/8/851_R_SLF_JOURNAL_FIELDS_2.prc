/* Создание процедуры обновления полевого журнала 2 старых данных напольных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_FIELDS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLF_JOURNAL_FIELDS_O2');
END;

--

/* Фиксация изменений */

COMMIT
