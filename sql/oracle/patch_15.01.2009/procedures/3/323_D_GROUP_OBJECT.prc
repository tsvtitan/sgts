/* Создание процедуры удаления объекта из группы */

CREATE OR REPLACE PROCEDURE D_GROUP_OBJECT
( 
  OLD_GROUP_ID IN INTEGER, 
  OLD_OBJECT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM GROUP_OBJECTS 
        WHERE GROUP_ID=OLD_GROUP_ID 
          AND OBJECT_ID=OLD_OBJECT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

