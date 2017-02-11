/* Создание фунции генерации идентификатора для ввода измерительных точек */

CREATE OR REPLACE FUNCTION GET_POINT_MANAGEMENT_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_POINT_MANAGEMENT.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

