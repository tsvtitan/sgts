/* Создание процедуры расчета действующего напора */

CREATE OR REPLACE PROCEDURE CONFIRM_PRESSURE_ACTIVE (
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
   PRESSURE_ACTIVE FLOAT;
   MARK_ROCK FLOAT;
   UVB FLOAT;
   UNB FLOAT;
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
    WHERE JOURNAL_FIELD_ID = CONFIRM_PRESSURE_ACTIVE.JOURNAL_FIELD_ID;

   IF (APARAM_ID = 2920)   /* Отсчет пьезометра */
   THEN
      DELETE FROM JOURNAL_OBSERVATIONS
            WHERE JOURNAL_FIELD_ID = CONFIRM_PRESSURE_ACTIVE.JOURNAL_FIELD_ID
              AND ALGORITHM_ID = CONFIRM_PRESSURE_ACTIVE.ALGORITHM_ID
              AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
              AND CYCLE_ID = ACYCLE_ID
              AND DATE_OBSERVATION = ADATE_OBSERVATION
              AND GROUP_ID = AGROUP_ID
              AND POINT_ID = APOINT_ID
              AND PARAM_ID = 2961;   /* Действующий напор */

      COMMIT;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN
         FLAG := 0;
         UVB := 0;

         FOR INC IN (SELECT VALUE
                       FROM JOURNAL_OBSERVATIONS
                      WHERE DATE_OBSERVATION = ADATE_OBSERVATION
                        AND PARAM_ID = 2900 /* УВБ */)
         LOOP
            UVB := INC.VALUE;
            EXIT WHEN UVB IS NOT NULL;
         END LOOP;

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

         IF     (UVB IS NOT NULL)
            AND (UNB IS NOT NULL)
            AND (MARK_ROCK IS NOT NULL)
         THEN
            FLAG := 1;

            IF (MARK_ROCK <= UNB)
            THEN
               PRESSURE_ACTIVE := UVB - UNB;
            ELSE
               PRESSURE_ACTIVE := UVB - MARK_ROCK;
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
                                   2961,   /* Действующий напор */
                                   PRESSURE_ACTIVE,
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
