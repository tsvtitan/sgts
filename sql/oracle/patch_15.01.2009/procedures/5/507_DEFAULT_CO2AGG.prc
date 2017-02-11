/* Создание процедуры установки значения по умолчанию для CO2 агр */

CREATE OR REPLACE PROCEDURE DEFAULT_CO2AGG (
   VALUE_3 IN OUT FLOAT,
   VALUE_10 IN OUT FLOAT,
   VALUE_12 IN OUT FLOAT
)
AS
BEGIN
   IF (VALUE_3 IS NULL)
   THEN
      VALUE_3 := 0.0;
   END IF;

   IF     (VALUE_10 IS NOT NULL)
      AND (VALUE_10 <> 0.0)
   THEN
      VALUE_12 := POWER (VALUE_3, 2) / (0.36 * VALUE_10 + VALUE_3);
   ELSE
      IF (VALUE_3 <> 0.0)
      THEN
         VALUE_12 := POWER (VALUE_3, 2) / (0.36 * 0.0 + VALUE_3);
      END IF;
   END IF;
END;


--

/* Фиксация изменений */

COMMIT
