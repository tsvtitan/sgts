/* CREATE OR REPLACE FUNCTION get_nds_param_journal_o */

CREATE OR REPLACE FUNCTION get_nds_param_journal_o ( 
   measure_type_id   INTEGER,    
   param_id    INTEGER 
) 
   RETURN nds_journal_observation_table PIPELINED 
IS 
   inc2      nds_journal_observation_object 
      := nds_journal_observation_object (NULL, 
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
                WHERE is_close = 0) 
   LOOP 
      num_min := inc.num_min; 
      num_max := inc.num_max; 
      EXIT; 
   END LOOP; 
 
   FOR inc1 IN 
      (SELECT   jo.date_observation, jo.measure_type_id, jo.cycle_id, 
                MIN (jo.journal_field_id) AS journal_field_id, c.cycle_num, 
                jo.point_id, p.NAME AS point_name, p.coordinate_z, 
                CV.converter_id, CV.NAME AS converter_name, 
                MIN (cp.VALUE) AS TYPE, jo.GROUP_ID, 
                jo.VALUE AS value, 
    MIN(DECODE(JO.PARAM_ID,60005,JO.VALUE,NULL)) AS VALUE_STATER_CARRIE,                 
                ot.object_paths 
           FROM journal_observations jo, 
                cycles c, 
                points p, 
                converters CV, 
                route_points rp, 
                components cm, 
                converter_passports cp, 
                (SELECT     ot1.object_id, 
                            SUBSTR 
                               (MAX (SYS_CONNECT_BY_PATH (o1.NAME, '\')), 
                                2 
                               ) AS object_paths 
                       FROM object_trees ot1, objects o1 
                      WHERE ot1.object_id = o1.object_id 
                 START WITH ot1.parent_id IS NULL 
                 CONNECT BY ot1.parent_id = PRIOR ot1.object_tree_id 
                   GROUP BY ot1.object_id) ot 
          WHERE jo.cycle_id = c.cycle_id 
            AND jo.point_id = p.point_id 
            AND ot.object_id = p.object_id 
            AND CV.converter_id = p.point_id 
            AND rp.point_id = jo.point_id 
            AND cm.converter_id = CV.converter_id 
            AND cp.component_id = cm.component_id 
            AND cm.param_id = 60030 
            AND jo.measure_type_id = 
                                  get_nds_param_journal_o.measure_type_id 
            AND jo.param_id IN (get_nds_param_journal_o.param_id, 60005) 
            AND c.cycle_num >= num_min 
            AND c.cycle_num <= num_max 
            AND c.is_close = 0 
       GROUP BY jo.date_observation, 
                jo.measure_type_id, 
                jo.cycle_id, 
                c.cycle_num, 
                jo.point_id, 
                p.point_id, 
                p.NAME, 
                CV.converter_id, 
                CV.NAME, 
                jo.GROUP_ID, 
                p.coordinate_z, 
                ot.object_paths, 
                rp.priority, 
    jo.value 
       ORDER BY jo.date_observation, jo.GROUP_ID, rp.priority) 
   LOOP 
      inc2.date_observation := inc1.date_observation; 
      inc2.measure_type_id := inc1.measure_type_id; 
      inc2.cycle_id := inc1.cycle_id; 
      inc2.cycle_num := inc1.cycle_num; 
      inc2.measure_type_id := inc1.measure_type_id; 
      inc2.point_id := inc1.point_id; 
      inc2.point_name := inc1.point_name; 
      inc2.converter_id := inc1.converter_id; 
      inc2.converter_name := inc1.converter_name; 
      inc2.TYPE := inc1.TYPE; 
      inc2.coordinate_z := inc1.coordinate_z; 
      inc2.value_stater_carrie := inc1.VALUE_STATER_CARRIE; 
      inc2.value_exertion := inc1.value; 
      inc2.value_exertion_account := inc1.value; 
      inc2.value_temperature := inc1.value; 
      inc2.value_opening := inc1.value; 
      inc2.value_resistance := inc1.value; 
      inc2.value_frequency := inc1.value; 
      inc2.object_paths := inc1.object_paths; 
      PIPE ROW (inc2); 
   END LOOP; 
 
   RETURN; 
END;

--

/* Фиксация изменений */

COMMIT

