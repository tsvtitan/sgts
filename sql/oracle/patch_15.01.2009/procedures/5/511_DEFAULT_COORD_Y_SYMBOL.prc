/* Создание процедуры по умолчанию для DEFAULT_COORD_Y_SYMBOL */

CREATE OR REPLACE PROCEDURE DEFAULT_COORD_Y_SYMBOL
( 
  VALUE_2 IN OUT FLOAT 
) 
AS 
BEGIN 
  IF (VALUE_2 IS NULL) THEN 
    VALUE_2:=0.0; 
  END IF;  
END;

--

/* Фиксация изменений */

COMMIT
