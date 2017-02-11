/* Создание просмотра базовых отчетов */

CREATE OR REPLACE VIEW S_BASE_REPORTS
AS 
SELECT B.BASE_REPORT_ID,
       B.NAME,
       B.DESCRIPTION,
       B.REPORT,
       B.PRIORITY,
       B.MENU,
       (CASE
           WHEN DBMS_LOB.GETLENGTH (REPORT) > 0
              THEN 1
           ELSE 0
        END) AS REPORT_EXISTS
  FROM BASE_REPORTS B

--

/* Фиксация изменений */

COMMIT


