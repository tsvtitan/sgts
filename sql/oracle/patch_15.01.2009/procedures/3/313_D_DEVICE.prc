/* Создание процедуры удаления устройства */

CREATE OR REPLACE PROCEDURE D_DEVICE
( 
  OLD_DEVICE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM DEVICES 
        WHERE DEVICE_ID=OLD_DEVICE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

