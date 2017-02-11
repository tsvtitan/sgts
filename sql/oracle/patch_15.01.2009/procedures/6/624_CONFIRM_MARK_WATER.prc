/* Создание процедуры расчета отметки уровня воды в пьезометре */

CREATE OR REPLACE PROCEDURE CONFIRM_MARK_WATER (
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
   AINSTRUMENT_TYPE_ID INTEGER;
   AMEASURE_UNIT_ID INTEGER;
   K FLOAT;
   M_CENTER FLOAT;
   MARK_WATER FLOAT;
   FLAG INTEGER;
   MARK_MOUNTH FLOAT;
   A FLOAT;
   B FLOAT;
   C FLOAT;
   MARK_SENSOR FLOAT;
   ERROR VARCHAR2 (500);
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
    WHERE JOURNAL_FIELD_ID = CONFIRM_MARK_WATER.JOURNAL_FIELD_ID;

   IF (APARAM_ID = 2920) /* Отсчет пьезометра */
   THEN
      DELETE FROM JOURNAL_OBSERVATIONS
            WHERE JOURNAL_FIELD_ID = CONFIRM_MARK_WATER.JOURNAL_FIELD_ID
              AND ALGORITHM_ID = CONFIRM_MARK_WATER.ALGORITHM_ID
              AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
              AND CYCLE_ID = ACYCLE_ID
              AND DATE_OBSERVATION = ADATE_OBSERVATION
              AND GROUP_ID = AGROUP_ID
              AND POINT_ID = APOINT_ID
              AND PARAM_ID = 2960;

      /* Отметка уровня воды */
      COMMIT;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN
         FLAG := 0;

         SELECT INSTRUMENT_TYPE_ID
           INTO AINSTRUMENT_TYPE_ID
           FROM INSTRUMENTS
          WHERE INSTRUMENT_ID = AINSTRUMENT_ID;

         CASE
            WHEN AINSTRUMENT_TYPE_ID = 2520 /* Уровнемер */
            THEN
               FLAG := 1;
               MARK_MOUNTH := 0;

               FOR INC IN (SELECT   CP.VALUE,
                                    CP.DATE_BEGIN,
                                    CP.DATE_END
                               FROM CONVERTER_PASSPORTS CP,
                                    COMPONENTS C,
                                    POINTS P
                              WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                AND C.CONVERTER_ID = P.POINT_ID
                                AND P.POINT_ID = APOINT_ID
                                AND C.PARAM_ID = 2944 /* Отметка верха трубы */
                           ORDER BY CP.DATE_BEGIN)
               LOOP
                  MARK_MOUNTH := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
                  EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                       AND (ADATE_OBSERVATION <= INC.DATE_END);
               END LOOP;

               MARK_WATER := MARK_MOUNTH - AVALUE;
            WHEN AINSTRUMENT_TYPE_ID IN (1002, 2500, 2502, 2522, 2501) /* Манометр */
            THEN
               FLAG := 1;
               K := 1;

               CASE AMEASURE_UNIT_ID
                  WHEN 2542 /* кг/см2 */
                  THEN
                     K := 10;
                  WHEN 2610 /* МПа */
                  THEN
                     K := 102;
               END CASE;

               M_CENTER := 0;
               DBMS_OUTPUT.PUT_LINE (JOURNAL_FIELD_ID);
               DBMS_OUTPUT.PUT_LINE (APOINT_ID);

               FOR INC IN (SELECT   CP.VALUE,
                                    CP.DATE_BEGIN,
                                    CP.DATE_END
                               FROM CONVERTER_PASSPORTS CP,
                                    COMPONENTS C,
                                    POINTS P
                              WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                AND C.CONVERTER_ID = P.POINT_ID
                                AND P.POINT_ID = APOINT_ID
                                AND C.PARAM_ID = 2945 /* Отметка центра манометра */
                           ORDER BY CP.DATE_BEGIN)
               LOOP
                  DBMS_OUTPUT.PUT_LINE ('V=' || INC.VALUE);
                  M_CENTER := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
                  EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                       AND (ADATE_OBSERVATION <= INC.DATE_END);
               END LOOP;

               MARK_WATER := M_CENTER + AVALUE * K;
            WHEN AINSTRUMENT_TYPE_ID = 2521 /* Датчик */
            THEN
               FLAG := 1;
               MARK_SENSOR := 0;

               FOR INC IN (SELECT   CP.VALUE,
                                    CP.DATE_BEGIN,
                                    CP.DATE_END
                               FROM CONVERTER_PASSPORTS CP,
                                    COMPONENTS C,
                                    POINTS P
                              WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                AND C.CONVERTER_ID = P.POINT_ID
                                AND P.POINT_ID = APOINT_ID
                                AND C.PARAM_ID = 2946 /* Отметка датчика */
                           ORDER BY CP.DATE_BEGIN)
               LOOP
                  MARK_SENSOR := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
                  EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                       AND (ADATE_OBSERVATION <= INC.DATE_END);
               END LOOP;

               A := 0;

               FOR INC IN (SELECT   CP.VALUE,
                                    CP.DATE_BEGIN,
                                    CP.DATE_END
                               FROM CONVERTER_PASSPORTS CP,
                                    COMPONENTS C,
                                    POINTS P
                              WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                AND C.CONVERTER_ID = P.POINT_ID
                                AND P.POINT_ID = APOINT_ID
                                AND C.PARAM_ID = 2949 /* Коэффициент A */
                           ORDER BY CP.DATE_BEGIN)
               LOOP
                  A := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
                  EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                       AND (ADATE_OBSERVATION <= INC.DATE_END);
               END LOOP;

               B := 0;

               FOR INC IN (SELECT   CP.VALUE,
                                    CP.DATE_BEGIN,
                                    CP.DATE_END
                               FROM CONVERTER_PASSPORTS CP,
                                    COMPONENTS C,
                                    POINTS P
                              WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                AND C.CONVERTER_ID = P.POINT_ID
                                AND P.POINT_ID = APOINT_ID
                                AND C.PARAM_ID = 2950 /* Коэффициент B */
                           ORDER BY CP.DATE_BEGIN)
               LOOP
                  B := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
                  EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                       AND (ADATE_OBSERVATION <= INC.DATE_END);
               END LOOP;

               C := 0;

               FOR INC IN (SELECT   CP.VALUE,
                                    CP.DATE_BEGIN,
                                    CP.DATE_END
                               FROM CONVERTER_PASSPORTS CP,
                                    COMPONENTS C,
                                    POINTS P
                              WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                AND C.CONVERTER_ID = P.POINT_ID
                                AND P.POINT_ID = APOINT_ID
                                AND C.PARAM_ID = 2951 /* Коэффициент C */
                           ORDER BY CP.DATE_BEGIN)
               LOOP
                  C := TO_NUMBER (REPLACE (INC.VALUE, ',', '.'), 'FM99999.9999');
                  EXIT WHEN (ADATE_OBSERVATION >= INC.DATE_BEGIN)
                       AND (ADATE_OBSERVATION <= INC.DATE_END);
               END LOOP;

               MARK_WATER := MARK_SENSOR + A * POWER (AVALUE, 2) + B * AVALUE + C;
         END CASE;

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
                                   2960, /* Отметка уровня воды */
                                   MARK_WATER,
                                   AWHO_CONFIRM,
                                   ADATE_CONFIRM,
                                   ALGORITHM_ID,
                                   AGROUP_ID,
                                   APRIORITY
                                  );
         END IF;
      END IF;
   END IF;
EXCEPTION
   WHEN CASE_NOT_FOUND
   THEN
      ERROR := 'Ошибка расчета отметки уровня воды в пьезометре. Не верный тип прибора.';
      RAISE_APPLICATION_ERROR (-20100, ERROR);
END;

--

/* Фиксация */

COMMIT
