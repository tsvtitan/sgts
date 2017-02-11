/* Создание процедуры установки значения по умолчанию для Na(+)+K(+) */

CREATE OR REPLACE PROCEDURE DEFAULT_NA_K
(
  VALUE_11 IN OUT FLOAT
)  
AS
BEGIN
  IF (VALUE_11 IS NULL) THEN
    VALUE_11:=0.0;
  END IF;
END;

--

/* Фиксация изменений БД */

COMMIT