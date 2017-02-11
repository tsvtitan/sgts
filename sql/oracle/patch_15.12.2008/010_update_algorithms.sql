/* Изменение процедуры алгоритма расчета осадки гидронивелиров */

BEGIN
  UPDATE ALGORITHMS
  SET PROC_NAME='CONFIRM_HND_DRAFT_BEGIN'
  WHERE OBJECT_ID=30047;
END;
        
--

/* Фиксация изменений БД */

COMMIT