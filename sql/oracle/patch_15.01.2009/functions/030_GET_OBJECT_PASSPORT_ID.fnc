/* Создание фунции генерации идентификатора для таблицы паспортов объектов */

CREATE OR REPLACE FUNCTION GET_OBJECT_PASSPORT_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_OBJECT_PASSPORTS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

