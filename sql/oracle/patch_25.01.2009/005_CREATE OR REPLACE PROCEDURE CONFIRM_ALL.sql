/* Создание процедуры утверждения за вид измерения */

CREATE OR REPLACE PROCEDURE CONFIRM_ALL (
   MEASURE_TYPE_ID IN INTEGER,
   CYCLE_ID IN INTEGER,
   WHO_CONFIRM IN INTEGER,
   MORE IN INTEGER,
   WITH_CONFIRM IN INTEGER
)
AS
   ACYCLE_NUM INTEGER;
BEGIN
   IF (MEASURE_TYPE_ID IS NOT NULL)
   THEN
      IF (CYCLE_ID IS NOT NULL)
      THEN
         IF (MORE IS NULL)
         THEN
            IF (WITH_CONFIRM IS NOT NULL)
            THEN
               UPDATE JOURNAL_FIELDS
                  SET WHO_CONFIRM = CONFIRM_ALL.WHO_CONFIRM,
                      DATE_CONFIRM = SYSDATE
                WHERE MEASURE_TYPE_ID = CONFIRM_ALL.MEASURE_TYPE_ID
                  AND CYCLE_ID = CONFIRM_ALL.CYCLE_ID
                  AND IS_BASE = 1;

               COMMIT;
            END IF;

            CONFIRM_JOURNAL_FIELDS (MEASURE_TYPE_ID,CYCLE_ID);
			
         ELSE
            SELECT CYCLE_NUM
              INTO ACYCLE_NUM
              FROM CYCLES
             WHERE CYCLE_ID = CONFIRM_ALL.CYCLE_ID;

            IF (WITH_CONFIRM IS NOT NULL)
            THEN
               UPDATE JOURNAL_FIELDS
                  SET WHO_CONFIRM = CONFIRM_ALL.WHO_CONFIRM,
                      DATE_CONFIRM = SYSDATE
                WHERE MEASURE_TYPE_ID = CONFIRM_ALL.MEASURE_TYPE_ID
                  AND CYCLE_ID IN (SELECT C.CYCLE_ID
                                     FROM CYCLES C
                                    WHERE C.CYCLE_NUM >= ACYCLE_NUM)
                  AND IS_BASE = 1;

               COMMIT;
            END IF;

            FOR INC1 IN (SELECT   CYCLE_ID
                             FROM CYCLES
                            WHERE CYCLE_NUM >= ACYCLE_NUM
                         ORDER BY CYCLE_NUM)
            LOOP
			   CONFIRM_JOURNAL_FIELDS (MEASURE_TYPE_ID,INC1.CYCLE_ID);
            END LOOP;
         END IF;
      ELSE
         IF (WITH_CONFIRM IS NOT NULL)
         THEN
            UPDATE JOURNAL_FIELDS
               SET WHO_CONFIRM = CONFIRM_ALL.WHO_CONFIRM,
                   DATE_CONFIRM = SYSDATE
             WHERE MEASURE_TYPE_ID = CONFIRM_ALL.MEASURE_TYPE_ID
               AND IS_BASE = 1;

            COMMIT;
         END IF;

         FOR INC1 IN (SELECT   CYCLE_ID
                          FROM CYCLES
                      ORDER BY CYCLE_NUM)
         LOOP
		    CONFIRM_JOURNAL_FIELDS (MEASURE_TYPE_ID,INC1.CYCLE_ID);
         END LOOP;
      END IF;
   END IF;
END;

--

/* Фиксация изменения */

COMMIT