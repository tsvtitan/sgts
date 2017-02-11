/* Создание просмотра отчетов по циклам */

CREATE OR REPLACE VIEW S_CYCLES_REPORTS
AS 
SELECT   CYCLE_NUM,
         CYCLE_MONTH + 1 CYCLE_MONTH,
         CYCLE_YEAR,
         TO_DATE ('01.' || TO_CHAR (CYCLE_MONTH + 1) || '.' || TO_CHAR (CYCLE_YEAR), 'DD.MM.YYYY') DATE_BEGIN,
         CASE
            WHEN (CYCLE_MONTH + 1) IN (1, 3, 5, 7, 8, 10, 12)
               THEN TO_DATE ('31.' || TO_CHAR (CYCLE_MONTH + 1) || '.' || TO_CHAR (CYCLE_YEAR), 'DD.MM.YYYY')
            WHEN (CYCLE_MONTH + 1) IN (4, 6, 9, 11)
               THEN TO_DATE ('30.' || TO_CHAR (CYCLE_MONTH + 1) || '.' || TO_CHAR (CYCLE_YEAR), 'DD.MM.YYYY')
            WHEN (CYCLE_MONTH + 1 = 2)
            AND (CYCLE_YEAR IN
                    (1964,
                     1968,
                     1972,
                     1976,
                     1980,
                     1984,
                     1988,
                     1992,
                     1996,
                     2000,
                     2004,
                     2008,
                     2012,
                     2016,
                     2020,
                     2024,
                     2028,
                     2032,
                     2036,
                     2040,
                     2044,
                     2048
                    )
                )
               THEN TO_DATE ('29.' || TO_CHAR (CYCLE_MONTH + 1) || '.' || TO_CHAR (CYCLE_YEAR), 'DD.MM.YYYY')
            WHEN (CYCLE_MONTH + 1 = 2)
            AND (CYCLE_YEAR NOT IN
                    (1964,
                     1968,
                     1972,
                     1976,
                     1980,
                     1984,
                     1988,
                     1992,
                     1996,
                     2000,
                     2004,
                     2008,
                     2012,
                     2016,
                     2020,
                     2024,
                     2028,
                     2032,
                     2036,
                     2040,
                     2044,
                     2048
                    )
                )
               THEN TO_DATE ('28.' || TO_CHAR (CYCLE_MONTH + 1) || '.' || TO_CHAR (CYCLE_YEAR), 'DD.MM.YYYY')
         END DATE_END
    FROM CYCLES
ORDER BY CYCLE_ID

--

/* Фиксация изменений */

COMMIT


