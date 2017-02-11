/* Создание просмотра отчета BETON химализа */

CREATE OR REPLACE VIEW S_HMZ_REPORT_BETON
AS 
SELECT   JO.CONVERTER_NAME,
         P.COORDINATE_Z,
         JO.DATE_OBSERVATION,
         JO.CYCLE_NUM,
         JO.PH,
         JO.CO2SV,
         JO.CO3_2,
         JO.CO2AGG,
         JO.ALKALI,
         JO.ACERBITY,
         JO.CA,
         JO.MG,
         JO.CL,
         JO.SO4_2,
         JO.HCO3,
         JO.NA_K,
         JO.AGGRESSIV
    FROM POINT_PASSPORTS PP,
         S_HMZ_JOURNAL_OBSERVATIONS JO,
         POINTS P
   WHERE (PP.POINT_ID >= 4001)
     AND (PP.POINT_ID <= 4104)
     AND (PP.DESCRIPTION = 'Местоположение точки: Дренажи бетона и швы')
     AND (PP.POINT_ID = JO.POINT_ID)
     AND (P.POINT_ID = JO.POINT_ID)
ORDER BY DATE_OBSERVATION,
         COORDINATE_Z

--

/* Фиксация изменений */

COMMIT


