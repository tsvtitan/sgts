/* CREATE OR REPLACE VIEW S_PZM_CRITERION_VALUES_4_3 */

CREATE OR REPLACE VIEW S_PZM_CRITERION_VALUES_4_3
AS
   SELECT   'Пьезометрический напор. Створные пьезометры. Секция №32' PARAM_NAME,
            0.5 K1,
            0.7 K2,
            JO.CONVERTER_NAME || ' ' || JO.OBJECT_PATHS || '\Отм. ' || JO.COORDINATE_Z POINT_NAME,
            JO.CYCLE_NUM,
            JO.DATE_OBSERVATION,
            JO.PRESSURE_BROUGHT VALUE,
            CASE
               WHEN JO.PRESSURE_BROUGHT < 0.5
                  THEN 'Диагностические параметры не превышают критерии безопасности 1-го уровня (K1)'
               ELSE CASE
               WHEN JO.PRESSURE_BROUGHT < 0.7
                  THEN 'Устойчивость, механическая и фильтрационная прочность ГТС и его основания, а также пропускная способность водосбросных и водопропускных сооружений еще соответствует условиям их нормальной эксплуатации'
               ELSE 'Эксплуатация ГТС в проектном режиме недопустима без оперативного проведения мероприятий по восстановлению требуемого уровня безопасности и без специального разрешения органа надзора'
            END
            END MESSAGE
       FROM S_PZM_JOURNAL_OBSERVATIONS_O2 JO
      WHERE ((    JO.POINT_ID >= 2771
              AND JO.POINT_ID <= 2774))
        AND JO.PRESSURE_BROUGHT IS NOT NULL
   ORDER BY JO.DATE_OBSERVATION

--

/* Фиксация изменений */

COMMIT

