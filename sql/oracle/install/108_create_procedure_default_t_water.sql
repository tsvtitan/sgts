/* Создание процедуры установки значения по умолчанию для Т воды */

CREATE OR REPLACE PROCEDURE DEFAULT_T_WATER
(
  POINT_ID IN INTEGER,
  PARAM_ID_3 IN INTEGER,
  INSTRUMENT_ID_3 IN INTEGER,
  MEASHURE_UNIT_ID_3 IN INTEGER,
  VALUE_3 IN OUT FLOAT
)
AS
BEGIN
  IF (VALUE_3 IS NULL) THEN 
    VALUE_3:=0.0;
  END IF;	
END;

--

/* Фиксация изменений БД */

COMMIT