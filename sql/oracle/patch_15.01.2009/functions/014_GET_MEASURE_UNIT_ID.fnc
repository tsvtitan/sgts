/* Создание фунции генерации идентификатора для таблицы единиц измерения */

CREATE OR REPLACE FUNCTION GET_MEASURE_UNIT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_MEASURE_UNITS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT