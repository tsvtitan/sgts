/* Создание процедуры обновления журнала наблюдений старых данных настенных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLW_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_SLW_JOURNAL_OBSERVATIONS_1;
  R_SLW_JOURNAL_OBSERVATIONS_2;
END;

--

/* Фиксация изменений */

COMMIT
