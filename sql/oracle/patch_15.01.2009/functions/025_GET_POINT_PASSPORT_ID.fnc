/* Создание фунции генерации идентификатора для таблицы паспортов точек */

CREATE OR REPLACE FUNCTION GET_POINT_PASSPORT_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_POINT_PASSPORTS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

