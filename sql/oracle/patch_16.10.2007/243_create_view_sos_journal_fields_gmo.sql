/* Создание просмотра Струнно-оптического створа с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_SOS_JOURNAL_FIELDS_GMO
AS
  SELECT SOS.*,
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
    FROM S_SOS_JOURNAL_FIELDS SOS, S_GMO_JOURNAL_FIELDS GMO
   WHERE SOS.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+) 

--

/* Фиксация изменений БД */

COMMIT
