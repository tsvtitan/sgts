/* �������� ��������� ��������� ���������������� ��� ��������� ��������� */

CREATE OR REPLACE VIEW S_SL1_CONVERTER_PASSPORTS
AS
SELECT MT.MEASURE_TYPE_ID,
       MT.NAME AS MEASURE_TYPE_NAME,
	   R.ROUTE_ID,
	   R.NAME AS ROUTE_NAME,
       P.POINT_ID,
       P.NAME AS POINT_NAME,
	   TRIM(CHR(10) FROM TRIM(CHR(13) FROM GET_OBJECT_PATHS(P.OBJECT_ID))) AS OBJECT_PATHS,
	   P.COORDINATE_Z,
	   C.NAME AS CONVERTER_NAME,
	   C.DATE_ENTER,
	   CP.*
  FROM CONVERTERS C, POINTS P, ROUTE_POINTS RP, ROUTES R, MEASURE_TYPE_ROUTES MTR, MEASURE_TYPES MT,
       (SELECT CONVERTER_ID,
               DATE_BEGIN,
               DATE_END,
               MIN(DECODE(PARAM_ID,30001,TO_NUMBER(REPLACE(VALUE,',','.'),'FM99999.9999'),NULL)) AS DIRECTION,
               MIN(DECODE(PARAM_ID,30000,TO_NUMBER(REPLACE(VALUE,',','.'),'FM99999.9999'),NULL)) AS BASE_COUNTING_OUT,
               MIN(DECODE(PARAM_ID,30002,TO_NUMBER(REPLACE(VALUE,',','.'),'FM99999.9999'),NULL)) AS BASE_OPENING,
               MIN(DECODE(PARAM_ID,30003,VALUE,NULL)) AS DESCRIPTION
          FROM (SELECT C.CONVERTER_ID, CP.DATE_BEGIN, CP.DATE_END, C.PARAM_ID, CP.VALUE 
                  FROM CONVERTER_PASSPORTS CP, COMPONENTS C
                 WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                   AND C.PARAM_ID IN (30001,30000,30002,30003)
                 ORDER BY C.CONVERTER_ID, CP.DATE_BEGIN) CPC
         GROUP BY CONVERTER_ID, DATE_BEGIN, DATE_END) CP
 WHERE C.CONVERTER_ID=P.POINT_ID
   AND C.CONVERTER_ID=CP.CONVERTER_ID
   AND P.POINT_ID=RP.POINT_ID
   AND RP.ROUTE_ID=R.ROUTE_ID
   AND R.ROUTE_ID=MTR.ROUTE_ID
   AND MTR.MEASURE_TYPE_ID=MT.MEASURE_TYPE_ID
   AND MT.MEASURE_TYPE_ID IN (30001,30002,30003,30004)
 ORDER BY MT.PRIORITY, MTR.PRIORITY, RP.PRIORITY, P.NAME, CP.DATE_BEGIN DESC

--

/* �������� ��������� */ 

COMMIT