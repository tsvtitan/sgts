/* Создание процедуры установки значения по умолчанию для С-А по микрометру напольного щелемера */

CREATE OR REPLACE PROCEDURE DEFAULT_SLF_VALUE_CA_MICROMETR (
   DATE_OBSERVATION DATE,
   POINT_ID INTEGER,
   VALUE_0 IN OUT FLOAT, /* А-Б стойка */
   VALUE_1 IN OUT FLOAT, /* А-Б штангенциркуль */
   VALUE_2 IN OUT FLOAT, /* А-Б микрометр */
   VALUE_3 IN OUT FLOAT, /* Б-А стойка */
   VALUE_4 IN OUT FLOAT, /* Б-А штангенциркуль */
   VALUE_5 IN OUT FLOAT, /* Б-А микрометр */
   VALUE_6 IN OUT FLOAT, /* А-С стойка */
   VALUE_7 IN OUT FLOAT, /* А-С штангенциркуль */
   VALUE_8 IN OUT FLOAT, /* А-С микрометр */
   VALUE_9 IN OUT FLOAT, /* С-А стойка */
   VALUE_10 IN OUT FLOAT, /* С-А штангенциркуль */
   VALUE_11 IN OUT FLOAT, /* С-А микрометр */
   VALUE_12 IN OUT FLOAT, /* Б-С стойка */
   VALUE_13 IN OUT FLOAT, /* Б-С штангенциркуль */
   VALUE_14 IN OUT FLOAT, /* Б-С микрометр */
   VALUE_15 IN OUT FLOAT, /* С-Б стойка */
   VALUE_16 IN OUT FLOAT, /* С-Б штангенциркуль */
   VALUE_17 IN OUT FLOAT, /* С-Б микрометр */
   VALUE_18 IN OUT FLOAT, /* А-Б шт.ср. */
   VALUE_19 IN OUT FLOAT, /* А-Б мик.ср. */
   VALUE_20 IN OUT FLOAT, /* А-С шт.ср. */
   VALUE_21 IN OUT FLOAT, /* А-С мик.ср. */
   VALUE_22 IN OUT FLOAT, /* Б-С шт.ср. */
   VALUE_23 IN OUT FLOAT, /* Б-С мик.ср. */
   VALUE_24 IN OUT FLOAT, /* Невязка превышений */
   VALUE_25 IN OUT FLOAT, /* Раскрытие с начала наблюдений по X */
   VALUE_26 IN OUT FLOAT, /* Текущее раскрытие по Х */
   VALUE_27 IN OUT FLOAT, /* Раскрытие с начала наблюдений по Y */
   VALUE_28 IN OUT FLOAT, /* Текущее раскрытие по Y */
   VALUE_29 IN OUT FLOAT, /* Раскрытие с начала наблюдений по Z */
   VALUE_30 IN OUT FLOAT /* Текущее раскрытие по Z */
)
AS
BEGIN
   IF (VALUE_11 IS NULL)
   THEN
      VALUE_11 := 0.0;
   END IF;

   CALCULATE_SLF_VALUES (DATE_OBSERVATION,
                         POINT_ID,
                         VALUE_0,
                         VALUE_1,
                         VALUE_2,
                         VALUE_3,
                         VALUE_4,
                         VALUE_5,
                         VALUE_6,
                         VALUE_7,
                         VALUE_8,
                         VALUE_9,
                         VALUE_10,
                         VALUE_11,
                         VALUE_12,
                         VALUE_13,
                         VALUE_14,
                         VALUE_15,
                         VALUE_16,
                         VALUE_17,
                         VALUE_18,
                         VALUE_19,
                         VALUE_20,
                         VALUE_21,
                         VALUE_22,
                         VALUE_23,
                         VALUE_24,
                         VALUE_25,
                         VALUE_27,
                         VALUE_29,
                         VALUE_26,
                         VALUE_28,
                         VALUE_30
                        );
END;

--

/* Фиксация изменений */

COMMIT
