/* Создание просмотра Напольных щелемеров с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_SLF_JOURNAL_FIELDS_GMO
AS
  SELECT SLF.*,
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
    FROM S_SLF_JOURNAL_FIELDS SLF, S_GMO_JOURNAL_FIELDS GMO
   WHERE SLF.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+)	 

--

/* Фиксация изменений БД */

COMMIT
