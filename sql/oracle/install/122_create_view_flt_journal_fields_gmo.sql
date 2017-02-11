/* Создание просмотра Фильтрации с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_FLT_JOURNAL_FIELDS_GMO
AS
  SELECT FLT.*,
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
    FROM S_FLT_JOURNAL_FIELDS FLT, S_GMO_JOURNAL_FIELDS GMO
   WHERE FLT.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+)	 

--

/* Фиксация изменений БД */

COMMIT
