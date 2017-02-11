/* Создание процедуры удаления чертежа объекта */

CREATE OR REPLACE PROCEDURE D_OBJECT_DRAWING
( 
  OLD_OBJECT_ID IN INTEGER, 
  OLD_DRAWING_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM OBJECT_DRAWINGS 
        WHERE OBJECT_ID=OLD_OBJECT_ID 
          AND DRAWING_ID=OLD_DRAWING_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

