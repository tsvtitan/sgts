/* CREATE OR REPLACE VIEW S_OTV_CRITERION_VALUES_SEC_22 */

CREATE OR REPLACE VIEW S_OTV_CRITERION_VALUES_SEC_22
AS 
SELECT   'Абсолютные горизонтальные перемещения гребня в сторону НБ. Система прямых и обратных отвесов секции №22' PARAM_NAME,
         38 K1,
         43 K2,
         'ПО-1 Плотина\Тело плотины\Секция 22\Столб 1\Отм. 247.84' POINT_NAME,
         JO.CYCLE_NUM,
         JO.DATE_OBSERVATION,
         JO.OFFSET_X_WITH_VERTIKAL VALUE,
         CASE
            WHEN JO.OFFSET_X_WITH_VERTIKAL < 38
               THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
            ELSE CASE
            WHEN JO.OFFSET_X_WITH_VERTIKAL < 43
               THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
            ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
         END
         END MESSAGE
    FROM S_OTV_JOURNAL_OBSERVATIONS_O1 JO
   WHERE JO.POINT_ID = 6288
     AND JO.OFFSET_X_WITH_VERTIKAL IS NOT NULL
ORDER BY JO.DATE_OBSERVATION

--

/* Фиксация изменений */

COMMIT


