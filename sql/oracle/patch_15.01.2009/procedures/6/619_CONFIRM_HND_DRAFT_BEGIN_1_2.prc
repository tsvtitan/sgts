/* Создание процедуры утверждения осадки для продольных гидронивелиров */

CREATE OR REPLACE PROCEDURE CONFIRM_HND_DRAFT_BEGIN_1_2 (
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
   ACYCLE_NUM INTEGER;
   AROUTE_ID INTEGER;
   LAST_POINT_ID INTEGER;
   F1_POINT_ID INTEGER;
   F2_POINT_ID INTEGER;
   F3_POINT_ID INTEGER;
   F4_POINT_ID INTEGER;
   R1_POINT_ID INTEGER;
   R2_POINT_ID INTEGER;
   R3_POINT_ID INTEGER;
   MIN_DATE DATE;
   MIN_CYCLE_ID INTEGER;
   MAX_DATE DATE;
   MAX_CYCLE_ID INTEGER;
   R_CYCLE_ID INTEGER;
   CURSOR_STRI VARCHAR2 (4000);
   CUR SYS_REFCURSOR;
   C_JOURNAL_FIELD_ID INTEGER;
   C_GROUP_ID VARCHAR2 (32);
   C_DATE_OBSERVATION DATE;
   C_POINT_ID INTEGER;
   POINT_NAME INTEGER;
   CONVERTER_NAME VARCHAR2 (100);
   EXCESS FLOAT;
   RELATIVE FLOAT;
   FIRST_MARK FLOAT;
   SUM_EXCESS FLOAT;
   REC_NUM INTEGER;
   FIRST_MARK_NEXT FLOAT;
   CORRECTION FLOAT;
   DELTA FLOAT;
   RESULT_MARK FLOAT;
   CROSS_MARK FLOAT;
   SHIFT_BEGIN FLOAT;
   SHIFT FLOAT;
BEGIN
   SELECT JO.MEASURE_TYPE_ID,
          JO.CYCLE_ID,
          JO.WHO_CONFIRM,
          JO.DATE_CONFIRM,
          JO.GROUP_ID,
          JO.PRIORITY,
          JO.POINT_ID,
          JO.DATE_OBSERVATION,
          JO.PARAM_ID,
          C.CYCLE_NUM
     INTO AMEASURE_TYPE_ID,
          ACYCLE_ID,
          AWHO_CONFIRM,
          ADATE_CONFIRM,
          AGROUP_ID,
          APRIORITY,
          APOINT_ID,
          ADATE_OBSERVATION,
          APARAM_ID,
          ACYCLE_NUM
     FROM JOURNAL_FIELDS JO,
          CYCLES C
    WHERE JO.JOURNAL_FIELD_ID = CONFIRM_HND_DRAFT_BEGIN_1_2.JOURNAL_FIELD_ID
      AND JO.CYCLE_ID = C.CYCLE_ID;

   IF (APARAM_ID = 50008)
   THEN   /* Отсчет (ход обратно) */
      AROUTE_ID := NULL;

      FOR INC IN (SELECT ROUTE_ID
                    FROM ROUTE_POINTS
                   WHERE POINT_ID = APOINT_ID)
      LOOP
         AROUTE_ID := INC.ROUTE_ID;
         EXIT WHEN AROUTE_ID IS NOT NULL;
      END LOOP;

      IF (AROUTE_ID IS NOT NULL)
      THEN
         LAST_POINT_ID := NULL;

         FOR INC IN (SELECT   POINT_ID
                         FROM ROUTE_POINTS
                        WHERE ROUTE_ID = AROUTE_ID
                     ORDER BY PRIORITY DESC)
         LOOP
            LAST_POINT_ID := INC.POINT_ID;
            EXIT WHEN LAST_POINT_ID IS NOT NULL;
         END LOOP;

         IF (LAST_POINT_ID = APOINT_ID)
         THEN
            DELETE FROM JOURNAL_OBSERVATIONS
                  WHERE ALGORITHM_ID = CONFIRM_HND_DRAFT_BEGIN_1_2.ALGORITHM_ID
                    AND MEASURE_TYPE_ID = AMEASURE_TYPE_ID
                    AND CYCLE_ID = ACYCLE_ID
                    AND POINT_ID IN (SELECT POINT_ID
                                       FROM ROUTE_POINTS
                                      WHERE ROUTE_ID = AROUTE_ID)
                    AND PARAM_ID IN (50024, 50064);   /* Осадка с нач. набл. и Отметка марки */

            COMMIT;

            IF (AWHO_CONFIRM IS NOT NULL)
            THEN
               IF (AROUTE_ID = 50028)
               THEN   /* Галерея 1 */
                  F1_POINT_ID := 150116;   /* Точка 1 */
                  F2_POINT_ID := 150190;   /* Точка 75 */
                  F3_POINT_ID := 150191;   /* Точка 76 */
                  F4_POINT_ID := 150226;   /* Точка 111 */
                  R1_POINT_ID := 150507;   /* Точка 1 из нивелировок марок */
                  R2_POINT_ID := 150508;   /* Точка 76 из нивелировок марок */
                  R3_POINT_ID := 150509;   /* Точка 1 из нивелировок марок */
               ELSE
                  F1_POINT_ID := 150229;   /* Точка 1 */
                  F2_POINT_ID := 150306;   /* Точка 78 */
                  F3_POINT_ID := 150307;   /* Точка 79 */
                  F4_POINT_ID := 150344;   /* Точка 116 */
                  R1_POINT_ID := 150510;   /* Точка 1 из нивелировок марок */
                  R2_POINT_ID := 150511;   /* Точка 79 из нивелировок марок */
                  R3_POINT_ID := 150512;   /* Точка 117 из нивелировок марок */
               END IF;

               MIN_DATE := NULL;
               MIN_CYCLE_ID := NULL;

               FOR INC IN (SELECT   JO.CYCLE_ID,
                                    JO.DATE_OBSERVATION
                               FROM JOURNAL_OBSERVATIONS JO,
                                    CYCLES C
                              WHERE JO.CYCLE_ID = C.CYCLE_ID
                                AND JO.MEASURE_TYPE_ID = 49985   /* Нивелирование марок гидронивелира */
                                AND JO.POINT_ID IN (R1_POINT_ID, R2_POINT_ID, R3_POINT_ID)
                                AND C.CYCLE_NUM <= ACYCLE_NUM
                           ORDER BY DATE_OBSERVATION DESC)
               LOOP
                  MIN_CYCLE_ID := INC.CYCLE_ID;
                  MIN_DATE := INC.DATE_OBSERVATION;
                  EXIT WHEN MIN_CYCLE_ID IS NOT NULL;
               END LOOP;

               MAX_DATE := NULL;
               MAX_CYCLE_ID := NULL;

               FOR INC IN (SELECT   JO.CYCLE_ID,
                                    JO.DATE_OBSERVATION
                               FROM JOURNAL_OBSERVATIONS JO,
                                    CYCLES C
                              WHERE JO.CYCLE_ID = C.CYCLE_ID
                                AND JO.MEASURE_TYPE_ID = 49985   /* Нивелирование марок гидронивелира */
                                AND JO.POINT_ID IN (R1_POINT_ID, R2_POINT_ID, R3_POINT_ID)
                                AND C.CYCLE_NUM >= ACYCLE_NUM
                           ORDER BY DATE_OBSERVATION ASC)
               LOOP
                  MAX_CYCLE_ID := INC.CYCLE_ID;
                  MAX_DATE := INC.DATE_OBSERVATION;
                  EXIT WHEN MAX_CYCLE_ID IS NOT NULL;
               END LOOP;

               R_CYCLE_ID := MAX_CYCLE_ID;

               IF (MAX_DATE - ADATE_OBSERVATION) > (ADATE_OBSERVATION - MIN_DATE)
               THEN
                  R_CYCLE_ID := MIN_CYCLE_ID;
               END IF;

               CURSOR_STRI :=
                     'SELECT JOURNAL_FIELD_ID, GROUP_ID, DATE_OBSERVATION, POINT_ID, '
                  || 'POINT_NAME, CONVERTER_NAME, EXCESS, RELATIVE, '
                  || 'FIRST_MARK2 - FIRST_VALUE(RELATIVE) OVER (PARTITION BY R_POINT_ID ORDER BY POINT_NAME) + RELATIVE AS FIRST_MARK, '
                  || 'SUM(EXCESS2) OVER (PARTITION BY DELIMETER2) AS SUM_EXCESS, '
                  || 'REC_NUM2 AS REC_NUM, '
                  || 'LAST_VALUE(FIRST_MARK2) OVER (ORDER BY DELIMETER2 RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING) AS FIRST_MARK_NEXT '
                  || 'FROM (SELECT T.*, '
                  || 'SUM(T.EXCESS) OVER (ORDER BY T.POINT_NAME) AS RELATIVE, '
                  || 'JO.VALUE AS FIRST_MARK2, '
                  || 'CASE DELIMETER WHEN 0 THEN 0 '
                  || 'ELSE COUNT(*) OVER (PARTITION BY DELIMETER ORDER BY T.POINT_NAME DESC) '
                  || 'END AS REC_NUM2, '
                  || 'CASE DELIMETER WHEN 0 THEN 0 '
                  || 'ELSE EXCESS '
                  || 'END AS EXCESS2 '
                  || 'FROM (SELECT T.*, '
                  || 'CASE '
                  || 'WHEN T.POINT_ID=FIRST_VALUE(T.POINT_ID) OVER (ORDER BY PRIORITY) THEN 0.0 '
                  || 'WHEN T2.CONVERTER_ID IS NOT NULL THEN T2.EXCESS/1000 '
                  || 'ELSE (FIRST_VALUE(T.VALUE_AVERAGE) OVER (ORDER BY T.POINT_NAME ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - T.VALUE_AVERAGE) /1000 '
                  || 'END AS EXCESS, '
                  || 'CASE '
                  || 'WHEN T.POINT_ID>=:F1_POINT_ID AND T.POINT_ID<=:F2_POINT_ID THEN :R1_POINT_ID '
                  || 'WHEN T.POINT_ID>=:F3_POINT_ID AND T.POINT_ID<=:F4_POINT_ID THEN :R2_POINT_ID '
                  || 'ELSE :R3_POINT_ID '
                  || 'END AS R_POINT_ID, '
                  || 'CASE '
                  || 'WHEN T.POINT_ID>=(:F1_POINT_ID+1) AND T.POINT_ID<=:F2_POINT_ID THEN 1 '
                  || 'WHEN T.POINT_ID>=(:F3_POINT_ID+1) AND T.POINT_ID<=:F4_POINT_ID THEN 2 '
                  || 'ELSE 0 '
                  || 'END AS DELIMETER, '
                  || 'CASE '
                  || 'WHEN T.POINT_ID>=:F1_POINT_ID AND T.POINT_ID<=:F2_POINT_ID THEN 1 '
                  || 'WHEN T.POINT_ID>=:F3_POINT_ID AND T.POINT_ID<=:F4_POINT_ID THEN 2 '
                  || 'ELSE 3 '
                  || 'END AS DELIMETER2, '
                  || 'ROWNUM AS REC_NUM '
                  || 'FROM (SELECT JO.JOURNAL_FIELD_ID, JO.GROUP_ID, '
                  || 'JO.DATE_OBSERVATION, JO.CYCLE_ID, C.CYCLE_NUM, P.POINT_ID, P.NAME AS POINT_NAME, RP.PRIORITY, '
                  || 'CV.NAME AS CONVERTER_NAME, DECODE(CP1.VALUE,'''',NULL,TO_NUMBER(CP1.VALUE)) AS HDN_NUM, '
                  || 'TO_NUMBER(CP2.VALUE) AS HDN_PART, '
                  || 'MIN(DECODE(JO.PARAM_ID,50020,JO.VALUE,NULL)) AS VALUE_AVERAGE /* Отсчет средний */ '
                  || 'FROM JOURNAL_OBSERVATIONS JO, CYCLES C, POINTS P, OBJECTS O, GROUP_OBJECTS GO, '
                  || 'CONVERTERS CV, ROUTE_POINTS RP, ROUTES R, '
                  || 'COMPONENTS CM1, CONVERTER_PASSPORTS CP1, '
                  || 'COMPONENTS CM2, CONVERTER_PASSPORTS CP2 '
                  || 'WHERE JO.CYCLE_ID=C.CYCLE_ID '
                  || 'AND JO.POINT_ID=P.POINT_ID '
                  || 'AND O.OBJECT_ID=P.OBJECT_ID '
                  || 'AND CV.CONVERTER_ID=P.POINT_ID '
                  || 'AND CM1.CONVERTER_ID=CV.CONVERTER_ID '
                  || 'AND CP1.COMPONENT_ID=CM1.COMPONENT_ID '
                  || 'AND CM1.PARAM_ID = 50002 /* Номер гидронивелира */ '
                  || 'AND CM2.CONVERTER_ID=CV.CONVERTER_ID '
                  || 'AND CP2.COMPONENT_ID=CM2.COMPONENT_ID '
                  || 'AND CM2.PARAM_ID = 50003 /* Номер звена в нивелире */ '
                  || 'AND RP.POINT_ID=JO.POINT_ID '
                  || 'AND R.ROUTE_ID=RP.ROUTE_ID '
                  || 'AND RP.ROUTE_ID=:ROUTE_ID '
                  || 'AND JO.MEASURE_TYPE_ID=:MEASURE_TYPE_ID '
                  || 'AND JO.PARAM_ID=50020 /* Отсчет средний */ '
                  || 'AND JO.CYCLE_ID=:CYCLE_ID '
                  || 'GROUP BY JO.JOURNAL_FIELD_ID, '
                  || 'JO.DATE_OBSERVATION, JO.MEASURE_TYPE_ID, JO.CYCLE_ID, C.CYCLE_NUM, JO.POINT_ID, '
                  || 'P.POINT_ID, P.NAME, CV.CONVERTER_ID, CV.NAME, JO.GROUP_ID, R.NAME, O.SHORT_NAME, '
                  || 'CP1.VALUE, CP2.VALUE, RP.PRIORITY '
                  || 'ORDER BY JO.DATE_OBSERVATION, JO.GROUP_ID, RP.PRIORITY) T, '
                  || '(SELECT C.CONVERTER_ID, CP.DATE_BEGIN, CP.DATE_END, '
                  || 'TO_NUMBER(REPLACE(CP.VALUE,'','',''.''),''FM99999.9999'') AS EXCESS '
                  || 'FROM CONVERTER_PASSPORTS CP, COMPONENTS C '
                  || 'WHERE CP.COMPONENT_ID=C.COMPONENT_ID '
                  || 'AND C.PARAM_ID=50006 /* Превыш. м/у зв. гидронив. */ '
                  || 'ORDER BY CP.DATE_BEGIN DESC) T2 '
                  || 'WHERE (T.POINT_ID=T2.CONVERTER_ID (+) '
                  || 'AND ((T2.DATE_BEGIN IS NULL AND T2.DATE_END IS NULL) OR '
                  || '(T.DATE_OBSERVATION>=T2.DATE_BEGIN AND T2.DATE_END IS NULL) OR '
                  || '(T.DATE_OBSERVATION>=T2.DATE_BEGIN AND T.DATE_OBSERVATION<=T2.DATE_END))) '
                  || 'ORDER BY T.DATE_OBSERVATION, T.CYCLE_NUM, T.POINT_NAME) T, '
                  || 'JOURNAL_OBSERVATIONS JO '
                  || 'WHERE JO.CYCLE_ID=:R_CYCLE_ID '
                  || 'AND T.R_POINT_ID=JO.POINT_ID ) T '
                  || 'ORDER BY T.DATE_OBSERVATION, T.CYCLE_NUM, T.POINT_NAME ';

               OPEN CUR FOR CURSOR_STRI
               USING F1_POINT_ID,
                     F2_POINT_ID,
                     R1_POINT_ID,
                     F3_POINT_ID,
                     F4_POINT_ID,
                     R2_POINT_ID,
                     R3_POINT_ID,
                     F1_POINT_ID,
                     F2_POINT_ID,
                     F3_POINT_ID,
                     F4_POINT_ID,
                     F1_POINT_ID,
                     F2_POINT_ID,
                     F3_POINT_ID,
                     F4_POINT_ID,
                     AROUTE_ID,
                     AMEASURE_TYPE_ID,
                     ACYCLE_ID,
                     R_CYCLE_ID;

               LOOP
                  FETCH CUR
                   INTO C_JOURNAL_FIELD_ID,
                        C_GROUP_ID,
                        C_DATE_OBSERVATION,
                        C_POINT_ID,
                        POINT_NAME,
                        CONVERTER_NAME,
                        EXCESS,
                        RELATIVE,
                        FIRST_MARK,
                        SUM_EXCESS,
                        REC_NUM,
                        FIRST_MARK_NEXT;

                  EXIT WHEN CUR%NOTFOUND;

                  IF (REC_NUM = 0)
                  THEN
                     CORRECTION := 0;
                     DELTA := SUM_EXCESS - (FIRST_MARK_NEXT - FIRST_MARK);
                     RESULT_MARK := FIRST_MARK;
                  ELSE
                     CORRECTION := ROUND (DELTA / REC_NUM, 5);
                     DELTA := DELTA - CORRECTION;
                     RESULT_MARK := FIRST_MARK + CORRECTION;
                  END IF;

                  CROSS_MARK := 0;

                  FOR INC2 IN (SELECT   CP.VALUE,
                                        CP.DATE_BEGIN,
                                        CP.DATE_END
                                   FROM CONVERTER_PASSPORTS CP,
                                        COMPONENTS C
                                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                    AND C.CONVERTER_ID = C_POINT_ID
                                    AND C.PARAM_ID = 50062   /* Отметка ИТ на дату перехода */
                               ORDER BY CP.DATE_BEGIN)
                  LOOP
                     CROSS_MARK := TO_NUMBER (REPLACE (INC2.VALUE, ',', '.'), 'FM999999.999999');
                     EXIT WHEN (C_DATE_OBSERVATION >= INC2.DATE_BEGIN)
                          AND (C_DATE_OBSERVATION <= INC2.DATE_END);
                  END LOOP;

                  SHIFT_BEGIN := 0;

                  FOR INC2 IN (SELECT   CP.VALUE,
                                        CP.DATE_BEGIN,
                                        CP.DATE_END
                                   FROM CONVERTER_PASSPORTS CP,
                                        COMPONENTS C
                                  WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                                    AND C.CONVERTER_ID = C_POINT_ID
                                    AND C.PARAM_ID = 50060   /* Смещ. с нач. набл. на дату перехода */
                               ORDER BY CP.DATE_BEGIN)
                  LOOP
                     SHIFT_BEGIN := TO_NUMBER (REPLACE (INC2.VALUE, ',', '.'), 'FM999999.999999');
                     EXIT WHEN (C_DATE_OBSERVATION >= INC2.DATE_BEGIN)
                          AND (C_DATE_OBSERVATION <= INC2.DATE_END);
                  END LOOP;

                  SHIFT := 0;

                  IF     (RESULT_MARK IS NOT NULL)
                     AND (CROSS_MARK IS NOT NULL)
                     AND (SHIFT_BEGIN IS NOT NULL)
                  THEN
                     SHIFT := (RESULT_MARK - CROSS_MARK + (SHIFT_BEGIN / 1000)) * 1000;
                  END IF;

                  IF (RESULT_MARK IS NOT NULL)
                  THEN
                     I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                            C_JOURNAL_FIELD_ID,
                                            NULL,
                                            AMEASURE_TYPE_ID,
                                            2520,   /* м */
                                            C_DATE_OBSERVATION,
                                            ACYCLE_ID,
                                            C_POINT_ID,
                                            50064,   /* Отметка марки */
                                            RESULT_MARK,
                                            AWHO_CONFIRM,
                                            ADATE_CONFIRM,
                                            ALGORITHM_ID,
                                            C_GROUP_ID,
                                            APRIORITY + 2
                                           );
                  END IF;

                  IF (SHIFT IS NOT NULL)
                  THEN
                     I_JOURNAL_OBSERVATION (GET_JOURNAL_OBSERVATION_ID,
                                            C_JOURNAL_FIELD_ID,
                                            NULL,
                                            AMEASURE_TYPE_ID,
                                            2523,   /* мм */
                                            C_DATE_OBSERVATION,
                                            ACYCLE_ID,
                                            C_POINT_ID,
                                            50024,   /* Осадка с нач. набл. */
                                            SHIFT,
                                            AWHO_CONFIRM,
                                            ADATE_CONFIRM,
                                            ALGORITHM_ID,
                                            C_GROUP_ID,
                                            APRIORITY + 3
                                           );
                  END IF;
               END LOOP;

               CLOSE CUR;
            END IF;
         END IF;
      END IF;
   END IF;
END;

--

/* Фиксация */

COMMIT
