/* Создание таблицы зависимости УВБ от объема водохранилища */

CREATE TABLE DEPENDENCY_UVB_VOLUME
(
  UVB FLOAT,
  VOLUME FLOAT,
  PRIMARY KEY(UVB)
)  

--

/* Фиксация изменений БД */

COMMIT