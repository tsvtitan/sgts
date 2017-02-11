/* �������� ��������� ��������� ������ � ������� �������� */

CREATE OR REPLACE PROCEDURE U_JOURNAL_CHECKUP
( 
  JOURNAL_CHECKUP_ID IN INTEGER, 
  POINT_ID IN INTEGER, 
  CYCLE_ID IN INTEGER, 
  MEASURE_TYPE_ID IN INTEGER, 
  DEFECT_VIEW_ID IN INTEGER, 
  DATE_OBSERVATION IN DATE, 
  NOTE IN VARCHAR2, 
  JOURNAL_NUM IN VARCHAR2, 
  WHO_ENTER IN INTEGER, 
  DATE_ENTER IN DATE, 
  WHO_CONFIRM IN INTEGER, 
  DATE_CONFIRM IN DATE, 
  INCLINATION IN VARCHAR2, 
  WIDTH_DEFECT IN VARCHAR2, 
  HEIGHT_DEFECT IN VARCHAR2, 
  LENGTH_DEFECT IN VARCHAR2, 
  OLD_JOURNAL_CHECKUP_ID IN INTEGER 
) 
AS 
BEGIN 
  UPDATE JOURNAL_CHECKUPS  
     SET JOURNAL_CHECKUP_ID=U_JOURNAL_CHECKUP.JOURNAL_CHECKUP_ID, 
         POINT_ID=U_JOURNAL_CHECKUP.POINT_ID, 
         CYCLE_ID=U_JOURNAL_CHECKUP.CYCLE_ID, 
   MEASURE_TYPE_ID=U_JOURNAL_CHECKUP.MEASURE_TYPE_ID, 
         DEFECT_VIEW_ID=U_JOURNAL_CHECKUP.DEFECT_VIEW_ID, 
         DATE_OBSERVATION=U_JOURNAL_CHECKUP.DATE_OBSERVATION, 
   NOTE=U_JOURNAL_CHECKUP.NOTE, 
   JOURNAL_NUM=U_JOURNAL_CHECKUP.JOURNAL_NUM, 
         WHO_ENTER=U_JOURNAL_CHECKUP.WHO_ENTER, 
         DATE_ENTER=U_JOURNAL_CHECKUP.DATE_ENTER, 
         WHO_CONFIRM=U_JOURNAL_CHECKUP.WHO_CONFIRM, 
         DATE_CONFIRM=U_JOURNAL_CHECKUP.DATE_CONFIRM, 
   INCLINATION=U_JOURNAL_CHECKUP.INCLINATION, 
   WIDTH_DEFECT=U_JOURNAL_CHECKUP.WIDTH_DEFECT, 
   HEIGHT_DEFECT=U_JOURNAL_CHECKUP.HEIGHT_DEFECT, 
   LENGTH_DEFECT=U_JOURNAL_CHECKUP.LENGTH_DEFECT 
   WHERE JOURNAL_CHECKUP_ID=OLD_JOURNAL_CHECKUP_ID; 
  COMMIT; 
END;

--

/* �������� ��������� */

COMMIT
