/* Создание процедуры установки значения по умолчанию для состояния водовода */

CREATE OR REPLACE PROCEDURE DEFAULT_STATE_WATER_CARRIER
( 
  POINT_ID INTEGER, 
  PARAM_ID_4 IN INTEGER, 
  INSTRUMENT_ID_4 IN INTEGER, 
  MEASHURE_UNIT_ID_4 IN INTEGER, 
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
