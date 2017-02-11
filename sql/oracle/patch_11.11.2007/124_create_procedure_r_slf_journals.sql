/* Создание процедуры обновления срезов полевого журнала Напольных щелемеров на плотине */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_FIELDS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLF_JOURNAL_FIELDS_O1');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Напольных щелемеров на плотине */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_OBSERVATIONS_1
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLF_JOURNAL_OBSERVATIONS_O1');
END;

--

/* Создание процедуры обновления срезов полевого журнала Напольных щелемеров на здании ГЭС */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_FIELDS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLF_JOURNAL_FIELDS_O2');
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Напольных щелемеров на здании ГЭС */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_OBSERVATIONS_2
AS
BEGIN
  DBMS_REFRESH.REFRESH('S_SLF_JOURNAL_OBSERVATIONS_O2');
END;

--

/* Создание процедуры обновления срезов полевого журнала Напольных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_FIELDS
AS
BEGIN
  R_SLF_JOURNAL_FIELDS_1;
  R_SLF_JOURNAL_FIELDS_2;
END;

--

/* Создание процедуры обновления срезов журнала наблюдений Напольных щелемеров */

CREATE OR REPLACE PROCEDURE R_SLF_JOURNAL_OBSERVATIONS
AS
BEGIN
  R_SLF_JOURNAL_OBSERVATIONS_1;
  R_SLF_JOURNAL_OBSERVATIONS_2;
END;

--

/* Фиксация изменений БД */

COMMIT