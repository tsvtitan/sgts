/* Создание процедуры установки значения по умолчанию для CO2 св */

CREATE OR REPLACE PROCEDURE DEFAULT_CO2SV
( 
  POINT_ID INTEGER, 
  PARAM_ID_1 IN INTEGER, 
  INSTRUMENT_ID_1 IN INTEGER, 
  MEASHURE_UNIT_ID_1 IN INTEGER, 
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
