/* Создание фунции генерации идентификатора для таблицы критериев безопасности */

CREATE OR REPLACE FUNCTION GET_CRITERIA_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_CRITERIAS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT