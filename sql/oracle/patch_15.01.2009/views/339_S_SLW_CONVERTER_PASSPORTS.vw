/* Создание просмотра паспортов преобразователей для Настенных щелемеров */

CREATE OR REPLACE VIEW S_SLW_CONVERTER_PASSPORTS
AS
SELECT   mt.measure_type_id, mt.NAME AS measure_type_name, r.route_id,
         r.NAME AS route_name, p.point_id, p.NAME AS point_name,
         TRIM
            (CHR (10) FROM TRIM (CHR (13) FROM get_object_paths (p.object_id))
            ) AS object_paths,
         p.coordinate_z, c.NAME AS converter_name, c.date_enter,
         cp.converter_id, cp.date_begin, cp.date_end, cp.base_counting_out_x,
         cp.base_counting_out_y, cp.base_counting_out_z, cp.base_opening_x,
         cp.base_opening_y, cp.base_opening_z, cp.description
    FROM converters c,
         points p,
         route_points rp,
         routes r,
         measure_type_routes mtr,
         measure_types mt,
         (SELECT   converter_id, date_begin, date_end,
                   MIN
                      (DECODE (param_id,
                               30006, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS base_counting_out_x,
                   MIN
                      (DECODE (param_id,
                               30008, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS base_counting_out_y,
                   MIN
                      (DECODE (param_id,
                               30009, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS base_counting_out_z,
                   MIN
                      (DECODE (param_id,
                               30010, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS base_opening_x,
                   MIN
                      (DECODE (param_id,
                               30011, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS base_opening_y,
                   MIN
                      (DECODE (param_id,
                               30012, TO_NUMBER (REPLACE (VALUE, ',', '.'),
                                                 'FM99999.9999'
                                                ),
                               NULL
                              )
                      ) AS base_opening_z,
                   MIN (DECODE (param_id, 30013, VALUE, NULL)) AS description
              FROM (SELECT   c.converter_id, cp.date_begin, cp.date_end,
                             c.param_id, cp.VALUE
                        FROM converter_passports cp, components c
                       WHERE cp.component_id = c.component_id
                         AND c.param_id IN
                                (30006,
                                 30008,
                                 30009,
                                 30010,
                                 30011,
                                 30012,
                                 30013
                                )
                    ORDER BY c.converter_id, cp.date_begin) cpc
          GROUP BY converter_id, date_begin, date_end) cp
   WHERE c.converter_id = p.point_id
     AND c.converter_id = cp.converter_id
     AND p.point_id = rp.point_id
     AND rp.route_id = r.route_id
     AND r.route_id = mtr.route_id
     AND mtr.measure_type_id = mt.measure_type_id
     AND mt.measure_type_id IN (30006, 30007)
ORDER BY mt.priority, mtr.priority, rp.priority, p.NAME, cp.date_begin DESC

--

/* Фиксация изменений */

COMMIT


