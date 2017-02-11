/* Создание просмотра интенсивности выноса кальция химанализа */

CREATE OR REPLACE VIEW S_HMZ_INTENSITY
AS 
SELECT   JO.CYCLE_ID,
         JO.DATE_OBSERVATION,
         JO.MEASURE_TYPE_ID,
         JO.EXPENSE,
         JO.INTENSITY,
         C.CYCLE_NUM
    FROM (SELECT   JO.CYCLE_ID,
                   JO.DATE_OBSERVATION,
                   JO.MEASURE_TYPE_ID,
                   (SUM (VI / 1000) * 60 * 60 * 24 / 1000) AS INTENSITY,
                   SUM (FRI * 100) AS EXPENSE
              FROM (SELECT JO1.CYCLE_ID,
                           JO1.DATE_OBSERVATION,
                           JO3.MEASURE_TYPE_ID,
                           JO1.VALUE AS CAI,
                           JO2.VALUE AS CAVB,
                           JO3.VALUE AS FRI,
                           (JO1.VALUE - JO2.VALUE),
                           (CASE
                               WHEN ((JO1.VALUE - JO2.VALUE) < 0)
                                  THEN 0
                               ELSE (JO1.VALUE - JO2.VALUE) * JO3.VALUE
                            END) AS VI
                      FROM JOURNAL_OBSERVATIONS JO1,
                           (SELECT JO.DATE_OBSERVATION,
                                   JO.VALUE
                              FROM JOURNAL_OBSERVATIONS JO
                             WHERE JO.MEASURE_TYPE_ID = 2600
                               AND JO.PARAM_ID = 3067
                               AND JO.POINT_ID = 4079) JO2,
                           (SELECT DECODE (JO.POINT_ID,
                                           3471, 4029,
                                           3211, 4010,
                                           3214, 4011,
                                           3225, 4012,
                                           3226, 4013,
                                           3228, 4014,
                                           3231, 4015,
                                           3233, 4016,
                                           3260, 4017,
                                           3261, 4018,
                                           3298, 4019,
                                           3310, 4020,
                                           3323, 4021,
                                           3344, 4022,
                                           3346, 4024,
                                           3354, 4025,
                                           3356, 4026,
                                           3360, 4027,
                                           3361, 4028,
                                           3855, 4009,
                                           3369, 4007,
                                           3870, 4008,
                                           3875, 4006
                                          ) AS POINT_ID,
                                   JO.CYCLE_ID,
                                   JO.VALUE,
                                   JO.MEASURE_TYPE_ID
                              FROM JOURNAL_OBSERVATIONS JO
                             WHERE JO.MEASURE_TYPE_ID = 2581
                               AND PARAM_ID = 3042) JO3
                     WHERE JO2.DATE_OBSERVATION = JO1.DATE_OBSERVATION
                       AND JO3.CYCLE_ID = JO1.CYCLE_ID
                       AND JO3.POINT_ID = JO1.POINT_ID
                       AND JO1.MEASURE_TYPE_ID = 2600
                       AND JO1.PARAM_ID = 3067
                       AND JO1.POINT_ID <> 4079) JO
          GROUP BY JO.CYCLE_ID,
                   JO.DATE_OBSERVATION,
                   JO.MEASURE_TYPE_ID) JO,
         CYCLES C
   WHERE JO.CYCLE_ID = C.CYCLE_ID
ORDER BY C.CYCLE_NUM,
         JO.DATE_OBSERVATION


--

/* Фиксация изменений */

COMMIT


