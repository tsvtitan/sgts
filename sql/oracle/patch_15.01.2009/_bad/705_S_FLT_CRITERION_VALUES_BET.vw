/* CREATE OR REPLACE VIEW S_FLT_CRITERION_VALUES_BET */

CREATE OR REPLACE VIEW S_FLT_CRITERION_VALUES_BET
AS
SELECT   'Фильтрационный расход. Бетон напорной грани' AS PARAM_NAME,
         2.5 AS K1,
         3 AS K2,
         'Бетон напорной грани' AS POINT_NAME,
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
            WHEN EXPENSE_OB < 2.5
               THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
            ELSE CASE
            WHEN EXPENSE_OB < 3
               THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
            ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
         END
         END MESSAGE
    FROM S_FLT_SUM_EXPENSE_BET_OB
ORDER BY CYCLE_NUM

--

/* Фиксация изменений */

COMMIT


