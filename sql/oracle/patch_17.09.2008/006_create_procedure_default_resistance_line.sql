/* Создание процедуры установки значения по умолчанию для сопротивления линии */

CREATE OR REPLACE PROCEDURE DEFAULT_RESISTANCE_LINE
(
  POINT_ID INTEGER,
  PARAM_ID_0 IN INTEGER,
  INSTRUMENT_ID_0 IN INTEGER,
  MEASHURE_UNIT_ID_0 IN INTEGER,
  VALUE_0 IN OUT FLOAT
)  
AS
BEGIN
  IF (VALUE_0 IS NULL) THEN
    VALUE_0:=0.0;
  END IF;
END;

--

/* Фиксация изменений БД */

COMMIT