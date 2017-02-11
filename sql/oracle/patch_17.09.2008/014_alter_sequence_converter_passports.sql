/* Удаление последовательности для таблицы паспортов преобразователей */

DROP SEQUENCE SEQ_CONVERTER_PASSPORTS

--

/* Создание последовательности для таблицы паспортов преобразователей */

CREATE SEQUENCE SEQ_CONVERTER_PASSPORTS
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
