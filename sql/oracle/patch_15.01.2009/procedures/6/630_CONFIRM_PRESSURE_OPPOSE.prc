/* Создание процедуры расчета фильтрационного противодавления */

CREATE OR REPLACE PROCEDURE CONFIRM_PRESSURE_OPPOSE (
   JOURNAL_FIELD_ID IN INTEGER,
   ALGORITHM_ID IN INTEGER
)
AS
   JOURNAL_OBSERVATION_ID INTEGER;
   AMEASURE_TYPE_ID INTEGER;
   ACYCLE_ID INTEGER;
   AWHO_CONFIRM INTEGER;
   ADATE_CONFIRM DATE;
   AGROUP_ID VARCHAR2 (32);
   APRIORITY INTEGER;
   APOINT_ID INTEGER;
   APARAM_ID INTEGER;
   ADATE_OBSERVATION DATE;
   AVALUE FLOAT;
   AINSTRUMENT_ID INTEGER;
   AMEASURE_UNIT_ID INTEGER;
   PRESSURE_OPPOSE FLOAT;
   MARK_ROCK FLOAT;
   UNB FLOAT;
   MARK_WATER FLOAT;
   FLAG INTEGER;
BEGIN
   SELECT MEASURE_TYPE_ID,
          CYCLE_ID,
          WHO_CONFIRM,
          DATE_CONFIRM,
          GROUP_ID,
          PRIORITY,
          POINT_ID,
          DATE_OBSERVATION,
          VALUE,
          PARAM_ID,
          INSTRUMENT_ID,
          MEASURE_UNIT_ID
     INTO AMEASURE_TYPE_ID,
          ACYCLE_ID,
          AWHO_CONFIRM,
          ADATE_CONFIRM,
          AGROUP_ID,
          APRIORITY,
          APOINT_ID,
          ADATE_OBSERVATION,
          AVALUE,
          APARAM_ID,
          AINSTRUMENT_ID,
          AMEASURE_UNIT_ID
     FROM JOURNAL_FIELDS
    WHERE JOURNAL_FIELD_ID = CONFIRM_PRESSURE_OPPOSE.JOURNAL_FIELD_ID;

   IF (APARAM_ID = 2920)   /* Отсчет пьезометра */
   THEN
      DELETE FROM JOURNAL_OBSERVATIONS
            WHERE JOURNAL_FIELD_ID = CONFIRM_PRESSURE_OPPOSE.JOURNAL_FIELD_ID
              AND ALGORITHM_ID = CONFIRM_PRESSURE_OPPOSE.ALGORITHM_ID
              AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
              AND CYCLE_ID = ACYCLE_ID
              AND DATE_OBSERVATION = ADATE_OBSERVATION
              AND GROUP_ID = AGROUP_ID
              AND POINT_ID = APOINT_ID
              AND PARAM_ID = 2962;   /* Фильтрационное противодавление */

      COMMIT;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN
         FLAG := 0;
         UNB := 0;

         FOR INC IN (SELECT VALUE
                       FROM JOURNAL_OBSERVATIONS
                      WHERE DATE_OBSERVATION = ADATE_OBSERVATION
                        AND PARAM_ID = 2901 /* УНБ */)
         LOOP
            UNB := INC.VALUE;
            EXIT WHEN UNB IS NOT NULL;
         END LOOP;

         MARK_ROCK := 0;

         FOR INC IN (SELECT   CP.VALUE,
                              CP.DATE_BEGIN,
                              CP.DATE_END
                         FROM CONVERTER_PASSPORTS CP,
                              COMPONENTS C,
                              POINTS P
                        WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                          AND C.CONVERTER_ID = P.POINT_ID
                          AND P.POINT_ID = APOINT_ID
                          AND C.PARAM_ID = 2947   /* Отметка скалы */
                     ORDER BY CP.DATE_BEGIN)
         LOOP
            MARK_ROCK := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
            EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                 AND (ADATE_OBSERVATION <= INC.DATE_END);
         END LOOP;

         MARK_WATER := 0;

         FOR INC IN (SELECT VALUE
                       FROM JOURNAL_OBSERVATIONS
                      WHERE JOURNAL_FIELD_ID = CONFIRM_PRESSURE_OPPOSE.JOURNAL_FIELD_ID
                        AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
                        AND CYCLE_ID = ACYCLE_ID
                        AND DATE_OBSERVATION = ADATE_OBSERVATION
                        AND GROUP_ID = AGROUP_ID
                        AND POINT_ID = APOINT_ID
                        AND ALGORITHM_ID = 2800   /* Отметка уровня воды */
                        AND PARAM_ID = 2960 /* Отметка уровня воды */)
         LOOP
            MARK_WATER := INC.VALUE;
            EXIT WHEN MARK_WATER IS NOT NULL;
         END LOOP;

         IF     (MARK_WATER IS NOT NULL)
            AND (UNB IS NOT NULL)
            AND (MARK_ROCK IS NOT NULL)
         THEN
            FLAG := 1;

            IF (MARK_ROCK <= UNB)
            THEN
               PRESSURE_OPPOSE := MARK_WATER - UNB;
            ELSE
               PRESSURE_OPPOSE := MARK_WATER - MARK_ROCK;
            END IF;
         END IF;

         IF (FLAG = 1)
         THEN
            I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                   JOURNAL_FIELD_ID,
                                   NULL,
                                   AMEASURE_TYPE_ID,
                                   NULL,
                                   ADATE_OBSERVATION,
                                   ACYCLE_ID,
                                   APOINT_ID,
                                   2962,   /* Фильтрационное противодавление */
                                   PRESSURE_OPPOSE,
                                   AWHO_CONFIRM,
                                   ADATE_CONFIRM,
                                   ALGORITHM_ID,
                                   AGROUP_ID,
                                   APRIORITY
                                  );
         END IF;
      END IF;
   END IF;
END;

--

/* Фиксация */

COMMIT
