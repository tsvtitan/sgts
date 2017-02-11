/* Создание просмотра паспортов преобразователей напряженно-деформированного состояния */

CREATE OR REPLACE VIEW S_NDS_CONVERTER_PASSPORTS
AS 
SELECT MT.MEASURE_TYPE_ID,
       MT.NAME AS MEASURE_TYPE_NAME,
       P.POINT_ID,
       TO_NUMBER (P.NAME) AS POINT_NAME,
       CV.NAME AS CONVERTER_NAME,
       CP.TYPE,
       CP.LOCATE,
       P.COORDINATE_Z,
       TRIM (CHR (10) FROM TRIM (CHR (13) FROM GET_OBJECT_PATHS (P.OBJECT_ID))) AS OBJECT_PATH,
       CP.DISTANCE,
       CP.ROSETTE,
       CP.CORNER,
       CP.CUTSET,
       CP.COEFFICIENT,
       CP.MOD,
       CP.R0,
       CP.Kt,
       CP.D,
       CP.B0,
       CP.B1,
       CP.B2,
       CP.DIAMETER,
       CP.ANKER,
       CP.EXTENDING,
       CP.KTSHELEMERA,
       DECODE (CP.DATE_BEGIN, NULL, NULL, TO_CHAR (TO_DATE (CP.DATE_BEGIN, 'dd/mm/yy'), 'dd.mm.yy')) AS DATE_BEGIN,
       DECODE (CP.DATE_END, NULL, NULL, TO_CHAR (TO_DATE (CP.DATE_END, 'dd/mm/yy'), 'dd.mm.yy')) AS DATE_END,
       CP.TEMPERATURE
  FROM MEASURE_TYPES MT,
       MEASURE_TYPE_ROUTES MTR,
       POINTS P,
       ROUTE_POINTS RP,
       ROUTES R,
       CONVERTERS CV,
       (SELECT   CONVERTER_ID,
                 MIN (DECODE (PARAM_ID, 60030, VALUE, NULL)) AS TYPE,
                 MIN (DECODE (PARAM_ID, 60008, VALUE, NULL)) AS LOCATE,
                 MIN (DECODE (PARAM_ID, 60023, VALUE, NULL)) AS CUTSET,
                 MIN (DECODE (PARAM_ID, 60012, VALUE, NULL)) AS DATE_BEGIN,
                 MIN (DECODE (PARAM_ID, 60013, VALUE, NULL)) AS DATE_END,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60009, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS DISTANCE,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60017, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS ROSETTE,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60024, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS CORNER,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60018, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS COEFFICIENT,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60019, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS MOD,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60010, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS R0,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60011, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS Kt,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60020, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS TEMPERATURE,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60022, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS D,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60014, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS B0,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60015, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS B1,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60016, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS B2,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60021, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS DIAMETER,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60026, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS ANKER,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60027, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS EXTENDING,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60025, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS KtSHELEMERA
            FROM (SELECT CM.CONVERTER_ID,
                         CM.PARAM_ID,
                         CP.VALUE
                    FROM CONVERTER_PASSPORTS CP,
                         COMPONENTS CM
                   WHERE CP.COMPONENT_ID = CM.COMPONENT_ID
                     AND CM.PARAM_ID IN
                            (60030,
                             60008,
                             60009,
                             60017,
                             60024,
                             60023,
                             60018,
                             60019,
                             60010,
                             60011,
                             60020,
                             60022,
                             60012,
                             60013,
                             60014,
                             60015,
                             60016,
                             60021,
                             60026,
                             60027,
                             60025
                            ))
        GROUP BY CONVERTER_ID) CP
 WHERE MTR.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID
   AND MT.MEASURE_TYPE_ID IN (60001, 60002, 60003, 60004, 60005)
   AND CP.CONVERTER_ID = P.POINT_ID
   AND CV.CONVERTER_ID = P.POINT_ID
   AND RP.POINT_ID = P.POINT_ID
   AND RP.ROUTE_ID = R.ROUTE_ID
   AND R.ROUTE_ID = MTR.ROUTE_ID

--

/* Фиксация изменений */

COMMIT


