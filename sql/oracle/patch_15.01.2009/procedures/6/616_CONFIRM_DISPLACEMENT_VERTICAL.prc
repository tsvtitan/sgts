/* Создание процедуры утверждения CONFIRM_DISPLACEMENT_VERTICAL */

CREATE OR REPLACE PROCEDURE CONFIRM_DISPLACEMENT_VERTICAL (
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
   ADATE_OBSERVATION DATE;
   APARAM_ID INTEGER;
   AVALUE FLOAT;
   DISPLACEMENT FLOAT;
   COMP_ID INTEGER;
   NUM_VER INTEGER;
   NUM_VER2 INTEGER;
   OO_P_ID INTEGER;
   GRUPPA_OTVESA VARCHAR2 (50);
   GRUPPA_OTVESA2 VARCHAR2 (50);
   MAX_OTM FLOAT;
   SM FLOAT;
   SM2 FLOAT;
   OTM FLOAT;
   OTM2 FLOAT;
   OTM2_S VARCHAR2 (100);
   OTM_S VARCHAR2 (100);
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
    WHERE JOURNAL_FIELD_ID = CONFIRM_DISPLACEMENT_VERTICAL.JOURNAL_FIELD_ID;

   IF    (APARAM_ID = 17161)
      OR (APARAM_ID = 17162) /* СМЕЩЕНИЕ по оси X или Y */
   THEN
      DELETE FROM JOURNAL_OBSERVATIONS
            WHERE JOURNAL_FIELD_ID = CONFIRM_DISPLACEMENT_VERTICAL.JOURNAL_FIELD_ID
              AND ALGORITHM_ID = CONFIRM_DISPLACEMENT_VERTICAL.ALGORITHM_ID
              AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
              AND CYCLE_ID = ACYCLE_ID
              AND DATE_OBSERVATION = ADATE_OBSERVATION
              AND GROUP_ID = AGROUP_ID
              AND POINT_ID = APOINT_ID
              AND (   (PARAM_ID = 17165) /* Смещение от вертикали по X */
                   OR (PARAM_ID = 17166));

      /* Смещение от вертикали по Y */
      COMMIT;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN /* Обработка */             /* Запоминаем номер вертикали точки */
         SELECT COMPONENT_ID
           INTO COMP_ID
           FROM COMPONENTS
          WHERE (PARAM_ID = 16141)
            AND (CONVERTER_ID = APOINT_ID);

         SELECT VALUE
           INTO NUM_VER
           FROM CONVERTER_PASSPORTS
          WHERE COMPONENT_ID = COMP_ID;

         IF (NUM_VER > 0)
         THEN /* Запоминаем группу отвеса */
            SELECT COMPONENT_ID
              INTO COMP_ID
              FROM COMPONENTS
             WHERE (PARAM_ID = 16140)
               AND (CONVERTER_ID = APOINT_ID);

            SELECT VALUE
              INTO GRUPPA_OTVESA
              FROM CONVERTER_PASSPORTS
             WHERE COMPONENT_ID = COMP_ID;

            /* Находим смещение с начала наблюдений */
            SM := AVALUE;

            IF    (GRUPPA_OTVESA = 'ОО глубинный')
               OR (GRUPPA_OTVESA = 'ОО контактный')
            THEN /* Запоминаем отм. устан. измерит. столика */
               SELECT COMPONENT_ID
                 INTO COMP_ID
                 FROM COMPONENTS
                WHERE (PARAM_ID = 16145)
                  AND (CONVERTER_ID = APOINT_ID);

               SELECT VALUE
                 INTO OTM_S
                 FROM CONVERTER_PASSPORTS
                WHERE COMPONENT_ID = COMP_ID;

               SELECT REPLACE (OTM_S, ',', '.')
                 INTO OTM_S
                 FROM DUAL;

               OTM := TO_NUMBER (OTM_S);
               /* Рассчитываем значение смещения от вертикали */
               DISPLACEMENT := SM;
            END IF;

            IF (GRUPPA_OTVESA = 'ПО')
            THEN /* Находим ИД ОО, необходимого для расчета */
               OO_P_ID := NULL;
               MAX_OTM := 0;

               FOR INC IN (SELECT POINT_ID
                             FROM ROUTE_POINTS
                            WHERE (ROUTE_ID = 4660)
                               OR (ROUTE_ID = 4661))
               LOOP /* Запоминаем номер вертикали точки */
                  SELECT COMPONENT_ID
                    INTO COMP_ID
                    FROM COMPONENTS
                   WHERE (PARAM_ID = 16141)
                     AND (CONVERTER_ID = INC.POINT_ID);

                  SELECT VALUE
                    INTO NUM_VER2
                    FROM CONVERTER_PASSPORTS
                   WHERE COMPONENT_ID = COMP_ID;

                  /* Запоминаем группу отвеса */
                  SELECT COMPONENT_ID
                    INTO COMP_ID
                    FROM COMPONENTS
                   WHERE (PARAM_ID = 16140)
                     AND (CONVERTER_ID = INC.POINT_ID);

                  SELECT VALUE
                    INTO GRUPPA_OTVESA2
                    FROM CONVERTER_PASSPORTS
                   WHERE COMPONENT_ID = COMP_ID;

                  IF     (   (GRUPPA_OTVESA2 = 'ОО глубинный')
                          OR (GRUPPA_OTVESA2 = 'ОО контактный'))
                     AND (NUM_VER2 = NUM_VER)
                  THEN /* Запоминаем отм. устан. измерит. столика */
                     SELECT COMPONENT_ID
                       INTO COMP_ID
                       FROM COMPONENTS
                      WHERE (PARAM_ID = 16145)
                        AND (CONVERTER_ID = INC.POINT_ID);

                     SELECT VALUE
                       INTO OTM2_S
                       FROM CONVERTER_PASSPORTS
                      WHERE COMPONENT_ID = COMP_ID;

                     SELECT REPLACE (OTM2_S, ',', '.')
                       INTO OTM2_S
                       FROM DUAL;

                     OTM2 := TO_NUMBER (OTM2_S);

                     IF (OTM2 > MAX_OTM)
                     THEN
                        MAX_OTM := OTM2;
                        OO_P_ID := INC.POINT_ID;
                     END IF;
                  END IF;
               END LOOP;

               /* Рассчитываем значение смещения от вертикали */
               OTM := MAX_OTM;

               /* Находим смещение с начала наблюдений */
               FOR INCC IN (SELECT VALUE
                              FROM JOURNAL_OBSERVATIONS
                             WHERE (POINT_ID = OO_P_ID)
                               AND (PARAM_ID = APARAM_ID)
                               AND (CYCLE_ID = ACYCLE_ID))
               LOOP
                  SM2 := INCC.VALUE;
               END LOOP;

               DISPLACEMENT := SM + SM2;
            END IF;

            IF DISPLACEMENT IS NOT NULL
            THEN
               I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                      CONFIRM_DISPLACEMENT_VERTICAL.JOURNAL_FIELD_ID,
                                      NULL,
                                      AMEASURE_TYPE_ID,
                                      13690,
                                      ADATE_OBSERVATION,
                                      ACYCLE_ID,
                                      APOINT_ID,
                                      APARAM_ID + 4, /* Смещение от вертикали */
                                      DISPLACEMENT,
                                      AWHO_CONFIRM,
                                      ADATE_CONFIRM,
                                      ALGORITHM_ID,
                                      AGROUP_ID,
                                      APRIORITY
                                     );
            END IF;
         END IF;
      /* Обработка */
      END IF;
   END IF;
END;

--

/* Фиксация */

COMMIT
