/* Создание процедуры по умолчанию для разницы курса */

CREATE OR REPLACE PROCEDURE DEFAULT_DIFFERENCE_COURSE (
   CYCLE_ID IN INTEGER,
   POINT_ID IN INTEGER,
   VALUE_1 IN FLOAT,
   VALUE_2 IN FLOAT,
   VALUE_3 IN OUT FLOAT
)
AS
BEGIN
   VALUE_3 := ABS (VALUE_2 - VALUE_1);
END;

--

/* Фиксация изменений */

COMMIT
