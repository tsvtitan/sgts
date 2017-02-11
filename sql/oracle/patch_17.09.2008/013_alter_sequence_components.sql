/* Удаление последовательности для таблицы компонент */

DROP SEQUENCE SEQ_COMPONENTS

--

/* Создание последовательности для таблицы компонент */

CREATE SEQUENCE SEQ_COMPONENTS
INCREMENT BY 1 
START WITH 600000
MINVALUE 600000
MAXVALUE 1.0E28 
NOCYCLE 
CACHE 20 
NOORDER

--

/* Фиксация изменений БД */

COMMIT
