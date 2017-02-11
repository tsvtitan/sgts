/* CREATE OR REPLACE VIEW S_SL_CRITERION_VALUES */

CREATE OR REPLACE VIEW S_SL_CRITERION_VALUES
AS
   SELECT   'Раскрытие межсекционных швов' AS param_name, 3 AS k1, 3.5 AS k2,
               converter_name
            || ' '
            || object_paths
            || '\Отм. '
            || coordinate_z AS point_name,
            cycle_num, date_observation, opening AS VALUE,
            CASE
               WHEN opening < 3
                  THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
               ELSE CASE
               WHEN opening < 3.5
                  THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
               ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
            END
            END MESSAGE
       FROM s_sl1_journal_observations_1
      WHERE opening IS NOT NULL
   UNION
   SELECT   'Раскрытие межсекционных швов' AS param_name, 3 AS k1, 3.5 AS k2,
               converter_name
            || ' '
            || object_paths
            || '\Отм. '
            || coordinate_z AS point_name,
            cycle_num, date_observation, opening_y AS VALUE,
            CASE
               WHEN opening_y < 3
                  THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
               ELSE CASE
               WHEN opening_y < 3.5
                  THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
               ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
            END
            END MESSAGE
       FROM s_slw_journal_observations_1
      WHERE opening_y IS NOT NULL
   UNION
   SELECT   'Раскрытие межсекционных швов' AS param_name, 3 AS k1, 3.5 AS k2,
               converter_name
            || ' '
            || object_paths
            || '\Отм. '
            || coordinate_z AS point_name,
            cycle_num, date_observation, opening_y AS VALUE,
            CASE
               WHEN opening_y < 3
                  THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
               ELSE CASE
               WHEN opening_y < 3.5
                  THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
               ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
            END
            END MESSAGE
       FROM s_slf_journal_observations_1
      WHERE opening_y IS NOT NULL
   ORDER BY date_observation

--

/* Фиксация изменений */

COMMIT
