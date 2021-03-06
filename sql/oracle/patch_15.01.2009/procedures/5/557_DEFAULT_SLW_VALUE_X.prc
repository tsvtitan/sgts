/* �������� ��������� ��������� �������� �� ��������� ��� ������� �� X ���������� �������� */

CREATE OR REPLACE PROCEDURE DEFAULT_SLW_VALUE_X (
   DATE_OBSERVATION DATE,
   CYCLE_ID INTEGER,
   POINT_ID INTEGER,
   VALUE_0 IN OUT FLOAT,
   VALUE_1 IN OUT FLOAT,
   VALUE_2 IN OUT FLOAT
)
AS
   BASE_COUNTING_OUT_X FLOAT;
   BASE_OPENING_X FLOAT;
   COUNTING_OUT_X FLOAT;
   OPENING_X FLOAT;
   OPENING_LAST_X FLOAT;
   ACYCLE_ID INTEGER;
   APOINT_ID INTEGER;
   ADATE DATE;
BEGIN
   IF (VALUE_0 IS NULL)
   THEN
      VALUE_0 := 0.0;
   END IF;

   COUNTING_OUT_X := VALUE_0;
   APOINT_ID := POINT_ID;
   BASE_COUNTING_OUT_X := 0.0;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30006 /* ������ �� X */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      BASE_COUNTING_OUT_X := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   BASE_OPENING_X := 0.0;

   FOR INC IN (SELECT   CP.VALUE,
                        CP.DATE_BEGIN,
                        CP.DATE_END
                   FROM CONVERTER_PASSPORTS CP,
                        COMPONENTS C
                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                    AND C.CONVERTER_ID = APOINT_ID
                    AND C.PARAM_ID = 30010 /* ��������� � ������ ���������� �� X */
               ORDER BY CP.DATE_BEGIN)
   LOOP
      BASE_OPENING_X := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
      EXIT WHEN (DATE_OBSERVATION >= INC.DATE_BEGIN)
           AND (DATE_OBSERVATION < INC.DATE_END);
   END LOOP;

   OPENING_X := COUNTING_OUT_X - BASE_COUNTING_OUT_X + BASE_OPENING_X;
   ADATE := DATE_OBSERVATION;
   OPENING_LAST_X := 0.0;

   FOR INC IN (SELECT   J.VALUE
                   FROM JOURNAL_FIELDS J,
                        CYCLES C
                  WHERE J.CYCLE_ID = C.CYCLE_ID
                    AND J.POINT_ID = APOINT_ID
                    AND J.PARAM_ID = 30010 /* ��������� � ������ ���������� �� X */
                    AND J.DATE_OBSERVATION < ADATE
               ORDER BY J.DATE_OBSERVATION DESC)
   LOOP
      OPENING_LAST_X := INC.VALUE;
      EXIT WHEN OPENING_LAST_X IS NOT NULL;
   END LOOP;

   VALUE_1 := OPENING_X;
   VALUE_2 := OPENING_X - OPENING_LAST_X;
END;

--

/* �������� ��������� */

COMMIT
