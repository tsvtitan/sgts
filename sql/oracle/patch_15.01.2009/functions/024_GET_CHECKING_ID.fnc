/* Создание фунции генерации идентификатора для таблицы контроля */

CREATE OR REPLACE FUNCTION GET_CHECKING_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_CHECKINGS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT
