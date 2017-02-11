/* Создание процедуры установки значения по умолчанию для Притока */

CREATE OR REPLACE PROCEDURE DEFAULT_INFLUX
(
  POINT_ID IN INTEGER,
  PARAM_ID_7 IN INTEGER,
  INSTRUMENT_ID_7 IN INTEGER,
  MEASHURE_UNIT_ID_7 IN INTEGER,
  VALUE_7 IN OUT FLOAT
)
AS
BEGIN
  IF (VALUE_7 IS NULL) THEN 
    VALUE_7:=0.0;
  END IF;	
END;

--

/* Фиксация изменений БД */

COMMIT