/* Создание просмотра чертежей */

CREATE OR REPLACE VIEW S_DRAWINGS
AS 
SELECT D.DRAWING_ID,D.NAME,D.DESCRIPTION,D.FILE_NAME
  FROM DRAWINGS D

--

/* Фиксация изменений */

COMMIT


