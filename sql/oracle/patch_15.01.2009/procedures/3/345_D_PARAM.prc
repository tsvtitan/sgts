/* Создание процедуры удаления параметра */

CREATE OR REPLACE PROCEDURE D_PARAM
( 
  OLD_PARAM_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM PARAMS 
        WHERE PARAM_ID=OLD_PARAM_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

