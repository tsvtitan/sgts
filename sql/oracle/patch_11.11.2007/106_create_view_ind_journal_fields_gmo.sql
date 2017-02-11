/* Создание просмотра Индикаторов прогиба с Гидрометеорологией в полевом журнале */

CREATE OR REPLACE VIEW S_IND_JOURNAL_FIELDS_GMO
AS
  SELECT IND.*,
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
    FROM S_IND_JOURNAL_FIELDS IND, S_GMO_JOURNAL_FIELDS GMO
   WHERE IND.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+) 

--

/* Фиксация изменений БД */

COMMIT
