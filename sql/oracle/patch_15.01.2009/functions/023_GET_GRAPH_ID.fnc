/* Создание функции генерации идентификатора для таблицы графиков */

CREATE FUNCTION GET_GRAPH_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_GRAPHS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT