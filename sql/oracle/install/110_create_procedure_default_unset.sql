/* Создание процедуры установки значения по умолчанию для Сброса */

CREATE OR REPLACE PROCEDURE DEFAULT_UNSET
(
  POINT_ID IN INTEGER,
  PARAM_ID_6 IN INTEGER,
  INSTRUMENT_ID_6 IN INTEGER,
  MEASHURE_UNIT_ID_6 IN INTEGER,
  VALUE_6 IN OUT FLOAT
)
AS
BEGIN
  IF (VALUE_6 IS NULL) THEN 
    VALUE_6:=0.0;
  END IF;	
END;

--

/* Фиксация изменений БД */

COMMIT