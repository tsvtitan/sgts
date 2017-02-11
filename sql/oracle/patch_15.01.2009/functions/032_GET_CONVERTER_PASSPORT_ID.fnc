/* Создание фунции генерации идентификатора для таблицы паспорт преобразователей */

CREATE OR REPLACE FUNCTION GET_CONVERTER_PASSPORT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_CONVERTER_PASSPORTS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT