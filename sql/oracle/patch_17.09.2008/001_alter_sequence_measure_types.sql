/* Удаление последовательности для таблицы видов измерений */

DROP SEQUENCE SEQ_MEASURE_TYPES

--

/* Создание последовательности для таблицы видов измерений */

CREATE SEQUENCE SEQ_MEASURE_TYPES 
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
