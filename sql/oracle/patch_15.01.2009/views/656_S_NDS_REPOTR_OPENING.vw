/* Создание просмотра отчета раскрытия напряженно-деформированного состояния */

CREATE OR REPLACE VIEW S_NDS_REPOTR_OPENING
AS 
SELECT JO.CYCLE_ID,
       JO.CYCLE_NUM,
       JO.MEASURE_TYPE_ID,
       TO_NUMBER (JO.POINT_NAME) AS POINT_NAME,
       JO.CONVERTER_NAME,
       JO.OBJECT_PATHS,
       JO.COORDINATE_Z,
       JO.DATE_OBSERVATION,
       JO.VALUE_OPENING,
       JO.POINT_ID
  FROM S_NDS_JOURNAL_OBSERVATIONS JO
 WHERE NOT JO.VALUE_OPENING IS NULL


--

/* Фиксация изменений */

COMMIT


