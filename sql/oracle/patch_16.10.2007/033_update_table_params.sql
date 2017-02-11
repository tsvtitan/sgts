/* Изменение параметра вид осадков */

BEGIN
  UPDATE PARAMS
     SET DETERMINATION='[Список]
дождь=1
снег=2
снег/дождь=3
без осадков=4'
  WHERE PARAM_ID=2908;
  COMMIT;
END;

