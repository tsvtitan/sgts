/* Создание процедуры по умолчанию для DEFAULT_MARK_POINT */

CREATE OR REPLACE PROCEDURE DEFAULT_MARK_POINT
( 
  VALUE_0 IN OUT FLOAT 
) 
AS 
BEGIN 
  IF (VALUE_0 IS NULL) THEN 
    VALUE_0:=0.0; 
  END IF; 
END;

--

/* Фиксация изменений */

COMMIT
