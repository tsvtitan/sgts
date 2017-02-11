/* Создание процедуры по умолчанию DEFAULT_SO4_2 */

CREATE OR REPLACE PROCEDURE DEFAULT_SO4_2
( 
  VALUE_9 IN OUT FLOAT 
)   
AS 
BEGIN 
  IF (VALUE_9 IS NULL) THEN 
    VALUE_9:=0.0; 
  END IF; 
END;

--

/* Фиксация изменений */

COMMIT
