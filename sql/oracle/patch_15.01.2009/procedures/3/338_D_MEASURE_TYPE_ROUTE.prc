/* Создание процедуры удаления маршрута у вида измерения */

CREATE OR REPLACE PROCEDURE D_MEASURE_TYPE_ROUTE
( 
  OLD_MEASURE_TYPE_ID IN INTEGER, 
  OLD_ROUTE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM MEASURE_TYPE_ROUTES 
        WHERE MEASURE_TYPE_ID=OLD_MEASURE_TYPE_ID 
          AND ROUTE_ID=OLD_ROUTE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

