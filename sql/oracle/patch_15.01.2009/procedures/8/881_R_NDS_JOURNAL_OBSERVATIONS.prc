/* Создание процедуры обновления журнала наблюдений старых данных напряженно-деформированного состояния */

CREATE OR REPLACE PROCEDURE R_NDS_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  R_NDS_JOURNAL_OBSERVATIONS_O1;
  R_NDS_JOURNAL_OBSERVATIONS_O2;
  R_NDS_JOURNAL_OBSERVATIONS_O3;
  R_NDS_JOURNAL_OBSERVATIONS_O4;
  R_NDS_JOURNAL_OBSERVATIONS_O5;  
END;

--

/* Фиксация изменений */

COMMIT
