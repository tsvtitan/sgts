/* Создание просмотра устройств */

CREATE OR REPLACE VIEW S_DEVICES
AS 
SELECT D.DEVICE_ID,D.NAME,D.DESCRIPTION,D.DATE_ENTER
  FROM DEVICES D

--

/* Фиксация изменений */

COMMIT


