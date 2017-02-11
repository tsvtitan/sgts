/* Создание процедуры обновления журнала наблюдений старых данных планово-высотного обоснования */

CREATE OR REPLACE PROCEDURE R_PVO_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_PVO_JOURNAL_OBSERVATIONS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
