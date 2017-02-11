/* Создание функции получения таблицы точек лежащих в секциях */

CREATE OR REPLACE FUNCTION GET_POINTS_IN_SECTIONS
(
  ROUTE_ID IN INTEGER,
  SECTIONS IN VARCHAR2,
  OBJECT_PATHS IN VARCHAR,
  DIVIDER IN VARCHAR2
) 
RETURN POINT_TABLE 
PIPELINED 
AS
  RET POINT_OBJECT:=POINT_OBJECT(NULL);
BEGIN
  FOR INC IN (SELECT DISTINCT(T.POINT_ID)
                FROM (SELECT T.POINT_ID,
                             SUBSTR(T.OBJECT_PATHS,1,INSTR(T.OBJECT_PATHS,'\')-1) AS OBJECT_PATHS
                        FROM (SELECT RP.POINT_ID, 
                                     SUBSTR(OT.OBJECT_PATHS,LENGTH(GET_POINTS_IN_SECTIONS.OBJECT_PATHS)+1) AS OBJECT_PATHS 
                                FROM ROUTE_POINTS RP, POINTS P,
	                                 (SELECT OT1.OBJECT_ID, 
	                                         O1.NAME AS OBJECT_NAME, 
	                                         SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS 
	                                    FROM OBJECT_TREES OT1, OBJECTS O1 
	                                   WHERE OT1.OBJECT_ID=O1.OBJECT_ID 
	                                   START WITH OT1.PARENT_ID IS NULL 
	                                 CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID 
	                                   GROUP BY OT1.OBJECT_ID,O1.NAME) OT    
	                           WHERE RP.ROUTE_ID=GET_POINTS_IN_SECTIONS.ROUTE_ID
	                             AND RP.POINT_ID=P.POINT_ID
	                             AND P.OBJECT_ID=OT.OBJECT_ID(+)) T) T
	                   WHERE T.OBJECT_PATHS IN (SELECT VALUE FROM TABLE(CAST(GET_VARCHAR_TABLE(SECTIONS,DIVIDER) AS VARCHAR_TABLE)))) LOOP
    RET.POINT_ID:=INC.POINT_ID;
	PIPE ROW (RET);     					   
  END LOOP;
  RETURN; 
END;  

--

/* Фиксация изменений */

COMMIT