/* Создание процедуры обновления среза полевого журнала по Гидрометеорологии */

CREATE OR REPLACE PROCEDURE R_GMO_JOURNAL_FIELDS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_FIELDS_OLD');
END;

--

/* Создание процедуры обновления среза журнала наблюдений по Гидрометеорологии */

CREATE OR REPLACE PROCEDURE R_GMO_JOURNAL_OBSERVATIONS
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_GMO_JOURNAL_OBSERVATIONS_OLD');
END;

--

/* Фиксация изменений БД */

COMMIT