/* Создание функции получения значения рядом по дате */

CREATE OR REPLACE FUNCTION get_value_near_date (
   po_id   INTEGER,
   pa_id   INTEGER,
   DATA    DATE
)
   RETURN FLOAT
IS
   res         FLOAT;
   d1          DATE;
   d2          DATE;
   iter        INTEGER;
   j_id_last   INTEGER;
   j_id_next   INTEGER;
   flag        BOOLEAN;
   r1          INTEGER;
   r2          INTEGER;
BEGIN
   iter := 1;
   flag := FALSE;

   FOR inc IN (SELECT   journal_field_id, date_observation, VALUE
                   FROM journal_fields
                  WHERE point_id = po_id AND param_id = pa_id
               ORDER BY date_observation)
   LOOP
      IF iter = 1
      THEN
         IF inc.date_observation >= DATA
         THEN
            flag := TRUE;
            res := inc.VALUE;
            RETURN res;
         ELSE
            j_id_last := inc.journal_field_id;
         END IF;
      END IF;

      IF iter <> 1 AND flag = FALSE
      THEN
         IF inc.date_observation >= DATA
         THEN
            SELECT date_observation
              INTO d1
              FROM journal_fields
             WHERE journal_field_id = j_id_last;

            d2 := inc.date_observation;
            r1 := DATA - d1;
            r2 := d2 - DATA;

            IF r2 < r1
            THEN
               SELECT VALUE
                 INTO res
                 FROM journal_fields
                WHERE journal_field_id = inc.journal_field_id;

               RETURN res;
               flag := TRUE;
            END IF;

            IF r2 >= r1
            THEN
               SELECT VALUE
                 INTO res
                 FROM journal_fields
                WHERE journal_field_id = j_id_last;

               RETURN res;
               flag := TRUE;
            END IF;
         ELSE
            j_id_last := inc.journal_field_id;
         END IF;
      END IF;

      iter := iter + 1;
   END LOOP;
END;

--

/* Фиксация изменений */

COMMIT
