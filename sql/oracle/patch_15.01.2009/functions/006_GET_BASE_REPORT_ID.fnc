/* Создание фунции генерации идентификатора для таблицы базовых отчетов */

CREATE OR REPLACE FUNCTION GET_BASE_REPORT_ID RETURN INTEGER IS
  ID INTEGER;
BEGIN
  SELECT SEQ_BASE_REPORTS.NEXTVAL INTO ID FROM DUAL;
  RETURN ID;
END;

--

/* Фиксация изменений */

COMMIT
