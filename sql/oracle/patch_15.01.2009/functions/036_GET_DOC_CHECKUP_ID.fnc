/* Создание фунции генерации идентификатора таблицы документов осмотров */

CREATE OR REPLACE FUNCTION GET_DOC_CHECKUP_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_DOC_CHECKUPS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT