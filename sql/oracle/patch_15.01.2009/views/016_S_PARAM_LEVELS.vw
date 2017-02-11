/* Создание просмотра уровней параметров */

CREATE OR REPLACE VIEW S_PARAM_LEVELS
AS 
SELECT PL.PARAM_ID,
       PL.LEVEL_ID,
       PL.LEVEL_MIN,
       PL.LEVEL_MAX,
       P.NAME AS PARAM_NAME,
       L.NAME AS LEVEL_NAME
  FROM PARAM_LEVELS PL,
       PARAMS P,
       LEVELS L
 WHERE P.PARAM_ID = PL.PARAM_ID
   AND L.LEVEL_ID = PL.LEVEL_ID

--

/* Фиксация изменений */

COMMIT


