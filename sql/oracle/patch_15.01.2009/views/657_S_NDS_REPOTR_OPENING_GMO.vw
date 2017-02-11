/* Создание просмотра отчета раскрытия напряженно-деформированного состояния виесте с гидрометеорологией */

CREATE OR REPLACE VIEW S_NDS_REPOTR_OPENING_GMO
AS 
SELECT RO.CYCLE_ID,
       RO.CYCLE_NUM,
       RO.MEASURE_TYPE_ID,
       TO_NUMBER (RO.POINT_NAME) AS POINT_NAME,
       RO.CONVERTER_NAME,
       CP.TYPE,
       RO.OBJECT_PATHS,
       RO.COORDINATE_Z,
       RO.DATE_OBSERVATION,
       CP.MARK,
       RO.VALUE_OPENING,
       GMO.UVB,
       GMO.T_AIR
  FROM S_NDS_REPOTR_OPENING RO,
       S_GMO_JOURNAL_OBSERVATIONS GMO,
       (SELECT   CONVERTER_ID,
                 MIN (DECODE (PARAM_ID, 60030, VALUE, NULL)) AS TYPE,
                 MIN (DECODE (PARAM_ID, 60026, VALUE, NULL)) AS MARK
            FROM (SELECT CM.CONVERTER_ID,
                         CM.PARAM_ID,
                         CP.VALUE
                    FROM CONVERTER_PASSPORTS CP,
                         COMPONENTS CM
                   WHERE CP.COMPONENT_ID = CM.COMPONENT_ID
                     AND CM.PARAM_ID IN (60030, 60026))
        GROUP BY CONVERTER_ID) CP
 WHERE CP.CONVERTER_ID = RO.POINT_ID
   AND RO.DATE_OBSERVATION = GMO.DATE_OBSERVATION(+)

--

/* Фиксация изменений */

COMMIT


