/* Создание просмтра плана-графика для персонала */

CREATE OR REPLACE VIEW S_PLAN_GRAPH_PERSONNELS_JF
AS 
SELECT   MIN (PGP.YEAR) AS YEAR,
         MIN (PGP.FNAME) AS FNAME,
         MIN (PGP.NAME) AS NAME,
         MIN (PGP.SNAME) AS SNAME,
         MIN (PGP.PRIORITY) AS PRIORITY,
         MIN (PGP.PARENT_NAME) AS PARENT_NAME,
         PGP.MEASURE_TYPE_ID,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 0
                    THEN CASE
                           WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                              THEN CASE
                                     WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS JANUARY,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 1
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS FEBRUARY,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 2
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS MARCH,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 3
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS APRIL,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 4
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS MAY,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 5
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS JUNE,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 6
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS JULY,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 7
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS AUGUST,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 8
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS SEPTEMBER,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 9
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS OKTOBER,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 10
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS NOVEMBER,
         MAX (CASE
                 WHEN PGP.CYCLE_MONTH = 11
                    THEN CASE
                           WHEN PGP.CYCLE_ID = PGJ.CYCLE_ID
                              THEN CASE
                                     WHEN PGP.MEASURE_TYPE_ID = PGJ.MEASURE_TYPE_ID
                                        THEN 2
                                     ELSE 1
                                  END
                           ELSE 1
                        END
                 ELSE 0
              END
             ) AS DECEMBER,
         MIN (PGP.MEASURE_TYPE_NAME) AS MEASURE_TYPE_NAME
    FROM S_PLAN_GRAPH_PERSONNELS PGP,
         S_PLAN_GRAPH_JF PGJ
GROUP BY PGP.MEASURE_TYPE_ID,
         PGP.YEAR,
         PGP.FNAME

--

/* Фиксация изменений */

COMMIT

