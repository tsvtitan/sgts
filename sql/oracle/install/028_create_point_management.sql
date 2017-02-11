/* Создание последовательности для ввода измерительных точек */

CREATE SEQUENCE SEQ_POINT_MANAGEMENT 
INCREMENT BY 1 
START WITH 2500
MAXVALUE 1.0E28 
MINVALUE 2500
CYCLE 
CACHE 20 
NOORDER

--

/* Создание фунции генерации идентификатора для ввода измерительных точек */

CREATE FUNCTION GET_POINT_MANAGEMENT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_POINT_MANAGEMENT.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений БД */

COMMIT
