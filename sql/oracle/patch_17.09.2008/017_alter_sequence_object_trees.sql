/* Удаление последовательности для таблицы дерева объектов */

DROP SEQUENCE SEQ_OBJECT_TREES

--

/* Создание последовательности для таблицы дерева объектов */

CREATE SEQUENCE SEQ_OBJECT_TREES
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
