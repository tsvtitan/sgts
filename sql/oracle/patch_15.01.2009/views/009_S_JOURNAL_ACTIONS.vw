/* Создание просмотра журнала действий */

CREATE OR REPLACE VIEW S_JOURNAL_ACTIONS
AS 
SELECT JA.JOURNAL_ACTION_ID,
       JA.PERSONNEL_ID,
       JA.DATE_ACTION,
       JA.OBJECT,
       JA.METHOD,
       JA.PARAM,
       JA.VALUE,
       P.FNAME || ' ' || P.NAME || ' ' || P.SNAME AS PERSONNEL_NAME
  FROM JOURNAL_ACTIONS JA,
       PERSONNELS P
 WHERE JA.PERSONNEL_ID = P.PERSONNEL_ID

--

/* Фиксация изменений */

COMMIT


