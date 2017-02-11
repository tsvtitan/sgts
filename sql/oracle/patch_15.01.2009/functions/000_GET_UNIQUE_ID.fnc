/* Создание функции получения уникального идентификатора */

CREATE OR REPLACE FUNCTION GET_UNIQUE_ID 
RETURN VARCHAR2 
AS 
  RET VARCHAR2(32); 
BEGIN 
  RET:=SYS_GUID(); 
  RET:=SUBSTR(RET,21,12)||SUBSTR(RET,17,4)||SUBSTR(RET,13,4)||SUBSTR(RET,9,4)||SUBSTR(RET,1,8); 
  RETURN RET; 
END;

--

/* Фиксация изменений */

COMMIT


