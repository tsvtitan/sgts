/* Создание процедуры утверждения CONFIRM_CURRENT_DISPLACEMENT_N */

CREATE OR REPLACE PROCEDURE CONFIRM_CURRENT_DISPLACEMENT_N (
   JOURNAL_FIELD_ID   IN   INTEGER,
   ALGORITHM_ID       IN   INTEGER
)
AS
   AMEASURE_TYPE_ID       INTEGER;
   ACYCLE_ID              INTEGER;
   AWHO_CONFIRM           INTEGER;
   ADATE_CONFIRM          DATE;
   AGROUP_ID              VARCHAR2 (32);
   APRIORITY              INTEGER;
   APOINT_ID              INTEGER;
   ADATE_OBSERVATION      DATE;
   APARAM_ID              INTEGER;
   AVALUE                 FLOAT;
   CURRENT_DISPLACEMENT   FLOAT;
   FLAG                   BOOLEAN;
   V                      FLOAT;
BEGIN
   SELECT MEASURE_TYPE_ID, CYCLE_ID, WHO_CONFIRM, DATE_CONFIRM,
          GROUP_ID, PRIORITY, POINT_ID, DATE_OBSERVATION, PARAM_ID,
          VALUE
     INTO AMEASURE_TYPE_ID, ACYCLE_ID, AWHO_CONFIRM, ADATE_CONFIRM,
          AGROUP_ID, APRIORITY, APOINT_ID, ADATE_OBSERVATION, APARAM_ID,
          AVALUE
     FROM JOURNAL_FIELDS
    WHERE JOURNAL_FIELD_ID = CONFIRM_CURRENT_DISPLACEMENT_N.JOURNAL_FIELD_ID;

   IF (APARAM_ID = 50008)  /* Отсчет ход обратно */
   THEN
      DELETE FROM JOURNAL_OBSERVATIONS
            WHERE JOURNAL_FIELD_ID =
                              CONFIRM_CURRENT_DISPLACEMENT_N.JOURNAL_FIELD_ID
              AND ALGORITHM_ID = CONFIRM_CURRENT_DISPLACEMENT_N.ALGORITHM_ID
              AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
              AND CYCLE_ID = ACYCLE_ID
              AND DATE_OBSERVATION = ADATE_OBSERVATION
              AND GROUP_ID = AGROUP_ID
              AND POINT_ID = APOINT_ID
              AND PARAM_ID = 50063; /* Текущее смещение */

      COMMIT;

      IF (AWHO_CONFIRM IS NOT NULL)
      THEN
         FLAG := FALSE;
		 CURRENT_DISPLACEMENT := 0;
		 V:=0;

         FOR INC IN (SELECT VALUE
                         FROM JOURNAL_OBSERVATIONS
                        WHERE (PARAM_ID = 50024) /* Осадка с начала наблюдения */ 
						  AND (POINT_ID = APOINT_ID)
						  AND DATE_OBSERVATION<=ADATE_OBSERVATION
                     ORDER BY DATE_OBSERVATION DESC)
         LOOP
           IF (FLAG = TRUE) THEN
             CURRENT_DISPLACEMENT := INC.VALUE;
  	         EXIT;
  		   ELSE
		     V := INC.VALUE;
			 FLAG := TRUE;	   
           END IF;
         END LOOP;

         CURRENT_DISPLACEMENT := V - CURRENT_DISPLACEMENT;

         IF (CURRENT_DISPLACEMENT IS NOT NULL)
         THEN
            I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                   JOURNAL_FIELD_ID,
                                   NULL,
                                   AMEASURE_TYPE_ID,
                                   2523,
                                   ADATE_OBSERVATION,
                                   ACYCLE_ID,
                                   APOINT_ID,
                                   50063,
                                   CURRENT_DISPLACEMENT,
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
