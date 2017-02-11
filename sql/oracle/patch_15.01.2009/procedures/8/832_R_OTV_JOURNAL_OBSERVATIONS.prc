/* Создание процедуры обновления журнала наблюдений старых данных отвесов */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  R_OTV_JOURNAL_OBSERVATIONS_1; 
  R_OTV_JOURNAL_OBSERVATIONS_2; 
END;

--

/* Фиксация изменений */

COMMIT
