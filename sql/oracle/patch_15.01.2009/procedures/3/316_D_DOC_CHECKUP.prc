/* Создание процедуры удаления документа осмотра */

CREATE OR REPLACE PROCEDURE D_DOC_CHECKUP
( 
  OLD_DOC_CHECKUP_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DOC_CHECKUPS 
        WHERE DOC_CHECKUP_ID=OLD_DOC_CHECKUP_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

