/* Создание просмотра Влажности с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_TVL_JOURNAL_FIELDS_GMO
AS
  SELECT TVL.*,
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
    FROM S_TVL_JOURNAL_FIELDS TVL, S_GMO_JOURNAL_FIELDS GMO
   WHERE TVL.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+) 

--

/* Фиксация изменений БД */

COMMIT
