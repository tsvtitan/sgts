/* Создание процедуры утверждения всех записе в полевом журнале */

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

            FOR INC IN (SELECT   /*+ FIRST_ROWS INDEX(JF) INDEX(MTR) INDEX(RP) INDEX(MTP) */
                                 JF.JOURNAL_FIELD_ID
                            FROM JOURNAL_FIELDS JF,
                                 MEASURE_TYPE_ROUTES MTR,
                                 ROUTE_POINTS RP,
                                 MEASURE_TYPE_PARAMS MTP
                           WHERE JF.MEASURE_TYPE_ID = MTR.MEASURE_TYPE_ID
                             AND RP.ROUTE_ID = MTR.ROUTE_ID
                             AND RP.POINT_ID = JF.POINT_ID
                             AND JF.MEASURE_TYPE_ID = MTP.MEASURE_TYPE_ID
                             AND JF.PARAM_ID = MTP.PARAM_ID
                             AND JF.MEASURE_TYPE_ID = CONFIRM_ALL.MEASURE_TYPE_ID
                             AND JF.CYCLE_ID = CONFIRM_ALL.CYCLE_ID
                             AND JF.IS_BASE = 1
                        ORDER BY JF.DATE_OBSERVATION DESC,
                                 RP.PRIORITY DESC,
                                 MTP.PRIORITY DESC)
            LOOP
               CONFIRM_JOURNAL_FIELD (INC.JOURNAL_FIELD_ID);
               EXIT;
            END LOOP;
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
               FOR INC2 IN (SELECT   /*+ FIRST_ROWS INDEX(JF) INDEX(MTR) INDEX(RP) INDEX(MTP) */
                                     JF.JOURNAL_FIELD_ID
                                FROM JOURNAL_FIELDS JF,
                                     MEASURE_TYPE_ROUTES MTR,
                                     ROUTE_POINTS RP,
                                     MEASURE_TYPE_PARAMS MTP
                               WHERE JF.MEASURE_TYPE_ID = MTR.MEASURE_TYPE_ID
                                 AND RP.ROUTE_ID = MTR.ROUTE_ID
                                 AND RP.POINT_ID = JF.POINT_ID
                                 AND JF.MEASURE_TYPE_ID = MTP.MEASURE_TYPE_ID
                                 AND JF.PARAM_ID = MTP.PARAM_ID
                                 AND JF.MEASURE_TYPE_ID = CONFIRM_ALL.MEASURE_TYPE_ID
                                 AND JF.CYCLE_ID = INC1.CYCLE_ID
                                 AND JF.IS_BASE = 1
                            ORDER BY JF.DATE_OBSERVATION DESC,
                                     RP.PRIORITY DESC,
                                     MTP.PRIORITY DESC)
               LOOP
                  CONFIRM_JOURNAL_FIELD (INC2.JOURNAL_FIELD_ID);
                  EXIT;
               END LOOP;
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
            FOR INC2 IN (SELECT   /*+ FIRST_ROWS INDEX(JF) INDEX(MTR) INDEX(RP) INDEX(MTP) */
                                  JF.JOURNAL_FIELD_ID
                             FROM JOURNAL_FIELDS JF,
                                  MEASURE_TYPE_ROUTES MTR,
                                  ROUTE_POINTS RP,
                                  MEASURE_TYPE_PARAMS MTP
                            WHERE JF.MEASURE_TYPE_ID = MTR.MEASURE_TYPE_ID
                              AND RP.ROUTE_ID = MTR.ROUTE_ID
                              AND RP.POINT_ID = JF.POINT_ID
                              AND JF.MEASURE_TYPE_ID = MTP.MEASURE_TYPE_ID
                              AND JF.PARAM_ID = MTP.PARAM_ID
                              AND JF.MEASURE_TYPE_ID = CONFIRM_ALL.MEASURE_TYPE_ID
                              AND JF.CYCLE_ID = INC1.CYCLE_ID
                              AND JF.IS_BASE = 1
                         ORDER BY JF.DATE_OBSERVATION DESC,
                                  RP.PRIORITY DESC,
                                  MTP.PRIORITY DESC)
            LOOP
               CONFIRM_JOURNAL_FIELD (INC2.JOURNAL_FIELD_ID);
               EXIT;
            END LOOP;
         END LOOP;
      END IF;
   END IF;
END;

--

/* Фиксация */

COMMIT
