/* Создание процедуры утверждения за вид измерения и цикл */

CREATE OR REPLACE PROCEDURE CONFIRM_JOURNAL_FIELDS (
   MEASURE_TYPE_ID IN INTEGER,
   CYCLE_ID IN INTEGER
)
AS
   SQLS VARCHAR2 (5000) := NULL;
BEGIN
   IF     (CYCLE_ID IS NOT NULL)
      AND (MEASURE_TYPE_ID IS NOT NULL)
   THEN
      FOR INC IN (SELECT   A.PROC_NAME,
                           A.ALGORITHM_ID
                      FROM MEASURE_TYPE_ALGORITHMS MTA,
                           ALGORITHMS A
                     WHERE MTA.ALGORITHM_ID = A.ALGORITHM_ID
                       AND MTA.MEASURE_TYPE_ID = CONFIRM_JOURNAL_FIELDS.MEASURE_TYPE_ID
                       AND MTA.DATE_BEGIN <= TRUNC (CURRENT_DATE)
                       AND (   MTA.DATE_END IS NULL
                            OR MTA.DATE_END >= TRUNC (CURRENT_DATE))
                  ORDER BY MTA.PRIORITY)
      LOOP
         FOR INC2 IN (SELECT   /*+ INDEX(JF) */
                               JOURNAL_FIELD_ID
                          FROM JOURNAL_FIELDS JF
                         WHERE MEASURE_TYPE_ID = CONFIRM_JOURNAL_FIELDS.MEASURE_TYPE_ID
                           AND CYCLE_ID = CONFIRM_JOURNAL_FIELDS.CYCLE_ID
						   AND WHO_CONFIRM IS NOT NULL
						   AND IS_BASE = 1
                      ORDER BY DATE_OBSERVATION)
         LOOP
            SQLS := 'BEGIN ' || INC.PROC_NAME || '(' || TO_CHAR (INC2.JOURNAL_FIELD_ID) || ',' || TO_CHAR (INC.ALGORITHM_ID) || '); END;';

            EXECUTE IMMEDIATE SQLS;
         END LOOP;
      END LOOP;
   END IF;
END;

--

/* Фиксация изменения */

COMMIT