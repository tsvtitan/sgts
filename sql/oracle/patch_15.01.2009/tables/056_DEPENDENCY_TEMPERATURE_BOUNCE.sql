/* Создание таблицы зависимости температуры от упругости */

CREATE TABLE DEPENDENCY_TEMPERATURE_BOUNCE
(
  TEMPERATURE FLOAT,
  BOUNCE FLOAT,
  PRIMARY KEY(TEMPERATURE)
)  

--

/* Фиксация изменений БД */

COMMIT