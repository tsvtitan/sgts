/* �������� ��������� ������� ����������� */

CREATE OR REPLACE VIEW S_INTERFACE_REPORTS
AS 
SELECT RP.INTERFACE_REPORT_ID,
       RP.BASE_REPORT_ID,
       RP.INTERFACE,
       RP.PRIORITY,
       BR.NAME AS BASE_REPORT_NAME
  FROM INTERFACE_REPORTS RP,
       BASE_REPORTS BR
 WHERE RP.BASE_REPORT_ID = BR.BASE_REPORT_ID

--

/* �������� ��������� */

COMMIT

