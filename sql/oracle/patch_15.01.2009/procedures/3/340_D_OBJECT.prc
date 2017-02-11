/* Создание процедуры удаления объекта */

CREATE OR REPLACE PROCEDURE D_OBJECT
( 
  OLD_OBJECT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM OBJECTS 
        WHERE OBJECT_ID=OLD_OBJECT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

