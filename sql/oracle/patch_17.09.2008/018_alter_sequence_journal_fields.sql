/* Удаление последовательности для таблицы полевого журнала */

DROP SEQUENCE SEQ_JOURNAL_FIELDS

--

/* Создание последовательности для таблицы полевого журнала */

CREATE SEQUENCE SEQ_JOURNAL_FIELDS
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
