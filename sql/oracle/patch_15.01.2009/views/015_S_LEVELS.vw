/* Создание просмотра уровней */

CREATE OR REPLACE VIEW S_LEVELS
AS 
SELECT L.LEVEL_ID,
       L.NAME,
       L.DESCRIPTION
  FROM LEVELS L

--

/* Фиксация изменений */

COMMIT


