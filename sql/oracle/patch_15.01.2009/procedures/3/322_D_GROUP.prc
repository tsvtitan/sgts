/* Создание процедуры удаления группы */

CREATE OR REPLACE PROCEDURE D_GROUP
( 
  OLD_GROUP_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM GROUPS 
        WHERE GROUP_ID=OLD_GROUP_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

