/* Создание просмотра отчета напряжений 8 ГА напряженной-деформированнного состояния вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_NDS_REPOTR_EXER_8GA_GMO
AS 
SELECT R8.CYCLE_ID,
       R8.CYCLE_NUM,
       R8.DATE_OBSERVATION,
       R8.COORDINATE_Z,
       R8.VALUE_EXERTION,
       R8.VALUE_STATER_CARRIE,
       R8.POINT_NAME,
       GMO.UVB,
       GMO.T_AIR,
       R8.TYPE,
       R8.CONVERTER_NAME,
       CP.CORNER,
       CP.CUTSET,
       CP.LOCATE,
       R8.OBJECT_PATHS
  FROM S_NDS_REPOTR_EXER_8GA R8,
       S_GMO_JOURNAL_OBSERVATIONS GMO,
       (SELECT   CONVERTER_ID,
                 MIN (DECODE (PARAM_ID, 60023, VALUE, NULL)) AS CUTSET,
                 MIN (DECODE (PARAM_ID, 60008, VALUE, NULL)) AS LOCATE,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60024, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS CORNER
            FROM (SELECT CM.CONVERTER_ID,
                         CM.PARAM_ID,
                         CP.VALUE
                    FROM CONVERTER_PASSPORTS CP,
                         COMPONENTS CM
                   WHERE CP.COMPONENT_ID = CM.COMPONENT_ID
                     AND CM.PARAM_ID IN (60024, 60023, 60008))
        GROUP BY CONVERTER_ID) CP
 WHERE CP.CONVERTER_ID = R8.POINT_ID
   AND R8.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT


