/* Создание процедуры удаления отдела */

CREATE OR REPLACE PROCEDURE D_DIVISION
( 
  OLD_DIVISION_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DIVISIONS 
        WHERE DIVISION_ID=OLD_DIVISION_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

