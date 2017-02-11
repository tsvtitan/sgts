/* Создание процедуры обновления срезов полевого журнала Отвесов в теле плотины */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_OTV_JOURNAL_FIELDS_O1');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Отвесов в теле плотины */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_OBSERVATIONS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_OTV_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание процедуры обновления срезов полевого журнала Отвесов в корпусе ЗРУ */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_FIELDS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_OTV_JOURNAL_FIELDS_O2');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Отвесов в корпусе ЗРУ */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_OBSERVATIONS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_OTV_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание процедуры обновления срезов полевого журнала Всех отвесов */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_FIELDS
AS
BEGIN
  R_OTV_JOURNAL_FIELDS_1;
  R_OTV_JOURNAL_FIELDS_2;
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Всех отвесов */

CREATE OR REPLACE PROCEDURE R_OTV_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_OTV_JOURNAL_OBSERVATIONS_1;
  R_OTV_JOURNAL_OBSERVATIONS_2;
END;

--

/* Фиксация изменений БД */

COMMIT