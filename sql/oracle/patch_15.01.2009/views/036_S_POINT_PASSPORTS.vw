/* Создание просмотра паспортов измерительных точек */

CREATE OR REPLACE VIEW S_POINT_PASSPORTS
AS 
SELECT PP.POINT_PASSPORT_ID,
       PP.POINT_ID,
       PP.DATE_CHECKUP,
       PP.DESCRIPTION,
       P.NAME AS POINT_NAME
  FROM POINT_PASSPORTS PP,
       POINTS P
 WHERE PP.POINT_ID = P.POINT_ID

--

/* Фиксация изменений */

COMMIT


