/* Создание процедуры установки значения по умолчанию для Mg(+) */

CREATE OR REPLACE PROCEDURE DEFAULT_MG
(
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