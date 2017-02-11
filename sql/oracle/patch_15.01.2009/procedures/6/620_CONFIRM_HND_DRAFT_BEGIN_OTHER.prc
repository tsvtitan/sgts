/* Создание процедуры утверждения осадки для поперечных гидронивелиров */

CREATE OR REPLACE PROCEDURE CONFIRM_HND_DRAFT_BEGIN_OTHER (
   JOURNAL_FIELD_ID IN INTEGER,
   ALGORITHM_ID IN INTEGER
)
AS
   AMEASURE_TYPE_ID INTEGER;
   ACYCLE_ID INTEGER;
   AWHO_CONFIRM INTEGER;
   ADATE_CONFIRM DATE;
   AGROUP_ID VARCHAR2 (32);
   APRIORITY INTEGER;
   APOINT_ID INTEGER;
   ADATE_OBSERVATION DATE;
   APARAM_ID INTEGER;
   AVALUE FLOAT;
   AROUTE_ID INTEGER;
   APOINT_NAME VARCHAR2 (250);
   DISPLACEMENT FLOAT;
   COMP_ID INTEGER;
   R_PRIORITY INTEGER;
   R_POINT_ID INTEGER;
   N_ZV INTEGER;
   N_ZV_TEMP INTEGER;
   FIRST_MARK_POINT_ID INTEGER;
   FIRST_MARK_ZV_POINT_ID INTEGER;
   FLAG BOOLEAN;
   O_SR_Z_1 FLOAT;
   O_SR_I FLOAT;
   O_SR_Z_0_1 FLOAT;
   O_SR_0_I FLOAT;
   S_Z_1 FLOAT;
   S_I_0 FLOAT;
   S_I_0_ZV_FIRST FLOAT;
   DATE_BEGIN DATE;
   DATE_END DATE;
