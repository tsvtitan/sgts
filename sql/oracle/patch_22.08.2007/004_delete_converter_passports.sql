/* Очистка таблицы паспортов преобразователей Береговых пьезометров */

BEGIN
  DELETE FROM CONVERTER_PASSPORTS
   WHERE COMPONENT_ID IN (SELECT COMPONENT_ID FROM COMPONENTS
                           WHERE CONVERTER_ID IN (SELECT POINT_ID FROM ROUTE_POINTS
                                                   WHERE ROUTE_ID=2582));
  COMMIT;
END;

