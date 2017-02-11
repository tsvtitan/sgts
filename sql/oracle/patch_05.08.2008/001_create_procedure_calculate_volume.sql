/* �������� ������� ����������� ��� �� ������ ������������� */

CREATE TABLE DEPENDENCY_UVB_VOLUME
(
  UVB FLOAT,
  VOLUME FLOAT,
  PRIMARY KEY(UVB)
)  

--

/* �������� ��������� ������� ������ ������������� */

CREATE OR REPLACE PROCEDURE CALCULATE_VOLUME
(
  UVB IN FLOAT,
  VOLUME OUT FLOAT
)
AS
  MIN_VOLUME FLOAT;
  MAX_VOLUME FLOAT; 
BEGIN
  VOLUME:=NULL;
  IF (UVB IS NOT NULL) THEN
    
	MIN_VOLUME:=0.0; 
    FOR INC IN (SELECT VOLUME 
	              FROM DEPENDENCY_UVB_VOLUME 
	             WHERE UVB<=CALCULATE_VOLUME.UVB
				 ORDER BY UVB DESC) LOOP
      MIN_VOLUME:=INC.VOLUME;				 
      EXIT WHEN MIN_VOLUME IS NOT NULL;				 
    END LOOP;

	MAX_VOLUME:=0.0; 
    FOR INC IN (SELECT VOLUME 
	              FROM DEPENDENCY_UVB_VOLUME 
	             WHERE UVB>=CALCULATE_VOLUME.UVB
				 ORDER BY UVB ASC) LOOP
      MAX_VOLUME:=INC.VOLUME;				 
      EXIT WHEN MAX_VOLUME IS NOT NULL;				 
    END LOOP;

	VOLUME:=0;
	IF (MIN_VOLUME<>0.0) AND (MAX_VOLUME<>0.0) THEN
	  VOLUME:=(MIN_VOLUME+MAX_VOLUME)/2;
	ELSE
	  IF (MIN_VOLUME<>0.0) THEN
	    VOLUME:=MIN_VOLUME;
	  END IF;
	  IF (MAX_VOLUME<>0.0) THEN
	    VOLUME:=MAX_VOLUME;
	  END IF; 
	END IF;
	 	
  END IF;	 
END;

--

/* �������� ��������� �� */

COMMIT