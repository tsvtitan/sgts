/* Создание фунции генерации идентификатора таблицы журнала осмотров */

CREATE OR REPLACE FUNCTION GET_JOURNAL_CHECKUP_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_JOURNAL_CHECKUPS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT