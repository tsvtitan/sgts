/* Создание фунции генерации идентификатора для таблицы персонала */

CREATE OR REPLACE FUNCTION GET_PERSONNEL_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_PERSONNELS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

