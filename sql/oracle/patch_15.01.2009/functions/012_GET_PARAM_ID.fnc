/* Создание фунции генерации идентификатора для таблицы параметров */

CREATE OR REPLACE FUNCTION GET_PARAM_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_PARAMS.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

