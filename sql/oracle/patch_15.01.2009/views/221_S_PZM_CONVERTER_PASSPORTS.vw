/* Создание просмотра паспортов преобразователей пьезометров */

CREATE OR REPLACE VIEW S_PZM_CONVERTER_PASSPORTS
AS 
SELECT   MT.MEASURE_TYPE_ID,
         MT.NAME AS MEASURE_TYPE_NAME,
         R.ROUTE_ID,
         R.NAME AS ROUTE_NAME,
         P.POINT_ID,
         P.NAME AS POINT_NAME,
         TRIM (CHR (10) FROM TRIM (CHR (13) FROM GET_OBJECT_PATHS (P.OBJECT_ID))) AS OBJECT_PATHS,
         P.COORDINATE_Z,
         C.NAME AS CONVERTER_NAME,
         C.DATE_ENTER,
         CP.CONVERTER_ID,
         CP.DATE_BEGIN,
         CP.DATE_END,
         CP.MARK_WATER_RECEIVER,
         CP.MARK_TOP_PIPE,
         CP.MARK_CENTER_MANOMETR,
         CP.MARK_SENSOR,
         CP.MARK_ROCK,
         CP.CORNER_SLOPPING,
         CP.FACTOR_A,
         CP.FACTOR_B,
         CP.FACTOR_C,
         CP.TYPE
    FROM CONVERTERS C,
         POINTS P,
         ROUTE_POINTS RP,
         ROUTES R,
         MEASURE_TYPE_ROUTES MTR,
         MEASURE_TYPES MT,
         (SELECT   CONVERTER_ID,
                   DATE_BEGIN,
                   DATE_END,
                   MIN (DECODE (PARAM_ID, 2943, VALUE, NULL)) AS MARK_WATER_RECEIVER,
                   MIN (DECODE (PARAM_ID, 2944, VALUE, NULL)) AS MARK_TOP_PIPE,
                   MIN (DECODE (PARAM_ID, 2945, VALUE, NULL)) AS MARK_CENTER_MANOMETR,
                   MIN (DECODE (PARAM_ID, 2946, VALUE, NULL)) AS MARK_SENSOR,
                   MIN (DECODE (PARAM_ID, 2947, VALUE, NULL)) AS MARK_ROCK,
                   MIN (DECODE (PARAM_ID, 2948, VALUE, NULL)) AS CORNER_SLOPPING,
                   MIN (DECODE (PARAM_ID, 2949, VALUE, NULL)) AS FACTOR_A,
                   MIN (DECODE (PARAM_ID, 2950, VALUE, NULL)) AS FACTOR_B,
                   MIN (DECODE (PARAM_ID, 2951, VALUE, NULL)) AS FACTOR_C,
                   (SELECT MIN (CP.VALUE)
                      FROM CONVERTER_PASSPORTS CP,
                           COMPONENTS C
                     WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                       AND C.CONVERTER_ID = CPC.CONVERTER_ID
                       AND C.PARAM_ID = 7981) AS TYPE
              FROM (SELECT   C.CONVERTER_ID,
                             CP.DATE_BEGIN,
                             CP.DATE_END,
                             C.PARAM_ID,
                             TO_NUMBER (REPLACE (CP.VALUE, ',', '.'), 'FM99999.9999') AS VALUE
                        FROM CONVERTER_PASSPORTS CP,
                             COMPONENTS C
                       WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                         AND C.PARAM_ID IN (2943, 2944, 2945, 2946, 2947, 2948, 2949, 2950, 2951)
                    ORDER BY C.CONVERTER_ID,
                             CP.DATE_BEGIN) CPC
          GROUP BY CONVERTER_ID,
                   DATE_BEGIN,
                   DATE_END) CP
   WHERE C.CONVERTER_ID = P.POINT_ID
     AND C.CONVERTER_ID = CP.CONVERTER_ID
     AND P.POINT_ID = RP.POINT_ID
     AND RP.ROUTE_ID = R.ROUTE_ID
     AND R.ROUTE_ID = MTR.ROUTE_ID
     AND MTR.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID
     AND MT.MEASURE_TYPE_ID IN (2561, 2562, 2563)
ORDER BY MT.PRIORITY,
         MTR.PRIORITY,
         RP.PRIORITY,
         P.NAME,
         CP.DATE_BEGIN DESC


--

/* Фиксация изменений */

COMMIT


