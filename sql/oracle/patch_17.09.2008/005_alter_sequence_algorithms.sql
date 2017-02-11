/* Удаление последовательности для таблицы алгоритмов */

DROP SEQUENCE SEQ_ALGORITHMS

--

/* Создание последовательности для таблицы алгоритмов */

CREATE SEQUENCE SEQ_ALGORITHMS 
INCREMENT BY 1 
START WITH 40000
MINVALUE 40000
MAXVALUE 1.0E28 
NOCYCLE 
CACHE 20 
NOORDER

--

/* Фиксация изменений БД */

COMMIT
