/* �������� ��������� ��������� ������� ����� */

CREATE OR REPLACE PROCEDURE U_POINT_INSTRUMENT
( 
  POINT_ID IN INTEGER, 
  INSTRUMENT_ID IN INTEGER, 
  PARAM_ID IN INTEGER, 
  PRIORITY IN INTEGER, 
  OLD_POINT_ID IN INTEGER, 
  OLD_INSTRUMENT_ID IN INTEGER, 
  OLD_PARAM_ID IN INTEGER 
) 
AS 
BEGIN 
  UPDATE POINT_INSTRUMENTS  
     SET POINT_ID=U_POINT_INSTRUMENT.POINT_ID, 
         INSTRUMENT_ID=U_POINT_INSTRUMENT.INSTRUMENT_ID, 
   PARAM_ID=U_POINT_INSTRUMENT.PARAM_ID, 
         PRIORITY=U_POINT_INSTRUMENT.PRIORITY 
   WHERE POINT_ID=OLD_POINT_ID  
     AND INSTRUMENT_ID=OLD_INSTRUMENT_ID 
  AND PARAM_ID=OLD_PARAM_ID; 
  COMMIT;         
END;

--

/* �������� ��������� */

COMMIT