BEGIN
   SELECT MEASURE_TYPE_ID,
          CYCLE_ID,
          WHO_CONFIRM,
          DATE_CONFIRM,
          GROUP_ID,
          PRIORITY,
          POINT_ID,
          DATE_OBSERVATION,
          PARAM_ID,
          VALUE
     INTO AMEASURE_TYPE_ID,
          ACYCLE_ID,
          AWHO_CONFIRM,
          ADATE_CONFIRM,
          AGROUP_ID,
          APRIORITY,
          APOINT_ID,
          ADATE_OBSERVATION,
          APARAM_ID,
          AVALUE
     FROM JOURNAL_FIELDS
    WHERE JOURNAL_FIELD_ID = CONFIRM_HND_DRAFT_BEGIN_OTHER.JOURNAL_FIELD_ID;

   IF (APARAM_ID = 50008)
   THEN
      SELECT ROUTE_ID
        INTO AROUTE_ID
        FROM ROUTE_POINTS
       WHERE POINT_ID = APOINT_ID;

      IF AROUTE_ID IN (50030, 50031, 50032, 50033, 50034, 50035, 50036, 50037, 50038, 50039, 50040, 50041, 50042, 50043, 50044, 50045, 50046, 50047)
      THEN
         DELETE FROM JOURNAL_OBSERVATIONS
               WHERE JOURNAL_FIELD_ID = CONFIRM_HND_DRAFT_BEGIN_OTHER.JOURNAL_FIELD_ID
                 AND ALGORITHM_ID = CONFIRM_HND_DRAFT_BEGIN_OTHER.ALGORITHM_ID
                 AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
                 AND CYCLE_ID = ACYCLE_ID
                 AND DATE_OBSERVATION = ADATE_OBSERVATION
                 AND GROUP_ID = AGROUP_ID
                 AND POINT_ID = APOINT_ID
                 AND PARAM_ID = 50024;   /* Осадка с нач. набл. */

         COMMIT;
      END IF;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN
         SELECT COMPONENT_ID
           INTO COMP_ID
           FROM COMPONENTS
          WHERE (CONVERTER_ID = APOINT_ID)
            AND (PARAM_ID = 50003);

         SELECT VALUE
           INTO N_ZV
           FROM CONVERTER_PASSPORTS
          WHERE (COMPONENT_ID = COMP_ID);

         FLAG := FALSE;

         FOR INC IN (SELECT   POINT_ID
                         FROM ROUTE_POINTS
                        WHERE (ROUTE_ID = AROUTE_ID)
                     ORDER BY PRIORITY ASC)
         LOOP
            SELECT COMPONENT_ID
              INTO COMP_ID
              FROM COMPONENTS
             WHERE (CONVERTER_ID = INC.POINT_ID)
               AND (PARAM_ID = 50003);

            SELECT VALUE
              INTO N_ZV_TEMP
              FROM CONVERTER_PASSPORTS
             WHERE (COMPONENT_ID = COMP_ID);

            IF     (N_ZV = N_ZV_TEMP)
               AND (FLAG = FALSE)
            THEN
               FIRST_MARK_ZV_POINT_ID := INC.POINT_ID;
               FLAG := TRUE;
            END IF;
         END LOOP;

         FLAG := FALSE;

         FOR INC IN (SELECT   POINT_ID
                         FROM ROUTE_POINTS
                        WHERE (ROUTE_ID = AROUTE_ID)
                     ORDER BY PRIORITY ASC)
         LOOP
            IF (FLAG = FALSE)
            THEN
               FIRST_MARK_POINT_ID := INC.POINT_ID;
               FLAG := TRUE;
            END IF;
         END LOOP;

         IF AROUTE_ID IN
                       (50030, 50031, 50032, 50033, 50034, 50035, 50036, 50037, 50038, 50039, 50040, 50041, 50042, 50043, 50044, 50045, 50046, 50047)
         THEN
            IF (APOINT_ID = FIRST_MARK_POINT_ID)
            THEN
               DISPLACEMENT := 0;
            END IF;

            IF     (APOINT_ID <> FIRST_MARK_POINT_ID)
               AND (APOINT_ID = FIRST_MARK_ZV_POINT_ID)
            THEN
               SELECT PRIORITY
                 INTO R_PRIORITY
                 FROM ROUTE_POINTS
                WHERE (POINT_ID = APOINT_ID);

               R_PRIORITY := R_PRIORITY - 1;

               SELECT POINT_ID
                 INTO R_POINT_ID
                 FROM ROUTE_POINTS
                WHERE (ROUTE_ID = AROUTE_ID)
                  AND (PRIORITY = R_PRIORITY);

               FOR INC IN (SELECT   VALUE
                               FROM JOURNAL_OBSERVATIONS
                              WHERE (POINT_ID = R_POINT_ID)
                                AND (CYCLE_ID = ACYCLE_ID)
                                AND (PARAM_ID = 50024)
                           ORDER BY DATE_OBSERVATION ASC)
               LOOP
                  DISPLACEMENT := INC.VALUE;
               END LOOP;
            END IF;

            IF     (APOINT_ID <> FIRST_MARK_POINT_ID)
               AND (APOINT_ID <> FIRST_MARK_ZV_POINT_ID)
            THEN
               FOR INC IN (SELECT   VALUE
                               FROM JOURNAL_OBSERVATIONS
                              WHERE (PARAM_ID = 50020)
                                AND (POINT_ID = FIRST_MARK_ZV_POINT_ID)
                                AND (CYCLE_ID = ACYCLE_ID)
                           ORDER BY DATE_OBSERVATION ASC)
               LOOP
                  O_SR_Z_1 := INC.VALUE;
               END LOOP;

               SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                 INTO O_SR_I
                 FROM JOURNAL_OBSERVATIONS
                WHERE (GROUP_ID = AGROUP_ID)
                  AND (PARAM_ID = 50020);

               FOR INC IN (SELECT COMPONENT_ID
                             FROM COMPONENTS
                            WHERE (CONVERTER_ID = FIRST_MARK_ZV_POINT_ID)
                              AND (PARAM_ID = 50061))
               LOOP
                  COMP_ID := INC.COMPONENT_ID;

                  SELECT DATE_BEGIN
                    INTO DATE_BEGIN
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  SELECT DATE_END
                    INTO DATE_END
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (ADATE_OBSERVATION <= DATE_END)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO O_SR_Z_0_1
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (DATE_END IS NULL)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO O_SR_Z_0_1
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;
               END LOOP;

               FOR INC IN (SELECT COMPONENT_ID
                             FROM COMPONENTS
                            WHERE (CONVERTER_ID = APOINT_ID)
                              AND (PARAM_ID = 50061))
               LOOP
                  COMP_ID := INC.COMPONENT_ID;

                  SELECT DATE_BEGIN
                    INTO DATE_BEGIN
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  SELECT DATE_END
                    INTO DATE_END
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (ADATE_OBSERVATION <= DATE_END)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO O_SR_0_I
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (DATE_END IS NULL)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO O_SR_0_I
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;
               END LOOP;

               FOR INC IN (SELECT COMPONENT_ID
                             FROM COMPONENTS
                            WHERE (CONVERTER_ID = FIRST_MARK_ZV_POINT_ID)
                              AND (PARAM_ID = 50060))
               LOOP
                  COMP_ID := INC.COMPONENT_ID;

                  SELECT DATE_BEGIN
                    INTO DATE_BEGIN
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  SELECT DATE_END
                    INTO DATE_END
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (ADATE_OBSERVATION <= DATE_END)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO S_Z_1
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (DATE_END IS NULL)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO S_Z_1
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;
               END LOOP;

               FOR INC IN (SELECT COMPONENT_ID
                             FROM COMPONENTS
                            WHERE (CONVERTER_ID = APOINT_ID)
                              AND (PARAM_ID = 50060))
               LOOP
                  COMP_ID := INC.COMPONENT_ID;

                  SELECT DATE_BEGIN
                    INTO DATE_BEGIN
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  SELECT DATE_END
                    INTO DATE_END
                    FROM CONVERTER_PASSPORTS
                   WHERE (COMPONENT_ID = COMP_ID);

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (ADATE_OBSERVATION <= DATE_END)
                  THEN
                     SELECT VALUE
                       INTO S_I_0
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;

                  IF     (ADATE_OBSERVATION >= DATE_BEGIN)
                     AND (DATE_END IS NULL)
                  THEN
                     SELECT DECODE (VALUE, NULL, 0, TO_NUMBER (REPLACE (VALUE, ',', '.'), 'FM999999.999999'))
                       INTO S_I_0
                       FROM CONVERTER_PASSPORTS
                      WHERE (COMPONENT_ID = COMP_ID);
                  END IF;
               END LOOP;

               FOR INC IN (SELECT   VALUE
                               FROM JOURNAL_OBSERVATIONS
                              WHERE (CYCLE_ID = ACYCLE_ID)
                                AND (POINT_ID = FIRST_MARK_ZV_POINT_ID)
                                AND (PARAM_ID = 50024)
                           ORDER BY DATE_OBSERVATION ASC)
               LOOP
                  S_I_0_ZV_FIRST := INC.VALUE;
               END LOOP;

               S_I_0 := S_I_0_ZV_FIRST + S_I_0;
               DISPLACEMENT := (O_SR_Z_1 - O_SR_I) - (O_SR_Z_0_1 - O_SR_0_I) + (S_Z_1 + S_I_0);
            END IF;
         END IF;

         IF (DISPLACEMENT IS NOT NULL)
         THEN
            I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                   JOURNAL_FIELD_ID,
                                   NULL,
                                   AMEASURE_TYPE_ID,
                                   2523,
                                   ADATE_OBSERVATION,
                                   ACYCLE_ID,
                                   APOINT_ID,
                                   50024,   /* Осадка с нач. набл. */
                                   DISPLACEMENT,
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
