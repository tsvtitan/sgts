/* �������� ��������� ������� ����������� ������ */

CREATE OR REPLACE PROCEDURE CALCULATE_NDS_TEMPERATURE
(
  POINT_ID IN INTEGER,
  RESISTANCE IN FLOAT,
  RESISTANCE_LINE IN FLOAT,
  DATE_OBSERVATION IN DATE,
  MEASURE_TYPE_ID IN INTEGER,
  CYCLE_ID IN INTEGER,
  IS_BASE IN INTEGER,
  TEMPERATURE OUT FLOAT
)
AS
  RATIO FLOAT;
  RESISTANCE_0 FLOAT;
  POINT_NAME INTEGER;
BEGIN

  SELECT NAME INTO POINT_NAME FROM POINTS WHERE POINT_ID=CALCULATE_NDS_TEMPERATURE.POINT_ID;
/*  DBMS_OUTPUT.PUT_LINE('POINT_NAME='||TO_CHAR(POINT_NAME));			
  DBMS_OUTPUT.PUT_LINE('DATE='||TO_CHAR(DATE_OBSERVATION));		
  DBMS_OUTPUT.PUT_LINE('RESISTANCE='||TO_CHAR(RESISTANCE));		
  DBMS_OUTPUT.PUT_LINE('RESISTANCE_LINE='||TO_CHAR(RESISTANCE_LINE));*/		
  
  RATIO:=NULL;
  FOR INC IN (SELECT CP.VALUE,
 	                 CP.DATE_BEGIN,
                     CP.DATE_END
                FROM CONVERTER_PASSPORTS CP, COMPONENTS C, POINTS P
               WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                 AND C.CONVERTER_ID=P.POINT_ID
                 AND P.POINT_ID=CALCULATE_NDS_TEMPERATURE.POINT_ID
                 AND C.PARAM_ID=60011 /* ������������� ����������� ������� */
               ORDER BY CP.DATE_BEGIN) LOOP
    RATIO:=TO_NUMBER(REPLACE(INC.VALUE,',','.'),'FM99999.9999');			   
	EXIT WHEN RATIO IS NOT NULL;
  END LOOP;
	  
/*  DBMS_OUTPUT.PUT_LINE('RATIO='||TO_CHAR(RATIO));*/		

  RESISTANCE_0:=NULL;
  FOR INC IN (SELECT CP.VALUE,
 	                 CP.DATE_BEGIN,
                     CP.DATE_END
                FROM CONVERTER_PASSPORTS CP, COMPONENTS C, POINTS P
               WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                 AND C.CONVERTER_ID=P.POINT_ID
                 AND P.POINT_ID=CALCULATE_NDS_TEMPERATURE.POINT_ID
                 AND C.PARAM_ID=60010 /* ������������� ������� */
               ORDER BY CP.DATE_BEGIN) LOOP
    RESISTANCE_0:=TO_NUMBER(REPLACE(INC.VALUE,',','.'),'FM99999.9999');			   
    EXIT WHEN RESISTANCE_0 IS NOT NULL;
  END LOOP;
	  
/*  DBMS_OUTPUT.PUT_LINE('RESISTANCE_0='||TO_CHAR(RESISTANCE_0));*/		

  IF (RATIO IS NOT NULL) AND
     (RESISTANCE_0 IS NOT NULL) AND
	 (RATIO<>0.0) THEN
	 
	TEMPERATURE:=(RESISTANCE-RESISTANCE_0-RESISTANCE_LINE)/RATIO; 
  END IF;
  
/*  DBMS_OUTPUT.PUT_LINE('TEMPERATURE='||TO_CHAR(TEMPERATURE));*/		
END;

--

/* �������� ��������� �� */

COMMIT