/* Создание процедуры удаления уровня */

CREATE OR REPLACE PROCEDURE D_LEVEL
( 
  OLD_LEVEL_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM LEVELS 
        WHERE LEVEL_ID=OLD_LEVEL_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

