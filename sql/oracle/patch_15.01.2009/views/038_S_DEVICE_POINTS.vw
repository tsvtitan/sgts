/* Создание просмотра измерительных точек устройств */

CREATE OR REPLACE VIEW S_DEVICE_POINTS
AS
SELECT DP.DEVICE_ID,
       DP.POINT_ID,
       DP.PRIORITY,
       D.NAME AS DEVICE_NAME,
       P.NAME AS POINT_NAME
  FROM DEVICE_POINTS DP,
       DEVICES D,
       POINTS P
 WHERE D.DEVICE_ID = DP.DEVICE_ID
   AND P.POINT_ID = DP.POINT_ID

--

/* Фиксация изменений */

COMMIT


