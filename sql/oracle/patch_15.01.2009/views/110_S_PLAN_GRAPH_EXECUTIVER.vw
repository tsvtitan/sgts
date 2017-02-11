/* Создание просмотра плана-графика исполнителя */

CREATE OR REPLACE VIEW S_PLAN_GRAPH_EXECUTIVER
AS 
SELECT   MIN (DECODE (MTG.JANUARY, 1, 1, 0)) AS JANUARY,
         MIN (DECODE (MTG.FEBRUARY, 1, 1, 0)) AS FEBRUARY,
         MIN (DECODE (MTG.MARCH, 1, 1, 0)) AS MARCH,
         MIN (DECODE (MTG.APRIL, 1, 1, 0)) AS APRIL,
         MIN (DECODE (MTG.MAY, 1, 1, 0)) AS MAY,
         MIN (DECODE (MTG.JUNE, 1, 1, 0)) AS JUNE,
         MIN (DECODE (MTG.JULY, 1, 1, 0)) AS JULY,
         MIN (DECODE (MTG.AUGUST, 1, 1, 0)) AS AUGUST,
         MIN (DECODE (MTG.SEPTEMBER, 1, 1, 0)) AS SEPTEMBER,
         MIN (DECODE (MTG.OKTOBER, 1, 1, 0)) AS OKTOBER,
         MIN (DECODE (MTG.NOVEMBER, 1, 1, 0)) AS NOVEMBER,
         MIN (DECODE (MTG.DECEMBER, 1, 1, 0)) AS DECEMBER,
         MTG.MEASURE_TYPE_ID,
         MAX (  MTG.JANUARY
              + MTG.FEBRUARY
              + MTG.MARCH
              + MTG.APRIL
              + MTG.MAY
              + MTG.JUNE
              + MTG.JULY
              + MTG.AUGUST
              + MTG.SEPTEMBER
              + MTG.OKTOBER
              + MTG.NOVEMBER
              + MTG.DECEMBER
             ) AS PERIOD,
         MIN (MT.NAME) AS MEASURE_TYPE_NAME,
         (SELECT NAME
            FROM MEASURE_TYPES
           WHERE MEASURE_TYPE_ID = MT.PARENT_ID) AS PARENT_NAME,
         MAX (  DECODE ((SELECT PRIORITY
                           FROM MEASURE_TYPES
                          WHERE MEASURE_TYPE_ID = MT.PARENT_ID), NULL, 0, (SELECT PRIORITY
                                                                             FROM MEASURE_TYPES
                                                                            WHERE MEASURE_TYPE_ID = MT.PARENT_ID)) * 100
              + MT.PRIORITY * DECODE ((SELECT PRIORITY
                                         FROM MEASURE_TYPES
                                        WHERE MEASURE_TYPE_ID = MT.PARENT_ID), NULL, 100, 1)
             ) AS PRIORITY,
         MIN (MTG.YEAR) AS YEAR
    FROM MEASURE_TYPE_GRAPHS MTG,
         MEASURE_TYPES MT
   WHERE MTG.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID
     AND (   MTG.JANUARY = 1
          OR MTG.FEBRUARY = 1
          OR MTG.MARCH = 1
          OR MTG.APRIL = 1
          OR MTG.MAY = 1
          OR MTG.JUNE = 1
          OR MTG.JULY = 1
          OR MTG.AUGUST = 1
          OR MTG.SEPTEMBER = 1
          OR MTG.OKTOBER = 1
          OR MTG.NOVEMBER = 1
          OR MTG.DECEMBER = 1
         )
GROUP BY MT.PARENT_ID,
         MTG.MEASURE_TYPE_ID,
         MTG.YEAR


--

/* Фиксация изменений */

COMMIT

