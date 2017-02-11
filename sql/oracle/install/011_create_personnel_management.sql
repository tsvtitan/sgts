/* Создание последовательности для управления персоналом */

CREATE SEQUENCE SEQ_PERSONNEL_MANAGEMENT 
INCREMENT BY 1 
START WITH 2500
MAXVALUE 1.0E28 
MINVALUE 2500
CYCLE 
CACHE 20 
NOORDER

--

/* Создание фунции генерации идентификатора для ввода управления персоналом */

CREATE FUNCTION GET_PERSONNEL_MANAGEMENT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_PERSONNEL_MANAGEMENT.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений БД */

COMMIT
