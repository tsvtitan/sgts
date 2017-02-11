/* Создание фунции генерации идентификатора для таблицы точек */

CREATE OR REPLACE FUNCTION GET_POINT_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_POINTS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

