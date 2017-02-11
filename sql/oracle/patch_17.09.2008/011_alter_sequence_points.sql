/* Удаление последовательности для таблицы точек */

DROP SEQUENCE SEQ_POINTS

--

/* Создание последовательности для таблицы точек */

CREATE SEQUENCE SEQ_POINTS 
INCREMENT BY 1 
START WITH 170000
MINVALUE 170000
MAXVALUE 1.0E28 
NOCYCLE 
CACHE 20 
NOORDER

--

/* Фиксация изменений БД */

COMMIT
