/*  Создание процедуры получения отчета по критериям безопасности */

CREATE OR REPLACE PROCEDURE REPORT_CRITERIAS
( 
  PERIOD IN INTEGER, 
  DATE_BEGIN IN DATE, 
  DATE_END IN DATE, 
  CYCLE_MIN IN INTEGER, 
  CYCLE_MAX IN INTEGER, 
  OUT_CURSOR OUT SYS_REFCURSOR 
) 
AS 
BEGIN 
    OPEN OUT_CURSOR FOR 
                 SELECT T.*, 
                        C.NAME, 
         C.FIRST_MIN_VALUE, 
                        C.FIRST_MAX_VALUE, 
                        C.FIRST_MODULO, 
                        C.SECOND_MIN_VALUE, 
                        C.SECOND_MAX_VALUE, 
                        C.SECOND_MODULO, 
            T2.COORDINATE_Z,  
      T2.OBJECT_PATHS,  
      MU.NAME AS MEASURE_UNIT_NAME, 
      T2.CONVERTER_NAME, 
      T2.POINT_NAME, 
      C.CYCLE_NUM, 
          GMO.UVB, 
      GMO.T_AIR 
             FROM TABLE(CAST(GET_REPORT_CRITERIAS(PERIOD,DATE_BEGIN,DATE_END,CYCLE_MIN,CYCLE_MAX) AS REPORT_CRITERIA_TABLE)) T, 
                        (SELECT P.COORDINATE_Z, OT.OBJECT_PATHS, P.POINT_ID, C.NAME AS CONVERTER_NAME, P.NAME AS POINT_NAME 
                           FROM POINTS P, OBJECTS O, CONVERTERS C, 
                               (SELECT OT1.OBJECT_ID, SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS 
                                   FROM OBJECT_TREES OT1, OBJECTS O1 
                                  WHERE OT1.OBJECT_ID=O1.OBJECT_ID 
                                  START WITH OT1.PARENT_ID IS NULL 
                                CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID 
                                  GROUP BY OT1.OBJECT_ID) OT 
                          WHERE P.OBJECT_ID=O.OBJECT_ID 
          AND P.POINT_ID=C.CONVERTER_ID(+) 
                            AND O.OBJECT_ID=OT.OBJECT_ID(+) ) T2, 
         CRITERIAS C, MEASURE_UNITS MU, CYCLES C, S_GMO_JOURNAL_OBSERVATIONS GMO   
                  WHERE T.POINT_ID=T2.POINT_ID (+) 
        AND T.CRITERIA_ID=C.CRITERIA_ID 
     AND C.MEASURE_UNIT_ID=MU.MEASURE_UNIT_ID(+) 
     AND T.CYCLE_ID=C.CYCLE_ID (+) 
     AND T.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+) 
         ORDER BY C.PRIORITY, T.DATE_OBSERVATION; 
END;

--

/* Фиксация изменений */

COMMIT

