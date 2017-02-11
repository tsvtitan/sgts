/* Создание просмотра Химанализа с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_HMZ_JOURNAL_FIELDS_GMO
AS
  SELECT HMZ.*,
         GMO.UVB, 
		 GMO.UNB,
		 GMO.T_AIR,
		 GMO.T_WATER,
		 GMO.RAIN_DAY,
		 GMO.PREC,
		 GMO.PREC_NAME,
		 GMO.UNSET,
		 GMO.INFLUX,
		 GMO.V_VAULT
    FROM S_HMZ_JOURNAL_FIELDS HMZ, S_GMO_JOURNAL_FIELDS GMO
   WHERE HMZ.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+) 

--

/* Фиксация изменений БД */

COMMIT
