/* Создание процедуры удаления типа точки */

CREATE OR REPLACE PROCEDURE D_POINT_TYPE
( 
  OLD_POINT_TYPE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM POINT_TYPES 
        WHERE POINT_TYPE_ID=OLD_POINT_TYPE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

