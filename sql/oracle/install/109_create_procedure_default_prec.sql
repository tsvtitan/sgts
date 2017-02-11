/* Создание процедуры установки значения по умолчанию для Вида осадков */

CREATE OR REPLACE PROCEDURE DEFAULT_PREC
(
  POINT_ID IN INTEGER,
  PARAM_ID_5 IN INTEGER,
  INSTRUMENT_ID_5 IN INTEGER,
  MEASHURE_UNIT_ID_5 IN INTEGER,
  VALUE_5 IN OUT FLOAT
)
AS
BEGIN
  IF (VALUE_5 IS NULL) THEN 
    VALUE_5:=0.0;
  END IF;	
END;

--

/* Фиксация изменений БД */

COMMIT