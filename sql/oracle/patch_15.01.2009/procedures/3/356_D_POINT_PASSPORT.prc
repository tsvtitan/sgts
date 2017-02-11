/* Создание процедуры удаления паспорта точки */

CREATE OR REPLACE PROCEDURE D_POINT_PASSPORT
( 
  OLD_POINT_PASSPORT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM POINT_PASSPORTS 
        WHERE POINT_PASSPORT_ID=OLD_POINT_PASSPORT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

