/* Создание процедуры установки значения по умолчанию для CO3(-2) */

CREATE OR REPLACE PROCEDURE DEFAULT_CO3_2
( 
  POINT_ID INTEGER, 
  PARAM_ID_2 IN INTEGER, 
  INSTRUMENT_ID_2 IN INTEGER, 
  MEASHURE_UNIT_ID_2 IN INTEGER, 
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
