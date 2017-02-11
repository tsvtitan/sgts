/* Создания тип объекта для хранения идентификаторов измерительных точек */

CREATE TYPE POINT_OBJECT 
AS OBJECT
(
  POINT_ID INTEGER
)

--

/* Создание типа таблицы для хранения идентификаторов измерительных точек */

CREATE OR REPLACE TYPE POINT_TABLE 
AS TABLE OF POINT_OBJECT

--

/* Фиксация изменений */

COMMIT