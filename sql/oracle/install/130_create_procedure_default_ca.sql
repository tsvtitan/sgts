/* Создание процедуры установки значения по умолчанию для Ca(+) */

CREATE OR REPLACE PROCEDURE DEFAULT_CA
(
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