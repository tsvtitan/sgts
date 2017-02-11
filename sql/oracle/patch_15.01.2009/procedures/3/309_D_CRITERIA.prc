/* Создание процедуры удаления критерия безопасности */

CREATE OR REPLACE PROCEDURE D_CRITERIA
( 
  OLD_CRITERIA_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM CRITERIAS 
        WHERE CRITERIA_ID=OLD_CRITERIA_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

