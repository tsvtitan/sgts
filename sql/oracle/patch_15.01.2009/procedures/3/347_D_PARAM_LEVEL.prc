/* Создание процедуры удаления уровня параметра */

CREATE OR REPLACE PROCEDURE D_PARAM_LEVEL
( 
  OLD_PARAM_ID IN INTEGER, 
  OLD_LEVEL_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM PARAM_LEVELS 
        WHERE PARAM_ID=OLD_PARAM_ID 
          AND LEVEL_ID=OLD_LEVEL_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

