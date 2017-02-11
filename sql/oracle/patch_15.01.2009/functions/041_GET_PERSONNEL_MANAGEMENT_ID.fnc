/* Создание фунции генерации идентификатора для ввода управления персоналом */

CREATE OR REPLACE FUNCTION GET_PERSONNEL_MANAGEMENT_ID RETURN INTEGER IS 
  ID INTEGER; 
BEGIN 
  SELECT SEQ_PERSONNEL_MANAGEMENT.NEXTVAL INTO ID FROM DUAL; 
  RETURN ID; 
END;

--

/* Фиксация изменений */

COMMIT

