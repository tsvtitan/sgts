/* Создание процедуры по умолчанию для температуры воздуха */

CREATE OR REPLACE PROCEDURE DEFAULT_T_AIR
( 
  POINT_ID IN INTEGER, 
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
