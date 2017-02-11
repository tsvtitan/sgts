/* Создание процедуры обновления срезов полевого журнала Веерных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O1');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Веерных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание процедуры обновления срезов полевого журнала Створных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_FIELDS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O2');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Створных пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание процедуры обновления срезов полевого журнала Береговых пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_FIELDS_3
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_FIELDS_O3');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Береговых пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS_3
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_PZM_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Создание процедуры обновления срезов полевого журнала Всех пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_FIELDS
AS
BEGIN
  R_PZM_JOURNAL_FIELDS_1;
  R_PZM_JOURNAL_FIELDS_2;
  R_PZM_JOURNAL_FIELDS_3;
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Всех пьезометров */

CREATE OR REPLACE PROCEDURE R_PZM_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_PZM_JOURNAL_OBSERVATIONS_1;
  R_PZM_JOURNAL_OBSERVATIONS_2;
  R_PZM_JOURNAL_OBSERVATIONS_3;
END;

--

/* Фиксация изменений БД */

COMMIT