/* Создание просмотра плана-графика для персонала 2 */

CREATE OR REPLACE VIEW S_PLAN_GRAPH_PERSONNELS
AS 
SELECT   CYC.CYCLE_ID,
         P.FNAME,
         P.NAME,
         P.SNAME,
         MIN (CYC.CYCLE_MONTH) AS CYCLE_MONTH,
         MIN (CYC.CYCLE_NUM) AS CYCLE_NUM,
         MTG.MEASURE_TYPE_ID,
         MIN (MT.NAME) AS MEASURE_TYPE_NAME,
         (SELECT NAME
            FROM MEASURE_TYPES
           WHERE MEASURE_TYPE_ID = MT.PARENT_ID) AS PARENT_NAME,
         MAX (  DECODE ((SELECT PRIORITY
                           FROM MEASURE_TYPES
                          WHERE MEASURE_TYPE_ID = MT.PARENT_ID), NULL, 0, (SELECT PRIORITY
                                                                             FROM MEASURE_TYPES
                                                                            WHERE MEASURE_TYPE_ID = MT.PARENT_ID)) * 10
              + MT.PRIORITY * DECODE ((SELECT PRIORITY
                                         FROM MEASURE_TYPES
                                        WHERE MEASURE_TYPE_ID = MT.PARENT_ID), NULL, 10, 1)
             ) AS PRIORITY,
         MIN (MTG.YEAR) AS YEAR
    FROM CYCLES CYC,
         MEASURE_TYPE_GRAPHS MTG,
         MEASURE_TYPE_ROUTES MTR,
         MEASURE_TYPES MT,
         ROUTES R,
         PERSONNEL_ROUTES PR,
         PERSONNELS P
   WHERE CYC.CYCLE_YEAR = MTG.YEAR
     AND MTG.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID
     AND MT.MEASURE_TYPE_ID = MTR.MEASURE_TYPE_ID
     AND R.ROUTE_ID = MTR.ROUTE_ID
     AND PR.ROUTE_ID = R.ROUTE_ID
     AND PR.PERSONNEL_ID = P.PERSONNEL_ID
     AND (   (    MTG.JANUARY = 1
              AND CYC.CYCLE_MONTH = 0)
          OR (    MTG.FEBRUARY = 1
              AND CYC.CYCLE_MONTH = 1)
          OR (    MTG.MARCH = 1
              AND CYC.CYCLE_MONTH = 2)
          OR (    MTG.APRIL = 1
              AND CYC.CYCLE_MONTH = 3)
          OR (    MTG.MAY = 1
              AND CYC.CYCLE_MONTH = 4)
          OR (    MTG.JUNE = 1
              AND CYC.CYCLE_MONTH = 5)
          OR (    MTG.JULY = 1
              AND CYC.CYCLE_MONTH = 6)
          OR (    MTG.AUGUST = 1
              AND CYC.CYCLE_MONTH = 7)
          OR (    MTG.SEPTEMBER = 1
              AND CYC.CYCLE_MONTH = 8)
          OR (    MTG.OKTOBER = 1
              AND CYC.CYCLE_MONTH = 9)
          OR (    MTG.NOVEMBER = 1
              AND CYC.CYCLE_MONTH = 10)
          OR (    MTG.DECEMBER = 1
              AND CYC.CYCLE_MONTH = 11)
         )
GROUP BY P.FNAME,
         P.NAME,
         P.SNAME,
         CYC.CYCLE_ID,
         MT.PARENT_ID,
         MTG.MEASURE_TYPE_ID

--

/* Фиксация изменений */

COMMIT


