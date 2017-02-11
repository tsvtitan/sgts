/* Создание процедуры контроля CHECK_DIFF_COURSE */

CREATE OR REPLACE PROCEDURE CHECK_DIFF_COURSE (
   VALUE IN FLOAT,
   SUCCESS OUT INTEGER,
   INFO OUT VARCHAR2
)
AS
BEGIN
   IF (VALUE > 0.25)
   THEN
      SUCCESS := 0;
      INFO := 'Контроль не пройден. Значение > 0.25';
   ELSE
      SUCCESS := 1;
      INFO := 'Контроль пройден. Значение <= 0.25';
   END IF;
END;

--

/* Фиксация изменений */

COMMIT
