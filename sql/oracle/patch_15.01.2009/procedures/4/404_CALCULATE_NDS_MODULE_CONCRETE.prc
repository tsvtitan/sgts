/* �������� ��������� ���������� ������ ��������� ������ */

CREATE OR REPLACE PROCEDURE CALCULATE_NDS_MODULE_CONCRETE
( 
  POINT_ID IN INTEGER, 
  DATE_OBSERVATION IN DATE, 
  MODULE OUT FLOAT 
) 
AS 
  COORDINATE_Z FLOAT; 
  DATE_BOOKMARK DATE; 
  OBJECT_PATHS VARCHAR2(1000); 
  DAYS INTEGER; 
  S VARCHAR2(100); 
  POLE VARCHAR2(100); 
  SECTION VARCHAR2(100); 
BEGIN 
  DATE_BOOKMARK:=NULL; 
/*  DBMS_OUTPUT.PUT_LINE('POINT_ID='||TO_CHAR(POINT_ID));*/ 
     
  FOR INC IN (SELECT P.COORDINATE_Z, C1.DATE_BOOKMARK, OT.OBJECT_PATHS, 
                     TRIM(SUBSTR(OT.OBJECT_PATHS,LENGTH('�������\���� �������\������ '), 
                               INSTR(OT.OBJECT_PATHS,'\�����')-LENGTH('�������\���� �������\������ '))) AS SECTION, 
                     TRIM(SUBSTR(OT.OBJECT_PATHS,INSTR(OT.OBJECT_PATHS,'\����� ')+LENGTH('\����� '))) AS POLE 
                FROM POINTS P,  
                     (SELECT C.COMPONENT_ID, C.CONVERTER_ID, DECODE(CP.VALUE,NULL,NULL,TO_DATE(CP.VALUE,'DD.MM.YYYY')) AS DATE_BOOKMARK   
                        FROM COMPONENTS C, CONVERTER_PASSPORTS CP 
                       WHERE C.COMPONENT_ID=CP.COMPONENT_ID 
                   AND C.PARAM_ID=60013 /* ���� �������� */) C1, 
                     (SELECT OT1.OBJECT_ID, SUBSTR(MAX(SYS_CONNECT_BY_PATH(O1.NAME,'\')),2) AS OBJECT_PATHS  
                        FROM OBJECT_TREES OT1, OBJECTS O1  
                       WHERE OT1.OBJECT_ID=O1.OBJECT_ID  
                       START WITH OT1.PARENT_ID IS NULL  
                     CONNECT BY OT1.PARENT_ID=PRIOR OT1.OBJECT_TREE_ID  
                       GROUP BY OT1.OBJECT_ID) OT        
               WHERE P.POINT_ID=C1.CONVERTER_ID 
        AND P.OBJECT_ID=OT.OBJECT_ID 
        AND P.POINT_ID=CALCULATE_NDS_MODULE_CONCRETE.POINT_ID) LOOP 
 
    COORDINATE_Z:=INC.COORDINATE_Z; 
 DATE_BOOKMARK:=INC.DATE_BOOKMARK; 
 SECTION:=INC.SECTION;  
 POLE:=INC.POLE; 
 OBJECT_PATHS:=INC.OBJECT_PATHS;             
    EXIT;      
  END LOOP; 
 
/*  DBMS_OUTPUT.PUT_LINE('OBJECT_PATHS='||OBJECT_PATHS);    
  DBMS_OUTPUT.PUT_LINE('DATE_BOOKMARK='||TO_CHAR(DATE_BOOKMARK));*/    
 
  IF (DATE_BOOKMARK IS NOT NULL) THEN  
 
    DAYS:=DATE_OBSERVATION-DATE_BOOKMARK; 
 IF (DAYS>1310) THEN 
   DAYS:=1310; 
 END IF; 
 
/*    DBMS_OUTPUT.PUT_LINE('DAYS='||TO_CHAR(DAYS));*/    
  
 FOR INC IN (SELECT A37_I, A37_VII, A55_I, A55_VII, A22_IV, VODOVOD, PLITA  
               FROM MODULE_BOUNCE_CONCRETE 
     WHERE DNI=DAYS) LOOP 
   S:=SUBSTR(OBJECT_PATHS,1,LENGTH('������ ���\�����')); 
   IF (UPPER(S)=UPPER('������ ���\�����')) THEN 
     MODULE:=INC.PLITA; 
   ELSE 
     S:=SUBSTR(OBJECT_PATHS,1,LENGTH('�������\���� �������\������')); 
     IF (UPPER(S)=UPPER('�������\���� �������\������')) THEN 
    IF (SECTION='37') THEN 
      IF (POLE='1') THEN 
          MODULE:=INC.A37_I; 
   ELSE 
          MODULE:=INC.A37_VII; 
   END IF;   
    ELSE 
      IF (SECTION='55') THEN 
           IF (POLE='4' AND COORDINATE_Z=183.0) THEN 
       MODULE:=INC.A55_I; 
     ELSE 
       MODULE:=INC.A55_VII; 
     END IF;  
   ELSE 
     IF (SECTION='22') THEN 
       MODULE:=INC.A22_IV; 
     END IF;     
   END IF; 
    END IF; 
  ELSE 
    MODULE:=INC.VODOVOD; 
  END IF; 
   END IF;     
      EXIT;             
    END LOOP;      
  
  END IF; 
   
/*  DBMS_OUTPUT.PUT_LINE('MODULE='||MODULE);*/    
       
END;

--

/* �������� ��������� */

COMMIT

