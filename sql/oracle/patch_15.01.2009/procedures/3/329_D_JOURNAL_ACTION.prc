/* Создание процедуры удаления записи в журнале действий */

CREATE OR REPLACE PROCEDURE D_JOURNAL_ACTION
( 
  OLD_JOURNAL_ACTION_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM JOURNAL_ACTIONS 
        WHERE JOURNAL_ACTION_ID=OLD_JOURNAL_ACTION_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

