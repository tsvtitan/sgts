/* Создание процедуры удаления файлового отчета */

CREATE OR REPLACE PROCEDURE D_FILE_REPORT
( 
  OLD_FILE_REPORT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM FILE_REPORTS 
        WHERE FILE_REPORT_ID=OLD_FILE_REPORT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

