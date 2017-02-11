/* Создание процедуры обновления журнала наблюдений старых данных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  R_PZM_JOURNAL_OBSERVATIONS_1; 
  R_PZM_JOURNAL_OBSERVATIONS_2; 
  R_PZM_JOURNAL_OBSERVATIONS_3; 
END;

--

/* Фиксация изменений */

COMMIT
