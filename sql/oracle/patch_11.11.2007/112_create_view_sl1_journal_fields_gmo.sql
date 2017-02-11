/* Создание просмотра Одноосных щелемеров с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_SL1_JOURNAL_FIELDS_GMO
AS
  SELECT SL1.*,
         GMO.UVB, 
		 GMO.UNB,
		 GMO.T_AIR,
		 GMO.T_WATER AS GMO_T_WATER,
		 GMO.RAIN_DAY,
		 GMO.PREC,
		 GMO.PREC_NAME,
		 GMO.UNSET,
		 GMO.INFLUX,
		 GMO.V_VAULT
    FROM S_SL1_JOURNAL_FIELDS SL1, S_GMO_JOURNAL_FIELDS GMO
   WHERE SL1.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+)	 

--

/* Фиксация изменений БД */

COMMIT
