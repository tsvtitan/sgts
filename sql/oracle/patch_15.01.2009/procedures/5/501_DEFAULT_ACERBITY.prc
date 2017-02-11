/* Создание процедуры установки значения по умолчанию для Жесткости */

CREATE OR REPLACE PROCEDURE DEFAULT_ACERBITY
( 
  VALUE_5 IN OUT FLOAT 
)   
AS 
BEGIN 
  IF (VALUE_5 IS NULL) THEN 
    VALUE_5:=0.0; 
  END IF; 
END;

--

/* Фиксация изменений */

COMMIT
