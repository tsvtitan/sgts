/* �������� ��������� �������� ������� ��������� � ������� */

CREATE OR REPLACE PROCEDURE D_INSTRUMENT_UNIT
( 
  OLD_INSTRUMENT_ID IN INTEGER, 
  OLD_MEASURE_UNIT_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM INSTRUMENT_UNITS 
        WHERE INSTRUMENT_ID=OLD_INSTRUMENT_ID 
          AND MEASURE_UNIT_ID=OLD_MEASURE_UNIT_ID; 
  COMMIT;         
END;

--

/* �������� ��������� */

COMMIT
