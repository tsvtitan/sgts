/* Создание процедуры удаления вида дефекта */

CREATE OR REPLACE PROCEDURE D_DEFECT_VIEW
( 
  OLD_DEFECT_VIEW_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DEFECT_VIEWS 
        WHERE DEFECT_VIEW_ID=OLD_DEFECT_VIEW_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

