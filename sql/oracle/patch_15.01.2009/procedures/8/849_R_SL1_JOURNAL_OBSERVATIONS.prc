/* Создание процедуры обновления журнала наблюдений старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_SL1_JOURNAL_OBSERVATIONS_1;
  R_SL1_JOURNAL_OBSERVATIONS_2;
  R_SL1_JOURNAL_OBSERVATIONS_3;
  R_SL1_JOURNAL_OBSERVATIONS_4;
END;

--

/* Фиксация изменений */

COMMIT
