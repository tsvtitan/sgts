/* Создание процедуры обновления журнала наблюдений 3 старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_OBSERVATIONS_3
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Фиксация изменений */

COMMIT
