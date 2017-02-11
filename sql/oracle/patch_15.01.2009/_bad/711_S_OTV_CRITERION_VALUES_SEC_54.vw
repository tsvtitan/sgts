/* CREATE OR REPLACE VIEW S_OTV_CRITERION_VALUES_SEC_54 */

CREATE OR REPLACE VIEW S_OTV_CRITERION_VALUES_SEC_54
AS 
SELECT   'Абсолютные горизонтальные перемещения гребня в сторону НБ. Система прямых и обратных отвесов секции №54' PARAM_NAME,
         40 K1,
         44 K2,
         'ПО-3 Плотина\Тело плотины\Секция 54\Столб 2\Отм. 248.00' POINT_NAME,
         JO.CYCLE_NUM,
         JO.DATE_OBSERVATION,
         JO.OFFSET_X_WITH_VERTIKAL VALUE,
         CASE
            WHEN JO.OFFSET_X_WITH_VERTIKAL < 40
               THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
            ELSE CASE
            WHEN JO.OFFSET_X_WITH_VERTIKAL < 44
               THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
            ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
         END
         END MESSAGE
    FROM S_OTV_JOURNAL_OBSERVATIONS_O1 JO
   WHERE JO.POINT_ID = 6289
     AND JO.OFFSET_X_WITH_VERTIKAL IS NOT NULL
ORDER BY JO.DATE_OBSERVATION

--

/* Фиксация изменений */

COMMIT


