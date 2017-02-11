/* Создание просмотра Здание ГЭС в журнале наблюдений новых данных напольных щелемеров */

CREATE OR REPLACE VIEW S_SLF_JOURNAL_OBSERVATIONS_N2
AS
SELECT cycle_id, cycle_num, journal_num, date_observation, measure_type_id,
       point_id, point_name, converter_id, converter_name, object_paths,
       section_joint_priority, joint_priority, coordinate_z, opening_x,
       opening_y, opening_z, current_opening_x, current_opening_y,
       current_opening_z, cycle_null_opening_x, cycle_null_opening_y,
       cycle_null_opening_z
  FROM TABLE (get_slf_journal_observations (30011, 0))


--

/* Фиксация изменений */

COMMIT


