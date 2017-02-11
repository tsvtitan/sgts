/* Создание просмотра отчета 8 ГА напряженно-деформированного состояния */

CREATE OR REPLACE VIEW S_NDS_REPOTR_8GA
AS 
SELECT JO.CYCLE_ID,
       JO.CYCLE_NUM,
       JO.DATE_OBSERVATION,
       JO.COORDINATE_Z,
       JO.VALUE_TEMPERATURE,
       JO.VALUE_EXERTION,
       JO.VALUE_STATER_CARRIE,
       JO.POINT_NAME,
       JO.UVB,
       JO.T_AIR,
       JO.TYPE,
       JO.CONVERTER_NAME,
       CP.CORNER,
       CP.CUTSET,
       CP.LOCATE
  FROM S_NDS_JOURNAL_OBSERVATIONS_GMO JO,
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
 WHERE JO.MEASURE_TYPE_ID = 60002
   AND CP.CONVERTER_ID = JO.POINT_ID

--

/* Фиксация изменений */

COMMIT


