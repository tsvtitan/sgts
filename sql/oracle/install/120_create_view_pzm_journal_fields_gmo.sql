/* Создание просмотра Пьезометров с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_PZM_JOURNAL_FIELDS_GMO
AS
  SELECT PZM.*,
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
    FROM S_PZM_JOURNAL_FIELDS PZM, S_GMO_JOURNAL_FIELDS GMO
   WHERE PZM.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+)	 

--

/* Фиксация изменений БД */

COMMIT
