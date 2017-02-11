/* Удаление последовательности для таблицы маршрутов */

DROP SEQUENCE SEQ_ROUTES

--

/* Создание последовательности для таблицы маршрутов */

CREATE SEQUENCE SEQ_ROUTES 
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
