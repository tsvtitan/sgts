/* Создание процедуры установки значения по умолчанию для Объема водохранилища */

CREATE OR REPLACE PROCEDURE DEFAULT_V_VAULT
(
  POINT_ID IN INTEGER,
  PARAM_ID_8 IN INTEGER,
  INSTRUMENT_ID_8 IN INTEGER,
  MEASHURE_UNIT_ID_8 IN INTEGER,
  VALUE_8 IN OUT FLOAT
)
AS
BEGIN
  IF (VALUE_8 IS NULL) THEN 
    VALUE_8:=0.0;
  END IF;	
END;

--

/* Фиксация изменений БД */

COMMIT