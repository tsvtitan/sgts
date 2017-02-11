/* Создание процедуры обновления журнала наблюдений старых данных гидронивелиров */

CREATE OR REPLACE PROCEDURE R_HDN_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_HDN_JOURNAL_OBSERVATIONS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
