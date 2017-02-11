/* Создание процедуры удаления точки из маршрута */

CREATE OR REPLACE PROCEDURE D_ROUTE_POINT
( 
  OLD_ROUTE_ID IN INTEGER, 
  OLD_POINT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM ROUTE_POINTS 
        WHERE ROUTE_ID=OLD_ROUTE_ID 
          AND POINT_ID=OLD_POINT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

