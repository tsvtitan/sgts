/* Создание процедуры обновления журнала наблюдений старых данных напольных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_SLF_JOURNAL_OBSERVATIONS_1;
  R_SLF_JOURNAL_OBSERVATIONS_2;
END;

--

/* Фиксация изменений */

COMMIT
