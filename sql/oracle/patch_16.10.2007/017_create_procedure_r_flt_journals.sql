/* Создание процедуры обновления срезов полевого журнала Через бетон НГ плотины */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O1');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Через бетон НГ плотины */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание процедуры обновления срезов полевого журнала Через швы НГ плотины */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O2');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Через швы НГ плотины */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание процедуры обновления срезов полевого журнала Дренажа осн. плотины 1 ряда */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_3
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O3');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Дренажа осн. плотины 1 ряда */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_3
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O3');
END;

--

/* Создание процедуры обновления срезов полевого журнала Через агрегатные швы */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_4
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O4');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Через агрегатные швы */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_4
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O4');
END;

--

/* Создание процедуры обновления срезов полевого журнала Автоном. источн. и водосливы */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_5
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O5');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Автоном. источн. и водосливы */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_5
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O5');
END;

--

/* Создание процедуры обновления срезов полевого журнала Дренажа осн. плотины 2 ряда */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS_6
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_FIELDS_O6');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Дренажа осн. плотины 2 ряда */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS_6
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_FLT_JOURNAL_OBSERVATIONS_O6');
END;

--

/* Создание процедуры обновления срезов полевого журнала Фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_FIELDS
AS
BEGIN
  R_FLT_JOURNAL_FIELDS_1;
  R_FLT_JOURNAL_FIELDS_2;
  R_FLT_JOURNAL_FIELDS_3;
  R_FLT_JOURNAL_FIELDS_4;
  R_FLT_JOURNAL_FIELDS_5;
  R_FLT_JOURNAL_FIELDS_6;
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Фильтрации */

CREATE OR REPLACE PROCEDURE R_FLT_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_FLT_JOURNAL_OBSERVATIONS_1;
  R_FLT_JOURNAL_OBSERVATIONS_2;
  R_FLT_JOURNAL_OBSERVATIONS_3;
  R_FLT_JOURNAL_OBSERVATIONS_4;
  R_FLT_JOURNAL_OBSERVATIONS_5;
  R_FLT_JOURNAL_OBSERVATIONS_6;
END;

--

/* Фиксация изменений БД */

COMMIT