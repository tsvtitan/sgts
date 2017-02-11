/* Очистка таблицы прав */

BEGIN
  DELETE FROM PERMISSIONS;
  COMMIT;
END;

