/* Удаление последовательности для таблицы параметров */

DROP SEQUENCE SEQ_PARAMS

--

/* Создание последовательности для таблицы параметров */

CREATE SEQUENCE SEQ_PARAMS 
INCREMENT BY 1 
START WITH 60000
MINVALUE 60000
MAXVALUE 1.0E28 
NOCYCLE 
CACHE 20 
NOORDER

--

/* Фиксация изменений БД */

COMMIT
