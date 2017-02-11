/* Создание процедуры по умолчанию для отсчета марки 2 */

CREATE OR REPLACE PROCEDURE DEFAULT_OTSCHET_MARK_2 (
   POINT_ID INTEGER,
   CYCLE_ID INTEGER,
   PARAM_ID_2 IN INTEGER,
   INSTRUMENT_ID_2 IN INTEGER,
   MEASHURE_UNIT_ID_2 IN INTEGER,
   VALUE_1 IN FLOAT,
   VALUE_2 IN OUT FLOAT,
   VALUE_4 IN OUT FLOAT,
   VALUE_5 IN OUT FLOAT
)
AS
   F_OT FLOAT;
   L_OT FLOAT;
   M_OT FLOAT;
   M_OT_INT INTEGER;
   M_OT_STR VARCHAR2 (100);
   LAST_SYMB VARCHAR2 (1);
   ST VARCHAR2 (100);
   SUM_F FLOAT;
   SUM_L FLOAT;
   SUM_SQR FLOAT;
BEGIN
   IF (VALUE_2 IS NULL)
   THEN
      VALUE_2 := 0.0;
   END IF;

   IF     (VALUE_1 IS NOT NULL)
      AND (VALUE_2 IS NOT NULL)
   THEN
      F_OT := VALUE_1;
      L_OT := VALUE_2;
      VALUE_4 := (F_OT + L_OT) / 2;
      VALUE_4 := VALUE_4 * 100;
      M_OT_INT := VALUE_4 - MOD (VALUE_4, 1);
      M_OT_STR := TO_NCHAR (M_OT_INT);

      SELECT SUBSTR (M_OT_STR, LENGTH (M_OT_STR), 1)
        INTO LAST_SYMB
        FROM DUAL;

      IF LAST_SYMB = '0'
      THEN
         VALUE_4 := M_OT_INT / 100;
      END IF;

      IF    LAST_SYMB = '1'
         OR LAST_SYMB = '2'
         OR LAST_SYMB = '3'
         OR LAST_SYMB = '4'
      THEN
         SELECT SUBSTR (M_OT_STR, 1, LENGTH (M_OT_STR) - 1)
           INTO ST
           FROM DUAL;

         ST := ST || '2';
         M_OT_INT := TO_NUMBER (ST);
         VALUE_4 := M_OT_INT / 100;
      END IF;

      IF LAST_SYMB = '5'
      THEN
         VALUE_4 := M_OT_INT / 100;
      END IF;

      IF    LAST_SYMB = '6'
         OR LAST_SYMB = '7'
         OR LAST_SYMB = '8'
         OR LAST_SYMB = '9'
      THEN
         SELECT SUBSTR (M_OT_STR, 1, LENGTH (M_OT_STR) - 1)
           INTO ST
           FROM DUAL;

         ST := ST || '8';
         M_OT_INT := TO_NUMBER (ST);
         VALUE_4 := M_OT_INT / 100;
      END IF;

      SUM_SQR := 0;

      FOR INC IN (SELECT VALUE,
                         POINT_ID
                    FROM JOURNAL_OBSERVATIONS
                   WHERE CYCLE_ID = DEFAULT_OTSCHET_MARK_2.CYCLE_ID
                     AND PARAM_ID = 15121)
      LOOP
         SUM_F := INC.VALUE;

         FOR INC2 IN (SELECT VALUE
                        FROM JOURNAL_OBSERVATIONS
                       WHERE CYCLE_ID = DEFAULT_OTSCHET_MARK_2.CYCLE_ID
                         AND PARAM_ID = 15122
                         AND POINT_ID = INC.POINT_ID)
         LOOP
            SUM_L := INC2.VALUE;
            SUM_SQR := SUM_SQR + POWER (SUM_F - SUM_L, 2);
         END LOOP;
      END LOOP;

      VALUE_5 := ROUND (SQRT (SUM_SQR / 110) * 0.5 * 1000) / 1000;
   END IF;
END;

--

/* Фиксация изменений */

COMMIT
