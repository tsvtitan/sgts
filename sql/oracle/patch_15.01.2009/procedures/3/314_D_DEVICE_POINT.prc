/* Создание процедуры удаления точки из устройства */

CREATE OR REPLACE PROCEDURE D_DEVICE_POINT
( 
  OLD_DEVICE_ID IN INTEGER, 
  OLD_POINT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DEVICE_POINTS 
        WHERE DEVICE_ID=OLD_DEVICE_ID 
          AND POINT_ID=OLD_POINT_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

