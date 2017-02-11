/* CREATE OR REPLACE FUNCTION get_current_displac_x */

CREATE OR REPLACE FUNCTION get_current_displac_x (
   date_observation   DATE,
   point_id           INTEGER,
   value_2            FLOAT
)
   RETURN FLOAT
IS
   value_4        FLOAT;
   jf_id_pred     INTEGER;
   p_id           INTEGER;
   d_o            DATE;
   d_o_pr         DATE;
   d              DATE;
   iter           INTEGER;
   jf_id_predd    INTEGER;
   jf_id          INTEGER;
   smi            FLOAT;
   smi_1          FLOAT;
   displacement   FLOAT;
   flag           BOOLEAN;
BEGIN
   jf_id_pred := NULL;
   p_id := point_id;
   d_o := date_observation;

   SELECT MAX (date_observation)
     INTO d
     FROM journal_fields
    WHERE param_id = 17161 AND point_id = p_id;

   IF d > d_o
   THEN
      iter := 1;
      flag := FALSE;

      FOR inc IN (SELECT   journal_field_id, date_observation
                      FROM journal_fields
                     WHERE param_id = 17161 AND point_id = p_id
                  ORDER BY date_observation)
      LOOP
         IF iter = 1
         THEN
            jf_id_predd := NULL;
            jf_id := inc.journal_field_id;
         END IF;

         IF iter <> 1
         THEN
            jf_id_predd := jf_id;
            jf_id := inc.journal_field_id;
         END IF;

         iter := iter + 1;

         IF (inc.date_observation > d_o) AND (flag = FALSE)
         THEN
            jf_id_pred := jf_id_predd;
            flag := TRUE;
         END IF;
      END LOOP;
   END IF;

   IF d < d_o
   THEN
      SELECT journal_field_id
        INTO jf_id_pred
        FROM journal_fields
       WHERE param_id = 17161 AND point_id = p_id AND date_observation = d;
   END IF;

   smi := value_2;

   IF (jf_id_pred IS NOT NULL)
   THEN
      SELECT VALUE
        INTO smi_1
        FROM journal_fields
       WHERE journal_field_id = jf_id_pred;

      displacement := smi - smi_1;
   END IF;

   IF (jf_id_pred IS NULL)
   THEN
      displacement := 0;
   END IF;

   value_4 := displacement;
   RETURN value_4;
END;

--

/* Фиксация изменений */

COMMIT