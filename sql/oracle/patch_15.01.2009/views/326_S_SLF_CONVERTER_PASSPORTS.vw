/* �������� ��������� ��������� ���������������� ��������� ��������� */

CREATE OR REPLACE VIEW S_SLF_CONVERTER_PASSPORTS
AS 
SELECT   MT.MEASURE_TYPE_ID, MT.NAME AS MEASURE_TYPE_NAME, R.ROUTE_ID,
         R.NAME AS ROUTE_NAME, P.POINT_ID, P.NAME AS POINT_NAME,
         TRIM
            (CHR (10) FROM TRIM (CHR (13) FROM GET_OBJECT_PATHS (P.OBJECT_ID))
            ) AS OBJECT_PATHS,
         P.COORDINATE_Z, C.NAME AS CONVERTER_NAME, C.DATE_ENTER,
         CP.CONVERTER_ID, CP.DATE_BEGIN, CP.DATE_END, CP.BASE_COUNTING_OUT_X,
         CP.BASE_COUNTING_OUT_Y, CP.BASE_COUNTING_OUT_Z, CP.BASE_OPENING_X,
         CP.BASE_OPENING_Y, CP.BASE_OPENING_Z, CP.DESCRIPTION
    FROM CONVERTERS C,
         POINTS P,
         ROUTE_POINTS RP,
         ROUTES R,
         MEASURE_TYPE_ROUTES MTR,
         MEASURE_TYPES MT,
         (SELECT   CONVERTER_ID, DATE_BEGIN, DATE_END,
                   MIN
                      (DECODE (PARAM_ID,
                               30020, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS BASE_COUNTING_OUT_X,
                   MIN
                      (DECODE (PARAM_ID,
                               30021, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS BASE_COUNTING_OUT_Y,
                   MIN
                      (DECODE (PARAM_ID,
                               30022, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS BASE_COUNTING_OUT_Z,
                   MIN
                      (DECODE (PARAM_ID,
                               30024, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS BASE_OPENING_X,
                   MIN
                      (DECODE (PARAM_ID,
                               30025, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS BASE_OPENING_Y,
                   MIN
                      (DECODE (PARAM_ID,
                               30026, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS BASE_OPENING_Z,
                   MIN (DECODE (PARAM_ID, 30027, VALUE, NULL)) AS DESCRIPTION
              FROM (SELECT   C.CONVERTER_ID, CP.DATE_BEGIN, CP.DATE_END,
                             C.PARAM_ID, CP.VALUE
                        FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                       WHERE CP.COMPONENT_ID = C.COMPONENT_ID
                         AND C.PARAM_ID IN
                                (30020,
                                 30021,
                                 30022,
                                 30024,
                                 30025,
                                 30026,
                                 30027
                                )
                    ORDER BY C.CONVERTER_ID, CP.DATE_BEGIN) CPC
          GROUP BY CONVERTER_ID, DATE_BEGIN, DATE_END) CP
   WHERE C.CONVERTER_ID = P.POINT_ID
     AND C.CONVERTER_ID = CP.CONVERTER_ID
     AND P.POINT_ID = RP.POINT_ID
     AND RP.ROUTE_ID = R.ROUTE_ID
     AND R.ROUTE_ID = MTR.ROUTE_ID
     AND MTR.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID
     AND MT.MEASURE_TYPE_ID IN (30010, 30011)
ORDER BY MT.PRIORITY, MTR.PRIORITY, RP.PRIORITY, P.NAME, CP.DATE_BEGIN DESC

--

/* �������� ��������� */

COMMIT


