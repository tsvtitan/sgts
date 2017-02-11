/* Создание фунции генерации идентификатора для таблицы типов точек */

CREATE OR REPLACE FUNCTION GET_POINT_TYPE_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_POINT_TYPES.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

