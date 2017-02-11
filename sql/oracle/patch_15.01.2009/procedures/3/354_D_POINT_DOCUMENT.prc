/* Создание процедуры удаления документа точки */

CREATE OR REPLACE PROCEDURE D_POINT_DOCUMENT
( 
  OLD_POINT_ID IN INTEGER, 
  OLD_DOCUMENT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM POINT_DOCUMENTS 
        WHERE POINT_ID=OLD_POINT_ID 
          AND DOCUMENT_ID=OLD_DOCUMENT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

