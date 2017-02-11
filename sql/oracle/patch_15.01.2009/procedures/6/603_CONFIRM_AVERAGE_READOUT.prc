/* Создание процедуры расчета среднего отсчета между ходом прямо и обратно */

CREATE OR REPLACE PROCEDURE CONFIRM_AVERAGE_READOUT (
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
   DISPLACEMENT FLOAT;
   F_OT FLOAT;
   L_OT FLOAT;
   M_OT FLOAT;
   M_OT_INT INTEGER;
   M_OT_STR VARCHAR2 (100);
   LAST_SYMB VARCHAR2 (1);
   ST VARCHAR2 (100);
   NAP_XODA INTEGER;
BEGIN
   SELECT MEASURE_TYPE_ID,
          CYCLE_ID,
          WHO_CONFIRM,
          DATE_CONFIRM,
          GROUP_ID,
          PRIORITY,
          POINT_ID,
          DATE_OBSERVATION,
          PARAM_ID
     INTO AMEASURE_TYPE_ID,
          ACYCLE_ID,
          AWHO_CONFIRM,
          ADATE_CONFIRM,
          AGROUP_ID,
          APRIORITY,
          APOINT_ID,
          ADATE_OBSERVATION,
          APARAM_ID
     FROM JOURNAL_FIELDS
    WHERE JOURNAL_FIELD_ID = CONFIRM_AVERAGE_READOUT.JOURNAL_FIELD_ID;

   IF APARAM_ID = 15122 /* Отсчет (ход обратно) */
   THEN
      DELETE FROM JOURNAL_OBSERVATIONS
            WHERE JOURNAL_FIELD_ID = CONFIRM_AVERAGE_READOUT.JOURNAL_FIELD_ID
              AND ALGORITHM_ID = CONFIRM_AVERAGE_READOUT.ALGORITHM_ID
              AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
              AND CYCLE_ID = ACYCLE_ID
              AND DATE_OBSERVATION = ADATE_OBSERVATION
              AND GROUP_ID = AGROUP_ID
              AND POINT_ID = APOINT_ID
              AND PARAM_ID = 17200;

      /* Отсчет средний */
      COMMIT;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN /* Обработка */
         SELECT VALUE
           INTO L_OT
           FROM JOURNAL_OBSERVATIONS
          WHERE JOURNAL_FIELD_ID = CONFIRM_AVERAGE_READOUT.JOURNAL_FIELD_ID
            AND PARAM_ID = 15122;

         SELECT VALUE
           INTO F_OT
           FROM JOURNAL_OBSERVATIONS
          WHERE CYCLE_ID = ACYCLE_ID
            AND POINT_ID = APOINT_ID
            AND PARAM_ID = 15121;

         /* Находим значение среднего отсчета */
         M_OT := (F_OT + L_OT) / 2;
         M_OT := M_OT * 100;
         M_OT_INT := M_OT - MOD (M_OT, 1);
         M_OT_STR := TO_NCHAR (M_OT_INT);

         SELECT SUBSTR (M_OT_STR, LENGTH (M_OT_STR), 1)
           INTO LAST_SYMB
           FROM DUAL;

         IF LAST_SYMB = '0'
         THEN
            M_OT := M_OT_INT / 100;
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
            M_OT := M_OT_INT / 100;
         END IF;

         IF LAST_SYMB = '5'
         THEN
            M_OT := M_OT_INT / 100;
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
            M_OT := M_OT_INT / 100;
         END IF;

         I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                JOURNAL_FIELD_ID,
                                NULL,
                                AMEASURE_TYPE_ID,
                                3670,
                                ADATE_OBSERVATION,
                                ACYCLE_ID,
                                APOINT_ID,
                                17200, /* Средний отсчет */
                                M_OT,
                                AWHO_CONFIRM,
                                ADATE_CONFIRM,
                                ALGORITHM_ID,
                                AGROUP_ID,
                                APRIORITY
                               );
      END IF;
   /* Обработка */
   END IF;
END;

--

/* Фиксация */

COMMIT
