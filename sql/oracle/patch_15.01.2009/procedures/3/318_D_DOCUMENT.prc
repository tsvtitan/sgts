/* Создание процедуры удаления документа */

CREATE OR REPLACE PROCEDURE D_DOCUMENT
( 
  OLD_DOCUMENT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DOCUMENTS 
        WHERE DOCUMENT_ID=OLD_DOCUMENT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

