/* Создание функции генерации идентификатора для таблицы отделов */

CREATE FUNCTION GET_DIVISION_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_DIVISIONS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT
