/* Создание фунции генерации идентификатора для таблицы прав */

CREATE OR REPLACE FUNCTION GET_PERMISSION_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_PERMISSIONS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

