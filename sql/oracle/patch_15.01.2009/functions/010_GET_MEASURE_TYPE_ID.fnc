/* Создание фунции генерации идентификатора для таблицы видов измерений */

CREATE FUNCTION GET_MEASURE_TYPE_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_MEASURE_TYPES.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT
