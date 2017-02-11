/* Создание просмотра типов измерительных точек */

CREATE OR REPLACE VIEW S_POINT_TYPES
AS 
SELECT PT.POINT_TYPE_ID,PT.NAME,PT.DESCRIPTION
  FROM POINT_TYPES PT

--

/* Фиксация изменений */

COMMIT


