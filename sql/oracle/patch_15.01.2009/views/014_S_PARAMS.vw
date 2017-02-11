/* Создание просмотра параметров */

CREATE OR REPLACE VIEW S_PARAMS
AS 
SELECT P.PARAM_ID,
       P.ALGORITHM_ID,
       P.NAME,
       P.DESCRIPTION,
       P.PARAM_TYPE,
       P.FORMAT,
       P.DETERMINATION,
       P.IS_NOT_CONFIRM,
       A.NAME AS ALGORITHM_NAME
  FROM PARAMS P,
       ALGORITHMS A
 WHERE P.ALGORITHM_ID = A.ALGORITHM_ID(+)


--

/* Фиксация изменений */

COMMIT


