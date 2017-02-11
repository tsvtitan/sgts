/* Создание процедуры удаления персоны */

CREATE OR REPLACE PROCEDURE D_PERSONNEL
( 
  OLD_PERSONNEL_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM PERSONNELS 
        WHERE PERSONNEL_ID=OLD_PERSONNEL_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

