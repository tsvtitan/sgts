/* Создание просмотра объектов маршрута */

CREATE OR REPLACE VIEW S_ROUTE_OBJECTS
AS
  SELECT RP.ROUTE_ID,
         R.NAME AS ROUTE_NAME,
         RP.POINT_ID,
	   P.NAME AS POINT_NAME,
	   P.OBJECT_ID,
	   O.NAME AS OBJECT_NAME   
    FROM ROUTE_POINTS RP, 
         ROUTES R,
	   POINTS P,
	   OBJECTS O   
   WHERE RP.ROUTE_ID=R.ROUTE_ID
     AND RP.POINT_ID=P.POINT_ID
     AND P.OBJECT_ID=O.OBJECT_ID

--

/* Фиксация изменений БД */

COMMIT
