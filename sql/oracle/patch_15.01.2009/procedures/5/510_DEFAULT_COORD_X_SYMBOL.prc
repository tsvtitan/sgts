/* Создание процедуры по умолчанию для DEFAULT_COORD_X_SYMBOL */

CREATE OR REPLACE PROCEDURE DEFAULT_COORD_X_SYMBOL
( 
  VALUE_1 IN OUT FLOAT 
) 
AS 
BEGIN 
  IF (VALUE_1 IS NULL) THEN 
    VALUE_1:=0.0; 
  END IF;  
END;

--

/* Фиксация изменений */

COMMIT
