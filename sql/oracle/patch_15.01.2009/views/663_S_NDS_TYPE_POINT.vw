/* Создание просмотра типов точек напряженно-деформированного стостояния */

CREATE OR REPLACE VIEW S_NDS_TYPE_POINT
AS 
SELECT   P.POINT_ID,
         MIN (TO_NUMBER (P.NAME)) AS POINT_NAME,
         MIN (CV.NAME) AS CONVERTER_NAME,
         MIN (CP.TYPE) AS TYPE
    FROM MEASURE_TYPES MT,
         POINTS P,
         CONVERTERS CV,
         (SELECT   CONVERTER_ID,
                   MIN (DECODE (PARAM_ID, 60030, VALUE, NULL)) AS TYPE
              FROM (SELECT CM.CONVERTER_ID,
                           CM.PARAM_ID,
                           CP.VALUE
                      FROM CONVERTER_PASSPORTS CP,
                           COMPONENTS CM
                     WHERE CP.COMPONENT_ID = CM.COMPONENT_ID
                       AND CM.PARAM_ID = 60030)
          GROUP BY CONVERTER_ID) CP
   WHERE MT.MEASURE_TYPE_ID IN (60001, 60002, 60003, 60004, 60005)
     AND CP.CONVERTER_ID = P.POINT_ID
     AND CV.CONVERTER_ID = P.POINT_ID
GROUP BY P.POINT_ID

--

/* Фиксация изменений */

COMMIT


