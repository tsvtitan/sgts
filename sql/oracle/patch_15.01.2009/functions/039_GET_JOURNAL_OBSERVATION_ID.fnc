/* Создание фунции генерации идентификатора таблицы журнала наблюдений */

CREATE OR REPLACE FUNCTION GET_JOURNAL_OBSERVATION_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_JOURNAL_OBSERVATIONS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT