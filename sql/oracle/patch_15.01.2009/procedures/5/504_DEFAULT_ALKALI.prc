/* Создание процедуры установки значения по умолчанию для Щелочности */

CREATE OR REPLACE PROCEDURE DEFAULT_ALKALI
( 
  VALUE_4 IN OUT FLOAT 
)   
AS 
BEGIN 
  IF (VALUE_4 IS NULL) THEN 
    VALUE_4:=0.0; 
  END IF; 
END;

--

/* Фиксация изменений */

COMMIT
