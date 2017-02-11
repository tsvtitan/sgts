/* Создание фунции генерации идентификатора для таблицы циклов */

CREATE FUNCTION GET_CYCLE_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_CYCLES.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT