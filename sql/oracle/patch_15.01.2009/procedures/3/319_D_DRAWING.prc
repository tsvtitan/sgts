/* Создание процедуры удаления чертежа */

CREATE OR REPLACE PROCEDURE D_DRAWING
( 
  OLD_DRAWING_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DRAWINGS 
        WHERE DRAWING_ID=OLD_DRAWING_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

