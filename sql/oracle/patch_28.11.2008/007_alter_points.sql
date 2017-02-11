/* Добавление новой колонки в таблицу точек */

ALTER TABLE POINTS
ADD NAME2 INTEGER

--

/* Установка значений наименования */

BEGIN
  UPDATE POINTS
  SET NAME2=TO_NUMBER(NAME);
END;

--

/* Удаление колонки наименование */

ALTER TABLE POINTS
DROP COLUMN NAME

--

/* Переименование колонки */

ALTER TABLE POINTS
RENAME COLUMN NAME2 TO NAME

--

/* Фиксация изменений БД */

COMMIT