/* Создание фунции генерации идентификатора для таблицы файловых отчетов */

CREATE OR REPLACE FUNCTION GET_FILE_REPORT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_FILE_REPORTS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT