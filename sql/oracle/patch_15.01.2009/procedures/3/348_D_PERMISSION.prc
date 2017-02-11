/* Создание процедуры удаления права доступа */

CREATE OR REPLACE PROCEDURE D_PERMISSION
( 
  OLD_PERMISSION_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM PERMISSIONS 
        WHERE PERMISSION_ID=OLD_PERMISSION_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

