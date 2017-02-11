/* �������� ��������� ��������� ������� ��������� ������� */

CREATE OR REPLACE PROCEDURE U_INSTRUMENT_UNIT
( 
  INSTRUMENT_ID IN INTEGER, 
  MEASURE_UNIT_ID IN INTEGER, 
  PRIORITY IN INTEGER, 
  OLD_INSTRUMENT_ID IN INTEGER, 
  OLD_MEASURE_UNIT_ID IN INTEGER 
) 
AS 
BEGIN 
  UPDATE INSTRUMENT_UNITS  
     SET INSTRUMENT_ID=U_INSTRUMENT_UNIT.INSTRUMENT_ID, 
         MEASURE_UNIT_ID=U_INSTRUMENT_UNIT.MEASURE_UNIT_ID, 
   PRIORITY=U_INSTRUMENT_UNIT.PRIORITY 
   WHERE INSTRUMENT_ID=OLD_INSTRUMENT_ID  
     AND MEASURE_UNIT_ID=OLD_MEASURE_UNIT_ID; 
  COMMIT;         
END;

--

/* �������� ��������� */

COMMIT
