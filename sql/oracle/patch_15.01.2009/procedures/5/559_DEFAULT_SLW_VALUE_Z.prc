/* Создание процедуры установки значения по умолчанию для Отсчета по Z настенного щелемера */

CREATE OR REPLACE PROCEDURE DEFAULT_SLW_VALUE_Z (
   DATE_OBSERVATION DATE,
   CYCLE_ID INTEGER,
   POINT_ID INTEGER,
   VALUE_6 IN OUT FLOAT,
   VALUE_7 IN OUT FLOAT,
   VALUE_8 IN OUT FLOAT
)
AS
   FACTOR_Z INTEGER;
   BASE_COUNTING_OUT_Z FLOAT;
   BASE_OPENING_Z FLOAT;
   COUNTING_OUT_Z FLOAT;
   OPENING_Z FLOAT;
   OPENING_LAST_Z FLOAT;
   ACYCLE_ID INTEGER;
   APOINT_ID INTEGER;
   ADATE DATE;
BEGIN
   IF (VALUE_6 IS NULL)
   THEN
      VALUE_6 := 0.0;
   END IF;

   COUNTING_OUT_Z := VALUE_6;
   APOINT_ID := POINT_ID;
   FACTOR_Z := 1;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30005 /* Коэффицент для расчета Z */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      FACTOR_Z := TO_NUMBER (INC.VALUE);
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   BASE_COUNTING_OUT_Z := 0.0;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30009 /* Отсчет по Z */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      BASE_COUNTING_OUT_Z := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   BASE_OPENING_Z := 0.0;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30012 /* Раскрытие с начала наблюдений по Z */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      BASE_OPENING_Z := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   OPENING_Z := COUNTING_OUT_Z * FACTOR_Z - BASE_COUNTING_OUT_Z * FACTOR_Z + BASE_OPENING_Z;
   ADATE := DATE_OBSERVATION;
   OPENING_LAST_Z := 0.0;

   FOR INC IN (SELECT   J.VALUE
                   FROM JOURNAL_FIELDS J,
                        CYCLES C
                  WHERE J.CYCLE_ID = C.CYCLE_ID
                    AND J.POINT_ID = APOINT_ID
                    AND J.PARAM_ID = 30012 /* Раскрытие с начала наблюдений по Z */
                    AND J.DATE_OBSERVATION < ADATE
               ORDER BY J.DATE_OBSERVATION DESC)
   LOOP
      OPENING_LAST_Z := INC.VALUE;
      EXIT WHEN OPENING_LAST_Z IS NOT NULL;
   END LOOP;

   VALUE_7 := OPENING_Z;
   VALUE_8 := OPENING_Z - OPENING_LAST_Z;
END;

--

/* Фиксация изменений */

COMMIT
