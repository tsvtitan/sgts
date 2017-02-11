/* Создание просмотра отчета напряжений 8 ГА напряженной-деформированнного состояния */

CREATE OR REPLACE VIEW S_NDS_REPOTR_EXER_8GA
AS
SELECT JO.CYCLE_ID,
       JO.CYCLE_NUM,
       JO.DATE_OBSERVATION,
       JO.COORDINATE_Z,
       JO.VALUE_EXERTION,
       JO.VALUE_STATER_CARRIE,
       JO.POINT_NAME,
       JO.TYPE,
       JO.CONVERTER_NAME,
       JO.OBJECT_PATHS,
       JO.POINT_ID
  FROM S_NDS_JOURNAL_OBSERVATIONS JO
 WHERE JO.MEASURE_TYPE_ID = 60002
   AND NOT JO.VALUE_EXERTION IS NULL

--

/* Фиксация изменений */

COMMIT


