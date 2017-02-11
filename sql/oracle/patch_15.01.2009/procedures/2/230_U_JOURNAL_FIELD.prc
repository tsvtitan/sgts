/* �������� ��������� ��������� ������ � ������� ������� */

CREATE OR REPLACE PROCEDURE U_JOURNAL_FIELD
( 
  JOURNAL_FIELD_ID IN INTEGER, 
  CYCLE_ID IN INTEGER, 
  POINT_ID IN INTEGER, 
  PARAM_ID IN INTEGER, 
  INSTRUMENT_ID IN INTEGER, 
  MEASURE_UNIT_ID IN INTEGER, 
  VALUE IN FLOAT, 
  WHO_ENTER IN INTEGER, 
  DATE_ENTER IN DATE, 
  WHO_CONFIRM IN INTEGER, 
  DATE_CONFIRM IN DATE, 
  DATE_OBSERVATION IN DATE, 
  GROUP_ID IN VARCHAR, 
  PRIORITY IN INTEGER, 
  IS_BASE IN INTEGER, 
  MEASURE_TYPE_ID IN INTEGER, 
  JOURNAL_NUM IN VARCHAR2, 
  NOTE IN VARCHAR2, 
  PARENT_ID IN INTEGER, 
  IS_CHECK IN INTEGER, 
  OLD_JOURNAL_FIELD_ID IN INTEGER 
) 
AS 
BEGIN 
  UPDATE JOURNAL_FIELDS  
     SET JOURNAL_FIELD_ID=U_JOURNAL_FIELD.JOURNAL_FIELD_ID, 
         CYCLE_ID=U_JOURNAL_FIELD.CYCLE_ID, 
         POINT_ID=U_JOURNAL_FIELD.POINT_ID, 
         PARAM_ID=U_JOURNAL_FIELD.PARAM_ID, 
         INSTRUMENT_ID=U_JOURNAL_FIELD.INSTRUMENT_ID, 
         MEASURE_UNIT_ID=U_JOURNAL_FIELD.MEASURE_UNIT_ID, 
         VALUE=U_JOURNAL_FIELD.VALUE, 
         WHO_ENTER=U_JOURNAL_FIELD.WHO_ENTER, 
         DATE_ENTER=U_JOURNAL_FIELD.DATE_ENTER, 
         WHO_CONFIRM=U_JOURNAL_FIELD.WHO_CONFIRM, 
         DATE_CONFIRM=U_JOURNAL_FIELD.DATE_CONFIRM, 
         GROUP_ID=U_JOURNAL_FIELD.GROUP_ID, 
         PRIORITY=U_JOURNAL_FIELD.PRIORITY, 
         DATE_OBSERVATION=U_JOURNAL_FIELD.DATE_OBSERVATION, 
   IS_BASE=U_JOURNAL_FIELD.IS_BASE, 
   MEASURE_TYPE_ID=U_JOURNAL_FIELD.MEASURE_TYPE_ID, 
   JOURNAL_NUM=U_JOURNAL_FIELD.JOURNAL_NUM, 
   NOTE=U_JOURNAL_FIELD.NOTE, 
   PARENT_ID=U_JOURNAL_FIELD.PARENT_ID, 
   IS_CHECK=U_JOURNAL_FIELD.IS_CHECK 
   WHERE JOURNAL_FIELD_ID=OLD_JOURNAL_FIELD_ID; 
  COMMIT; 
END;

--

/* �������� ��������� */

COMMIT
