/* Создание просмотра преобразователей видов измерений отвесов */

CREATE OR REPLACE VIEW S_MEASURE_TYPE_CONVERTERS_OTV
AS 
SELECT DISTINCT CONVERTER_NAME,
                MEASURE_TYPE_ID,
                MEASURE_TYPE_NAME,
                GRUPPA,
                SEK,
                STOLB,
                OBJECT_PATHS,
                VERTIKAL
           FROM S_OTV_ARCHIVE_PASSPORTS_TITLE
          WHERE MEASURE_TYPE_ID = 4621
             OR MEASURE_TYPE_ID = 4622
       ORDER BY CONVERTER_NAME

--

/* Фиксация изменений */

COMMIT


