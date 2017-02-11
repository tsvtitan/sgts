/* Обновление полевого журнала */

BEGIN
   UPDATE JOURNAL_FIELDS
      SET MEASURE_TYPE_ID = 70024
    WHERE MEASURE_TYPE_ID = 49984 AND POINT_ID IN (SELECT POINT_ID
                                                     FROM ROUTE_POINTS
                                                    WHERE ROUTE_ID = 50030);

   COMMIT;
END;
