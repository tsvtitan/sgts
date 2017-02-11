/* Создание фунции генерации идентификатора для таблицы типов приборов */

CREATE OR REPLACE FUNCTION GET_INSTRUMENT_TYPE_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_INSTRUMENT_TYPES.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT