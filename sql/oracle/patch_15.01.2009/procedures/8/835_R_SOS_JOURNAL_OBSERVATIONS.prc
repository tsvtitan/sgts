/* Создание процедуры обновления журнала наблюдений старых данных струнно-отптического створа */

CREATE OR REPLACE PROCEDURE R_SOS_JOURNAL_OBSERVATIONS
AS 
BEGIN 
  DBMS_REFRESH.REFRESH('S_SOS_JOURNAL_OBSERVATIONS_O'); 
END;

--

/* Фиксация изменений */

COMMIT
