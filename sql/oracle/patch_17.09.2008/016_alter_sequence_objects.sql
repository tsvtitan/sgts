/* Удаление последовательности для таблицы объектов */

DROP SEQUENCE SEQ_OBJECTS

--

/* Создание последовательности для таблицы объектов */

CREATE SEQUENCE SEQ_OBJECTS
INCREMENT BY 1 
START WITH 120000
MINVALUE 120000
MAXVALUE 1.0E28 
NOCYCLE 
CACHE 20 
NOORDER

--

/* Фиксация изменений БД */

COMMIT
