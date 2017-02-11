/* Удаление данных из журнала наблюдений по Береговым пьезометрам */

DECLARE
  CNT INTEGER;
  MAX_ROW INTEGER;
  AMEASURE_TYPE_ID INTEGER;
BEGIN
  AMEASURE_TYPE_ID:=2563;
  MAX_ROW:=10000;
  SELECT ROUND(COUNT(*)/MAX_ROW)+1 INTO CNT FROM JOURNAL_OBSERVATIONS
   WHERE MEASURE_TYPE_ID=AMEASURE_TYPE_ID;
  FOR I IN 1..CNT LOOP
    DELETE FROM JOURNAL_OBSERVATIONS
     WHERE JOURNAL_OBSERVATION_ID IN (SELECT JOURNAL_OBSERVATION_ID 
                                        FROM (SELECT ROWNUM AS RN, JOURNAL_OBSERVATION_ID 
                                                FROM JOURNAL_OBSERVATIONS
		                                       WHERE MEASURE_TYPE_ID=AMEASURE_TYPE_ID)
                                       WHERE RN<=MAX_ROW);
    COMMIT;									   
  END LOOP;									    
END;

--

/* Пересчет журнала наблюдений по Береговым пьезометрам */

BEGIN
  CONFIRM_ALL(2563,NULL,2524);
END;

--

/* Генерация срезов по Береговым пьезометрам */

BEGIN
  R_PZM_JOURNALS_3;
END;

--

/* Пересчет журнала наблюдений по Фильтрации межагрегатные швы */ 

BEGIN
  CONFIRM_ALL(2584,NULL,2524);
END;

--

/* Генерация срезов по Фильтрации межагрегатные швы */

BEGIN
  R_FLT_JOURNALS_4;
END;

--

/* Фиксация изменений */

COMMIT
