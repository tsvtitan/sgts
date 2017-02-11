/* Создание фунции генерации идентификатора для таблицы объектов */

CREATE OR REPLACE FUNCTION GET_OBJECT_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_OBJECTS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT


