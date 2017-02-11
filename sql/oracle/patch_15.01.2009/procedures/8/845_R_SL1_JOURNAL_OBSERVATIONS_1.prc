/* Создание процедуры обновления журнала наблюдений 1 старых данных одноосных щелемеров */

CREATE OR REPLACE PROCEDURE R_SL1_JOURNAL_OBSERVATIONS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SL1_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Фиксация изменений */

COMMIT
