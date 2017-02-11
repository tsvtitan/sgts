/* CREATE OR REPLACE VIEW S_FLT_CRITERION_VALUES_SHVI */

CREATE OR REPLACE VIEW S_FLT_CRITERION_VALUES_SHVI
AS
SELECT   'Фильтрационный расход. Межсекционные швы' AS PARAM_NAME,
         7.5 AS K1,
         9 AS K2,
         'Межсекционные швы' AS POINT_NAME,
         CYCLE_NUM,
         CASE
            WHEN LENGTH (TO_CHAR (MOD (CYCLE_NUM, 12))) = 1
               THEN CASE
                      WHEN TO_CHAR (MOD (CYCLE_NUM, 12)) = '0'
                         THEN TO_DATE ('01.12.' || TO_CHAR (FLOOR (CYCLE_NUM / 12) + 1961), 'DD.MM.YYYY')
                      ELSE TO_DATE ('01.0' || TO_CHAR (MOD (CYCLE_NUM, 12)) || '.' || TO_CHAR (FLOOR (CYCLE_NUM / 12) + 1962), 'DD.MM.YYYY')
                   END
            ELSE TO_DATE ('01.' || TO_CHAR (MOD (CYCLE_NUM, 12)) || '.' || TO_CHAR (FLOOR (CYCLE_NUM / 12) + 1962), 'DD.MM.YYYY')
         END DATE_OBSERVATION,
         EXPENSE_OB AS VALUE,
         CASE
            WHEN EXPENSE_OB < 7.5
               THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
            ELSE CASE
            WHEN EXPENSE_OB < 9
               THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
            ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
         END
         END MESSAGE
    FROM S_FLT_SUM_EXPENSE_SHVI_OB
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


