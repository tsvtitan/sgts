/* Создание процедуры установки значения по умолчанию для Отсчета одноосного щелемера */

CREATE OR REPLACE PROCEDURE DEFAULT_SL1_VALUE (
   DATE_OBSERVATION DATE,
   CYCLE_ID INTEGER,
   POINT_ID INTEGER,
   VALUE_0 IN OUT FLOAT,
   VALUE_1 IN OUT FLOAT,
   VALUE_2 IN OUT FLOAT
)
AS
   DIRECTION INTEGER;
   BASE_COUNTING_OUT FLOAT;
   BASE_OPENING FLOAT;
   COUNTING_OUT FLOAT;
   OPENING FLOAT;
   OPENING_LAST FLOAT;
   ACYCLE_ID INTEGER;
   APOINT_ID INTEGER;
   ADATE DATE;
BEGIN
   IF (VALUE_0 IS NULL)
   THEN
      VALUE_0 := 0.0;
   END IF;

   COUNTING_OUT := VALUE_0;
   APOINT_ID := POINT_ID;
   DIRECTION := 1;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30001 /* направление шкалы */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      DIRECTION := TO_NUMBER (INC.VALUE);
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   BASE_COUNTING_OUT := 0.0;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30000 /* Отсчет */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      BASE_COUNTING_OUT := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   BASE_OPENING := 0.0;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30002 /* Раскрытие с начала наблюдений */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      BASE_OPENING := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   IF (DIRECTION = 1)
   THEN
      OPENING := COUNTING_OUT - BASE_COUNTING_OUT + BASE_OPENING;
   ELSE
      OPENING := BASE_COUNTING_OUT - COUNTING_OUT + BASE_OPENING;
   END IF;

   ADATE := DATE_OBSERVATION;
   OPENING_LAST := 0.0;

   FOR INC IN (SELECT   J.VALUE
                   FROM JOURNAL_FIELDS J,
                        CYCLES C
                  WHERE J.CYCLE_ID = C.CYCLE_ID
                    AND J.POINT_ID = APOINT_ID
                    AND J.PARAM_ID = 30002 /* Раскрытие с начала наблюдений */
                    AND J.DATE_OBSERVATION < ADATE
               ORDER BY J.DATE_OBSERVATION DESC)
   LOOP
      OPENING_LAST := INC.VALUE;
      EXIT WHEN OPENING_LAST IS NOT NULL;
   END LOOP;

   VALUE_1 := OPENING;
   VALUE_2 := OPENING - OPENING_LAST;
END;

--

/* Фиксация изменений */

COMMIT
