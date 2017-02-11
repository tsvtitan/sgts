/* Создание просмотра отчета напряжений напряженно-деформированного состояния вместе с гидрометеорологией */

CREATE OR REPLACE VIEW S_NDS_REPOTR_EXERTION_GMO
AS 
SELECT JO.CYCLE_ID,
       JO.CYCLE_NUM,
       JO.MEASURE_TYPE_ID,
       TO_NUMBER (JO.POINT_NAME) AS POINT_NAME,
       JO.CONVERTER_NAME,
       CP.LOCATE,
       JO.OBJECT_PATHS,
       JO.COORDINATE_Z,
       JO.DATE_OBSERVATION,
       JO.VALUE_EXERTION,
       JO.VALUE_EXERTION_ACCOUNT,
       JO.TYPE,
       JO.VALUE_TEMPERATURE,
       GMO.UVB,
       GMO.T_AIR
  FROM S_NDS_REPOTR_EXERTION JO,
       S_GMO_JOURNAL_OBSERVATIONS GMO,
       (SELECT   CONVERTER_ID,
                 MIN (DECODE (PARAM_ID, 60008, VALUE, NULL)) AS LOCATE,
                 TO_NUMBER (REPLACE (MIN (DECODE (PARAM_ID, 60010, VALUE, NULL)), ',', '.'), 'FM99999.9999') AS R0
            FROM (SELECT CM.CONVERTER_ID,
                         CM.PARAM_ID,
                         CP.VALUE
                    FROM CONVERTER_PASSPORTS CP,
                         COMPONENTS CM
                   WHERE CP.COMPONENT_ID = CM.COMPONENT_ID
                     AND CM.PARAM_ID IN (60008, 60010))
        GROUP BY CONVERTER_ID) CP
 WHERE CP.CONVERTER_ID = JO.POINT_ID
   AND JO.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)
   AND R0 <> 0

--

/* Фиксация изменений */

COMMIT


