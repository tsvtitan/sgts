/* Создание функции просмотра гидрометеорологии в журнале наблюдений */

CREATE OR REPLACE FUNCTION get_gmo_journal_observations (is_close INTEGER)
   RETURN gmo_journal_observation_table PIPELINED
IS
   inc2      gmo_journal_observation_object
      := gmo_journal_observation_object (NULL,
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
                                         NULL,
                                         NULL,
                                         NULL,
                                         NULL,
                                         NULL
                                        );
   num_min   INTEGER                        := NULL;
   num_max   INTEGER                        := NULL;
BEGIN
   FOR inc IN (SELECT MIN (cycle_num) AS num_min, MAX (cycle_num) AS num_max
                 FROM cycles
                WHERE is_close = get_gmo_journal_observations.is_close)
   LOOP
      num_min := inc.num_min;
      num_max := inc.num_max;
      EXIT;
   END LOOP;

   FOR inc1 IN (SELECT   /*+ INDEX (JO) INDEX (C) */
                         jo.date_observation, jo.measure_type_id, jo.cycle_id,
                         c.cycle_num, jo.point_id, jo.GROUP_ID,
                         MIN (DECODE (jo.param_id, 2900, jo.VALUE, NULL)
                             ) AS uvb,
                         MIN (DECODE (jo.param_id, 2901, jo.VALUE, NULL)
                             ) AS unb,
                         MIN (DECODE (jo.param_id, 2902, jo.VALUE, NULL)
                             ) AS t_water,
                         MIN (DECODE (jo.param_id, 2903, jo.VALUE, NULL)
                             ) AS t_air,
                         MIN (DECODE (jo.param_id, 2904, jo.VALUE, NULL)
                             ) AS unset,
                         MIN (DECODE (jo.param_id, 2905, jo.VALUE, NULL)
                             ) AS influx,
                         MIN (DECODE (jo.param_id, 2906, jo.VALUE, NULL)
                             ) AS v_vault,
                         MIN (DECODE (jo.param_id, 2907, jo.VALUE, NULL)
                             ) AS rain_day,
                         MIN (DECODE (jo.param_id, 2908, jo.VALUE, NULL)
                             ) AS prec,
                         MIN (DECODE (jo.param_id, 2912, jo.VALUE, NULL)
                             ) AS uvb_inc,
                         MIN (DECODE (jo.param_id, 2910, jo.VALUE, NULL)
                             ) AS rain_year,
                         MIN (DECODE (jo.param_id, 2909, jo.VALUE, NULL)
                             ) AS t_air_10,
                         MIN (DECODE (jo.param_id, 2913, jo.VALUE, NULL)
                             ) AS t_air_30
                    FROM journal_observations jo, cycles c
                   WHERE jo.cycle_id = c.cycle_id
                     AND jo.measure_type_id = 2520 /* Гидрометеорология  */
                     AND jo.param_id IN
                            (2900 /* УВБ */,
                             2901 /* УНБ */,
                             2902 /* T воды */,
                             2903 /* T воздуха */,
                             2904 /* Сброс */,
                             2905 /* Приток */,
                             2906 /* Объем водохранилища */,
                             2907 /* Осадков за сутки */,
                             2908 /* Вид осадков */,
                             2912 /* Приращение УВБ */,
                             2910 /* Осадков с начала года */,
                             2909 /* Т воздуха за 10 суток */,
                             2913 /* Т воздуха за 30 суток */
                            )
                     AND c.cycle_num >= num_min
                     AND c.cycle_num <= num_max
                     AND c.is_close = get_gmo_journal_observations.is_close
                GROUP BY jo.date_observation,
                         jo.measure_type_id,
                         jo.cycle_id,
                         c.cycle_num,
                         jo.point_id,
                         jo.GROUP_ID
                ORDER BY jo.date_observation, jo.GROUP_ID)
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
      inc2.uvb_inc := inc1.uvb_inc;
      inc2.rain_year := inc1.rain_year;
      inc2.t_air_10 := inc1.t_air_10;
      inc2.t_air_30 := inc1.t_air_30;
      PIPE ROW (inc2);
   END LOOP;

   RETURN;
END;

--

/* Фиксация изменений БД */

COMMIT