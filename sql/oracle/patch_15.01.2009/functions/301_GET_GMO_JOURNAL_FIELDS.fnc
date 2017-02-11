/* Создание функции просмотра гидрометеорологии в полевом журнале */

CREATE OR REPLACE FUNCTION get_gmo_journal_fields (is_close INTEGER)
   RETURN gmo_journal_field_table PIPELINED
IS
   inc2      gmo_journal_field_object
      := gmo_journal_field_object (NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL,
                                   NULL
                                  );
   num_min   INTEGER                  := NULL;
   num_max   INTEGER                  := NULL;
BEGIN
   FOR inc IN (SELECT MIN (cycle_num) AS num_min, MAX (cycle_num) AS num_max
                 FROM cycles
                WHERE is_close = get_gmo_journal_fields.is_close)
   LOOP
      num_min := inc.num_min;
      num_max := inc.num_max;
      EXIT;
   END LOOP;

   FOR inc1 IN (SELECT   /*+ INDEX (JF) INDEX (C) */
                         jf.date_observation, jf.measure_type_id, jf.cycle_id,
                         c.cycle_num, jf.point_id, jf.GROUP_ID,
                         MIN (DECODE (jf.param_id, 2900, jf.VALUE, NULL)
                             ) AS uvb,
                         MIN (DECODE (jf.param_id, 2901, jf.VALUE, NULL)
                             ) AS unb,
                         MIN (DECODE (jf.param_id, 2902, jf.VALUE, NULL)
                             ) AS t_water,
                         MIN (DECODE (jf.param_id, 2903, jf.VALUE, NULL)
                             ) AS t_air,
                         MIN (DECODE (jf.param_id, 2904, jf.VALUE, NULL)
                             ) AS unset,
                         MIN (DECODE (jf.param_id, 2905, jf.VALUE, NULL)
                             ) AS influx,
                         MIN (DECODE (jf.param_id, 2906, jf.VALUE, NULL)
                             ) AS v_vault,
                         MIN (DECODE (jf.param_id, 2907, jf.VALUE, NULL)
                             ) AS rain_day,
                         MIN (DECODE (jf.param_id, 2908, jf.VALUE, NULL)
                             ) AS prec
                    FROM journal_fields jf, cycles c
                   WHERE jf.cycle_id = c.cycle_id
                     AND jf.measure_type_id = 2520 /* Гидрометеорология  */
                     AND jf.param_id IN
                            (2900 /* УВБ */,
                             2901 /* УНБ */,
                             2902 /* T воды */,
                             2903 /* T воздуха */,
                             2904 /* Сброс */,
                             2905 /* Приток */,
                             2906 /* Объем водохранилища */,
                             2907 /* Осадков за сутки */,
                             2908 /* Вид осадков */
                            )
                     AND c.cycle_num >= num_min
                     AND c.cycle_num <= num_max
                     AND c.is_close = get_gmo_journal_fields.is_close
                GROUP BY jf.date_observation,
                         jf.measure_type_id,
                         jf.cycle_id,
                         c.cycle_num,
                         jf.point_id,
                         jf.GROUP_ID
                ORDER BY jf.date_observation, jf.GROUP_ID)
   LOOP
      inc2.cycle_id := inc1.cycle_id;
      inc2.cycle_num := inc1.cycle_num;
      inc2.date_observation := inc1.date_observation;
      inc2.measure_type_id := inc1.measure_type_id;
      inc2.point_id := inc1.point_id;
      inc2.uvb := inc1.uvb;
      inc2.unb := inc1.unb;
      inc2.t_water := inc1.t_water;
      inc2.t_air := inc1.t_air;
      inc2.unset := inc1.unset;
      inc2.influx := inc1.influx;
      inc2.v_vault := inc1.v_vault;
      inc2.rain_day := inc1.rain_day;
      inc2.prec := inc1.prec;
      PIPE ROW (inc2);
   END LOOP;

   RETURN;
END;

--

/* Фиксация изменений БД */

COMMIT
