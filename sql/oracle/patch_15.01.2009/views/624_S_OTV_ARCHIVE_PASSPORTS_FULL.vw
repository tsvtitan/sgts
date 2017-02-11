/* Создание просмотра полного архива паспортов отвесов */

CREATE OR REPLACE VIEW S_OTV_ARCHIVE_PASSPORTS_FULL
AS 
SELECT   C1.MEASURE_TYPE_ID,
         C1.POINT_ID,
         C1.POINT_NAME,
         C1.CONVERTER_NAME,
         C1.DATE_ENTER,
         C1.SEK,
         C1.STOLB,
         C1.OBJECT_PATHS,
         C1.OTM_ZAC,
         C1.OTM_STOL,
         C1.GRUPPA,
         C1.VERTIKAL,
         C1.POL_STOL,
         C1.DATE_BEGIN,
         C1.DATE_END,
         C1.PRIM,
         C1.PRIB,
         C1.OT_X_DO,
         C1.SM_X_DO,
         C1.OT_Y_DO,
         C1.SM_Y_DO,
         C2.DATE_BEGIN AS DATE_BEGIN_2,
         C2.OT_X_POSLE,
         C2.SM_X_POSLE,
         C2.OT_Y_POSLE,
         C2.SM_Y_POSLE
    FROM S_OTV_ARCHIVE_PASSPORTS C1,
         S_OTV_ARCHIVE_PASSPORTS_2 C2
   WHERE C1.POINT_ID = C2.POINT_ID
     AND C1.PRIM = C2.PRIM
ORDER BY C1.POINT_NAME,
         C1.DATE_BEGIN

--

/* Фиксация изменений */

COMMIT


