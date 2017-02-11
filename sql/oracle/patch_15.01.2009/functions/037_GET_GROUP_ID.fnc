/* Создание фунции генерации идентификатора для таблицы групп */

CREATE FUNCTION GET_GROUP_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_GROUPS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT