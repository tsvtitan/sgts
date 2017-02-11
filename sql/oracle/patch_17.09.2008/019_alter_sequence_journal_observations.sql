/* Удаление последовательности для таблицы журнала наблюдений */

DROP SEQUENCE SEQ_JOURNAL_OBSERVATIONS

--

/* Создание последовательности для таблицы журнала наблюдений */

CREATE SEQUENCE SEQ_JOURNAL_OBSERVATIONS
INCREMENT BY 1 
START WITH 30000000
MINVALUE 30000000
MAXVALUE 1.0E28 
NOCYCLE 
CACHE 20 
NOORDER

--

/* Фиксация изменений БД */

COMMIT
