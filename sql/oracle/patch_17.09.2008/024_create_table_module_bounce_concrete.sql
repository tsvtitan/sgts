/* Создание таблицы модуля упругости бетона */

CREATE TABLE MODULE_BOUNCE_CONCRETE
(
  DNI      FLOAT,
  A37_I    FLOAT,
  A37_VII  FLOAT,
  A55_I    FLOAT,
  A55_VII  FLOAT,
  A22_IV   FLOAT,
  VODOVOD  FLOAT,
  PLITA    FLOAT
 )

--

/* Фиксация изменений БД */

COMMIT