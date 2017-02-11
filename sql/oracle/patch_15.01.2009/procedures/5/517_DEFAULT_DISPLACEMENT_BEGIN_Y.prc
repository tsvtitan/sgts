/* Создание функции получения значения смещения с нач. набл. по Y по умолчанию */

CREATE OR REPLACE PROCEDURE DEFAULT_DISPLACEMENT_BEGIN_Y (
   DATE_OBSERVATION IN DATE,
   POINT_ID IN INTEGER,
   VALUE_1 IN FLOAT,
   VALUE_3 IN OUT FLOAT
)
AS
   D_O DATE;
   P_ID INTEGER;
   VAL FLOAT;
   COMP_ID INTEGER;
   POL_IZM_STOL VARCHAR2 (100);
   GRUPPA_OTVESA VARCHAR2 (100);
   INSTR_ID INTEGER;
   SM FLOAT;
   BAZ_ZN VARCHAR2 (100);
   BAZ_ZN_F FLOAT;
BEGIN /* Запоминаем дату наблюдения, параметр, точку и значение в ней */
   D_O := DATE_OBSERVATION;
   P_ID := POINT_ID;
   VAL := VALUE_1;

   FOR INC2 IN (SELECT COMPONENT_ID,
                       PARAM_ID,
                       CONVERTER_ID
                  FROM COMPONENTS
                 WHERE (CONVERTER_ID = P_ID)
                   AND (PARAM_ID = 16146))
   LOOP
      COMP_ID := INC2.COMPONENT_ID;
   END LOOP;

   /* Запоминаем положение измерительного столика */
   FOR INC2 IN (SELECT COMPONENT_ID,
                       VALUE
                  FROM CONVERTER_PASSPORTS
                 WHERE (COMPONENT_ID = COMP_ID))
   LOOP
      POL_IZM_STOL := INC2.VALUE;
   END LOOP;

   FOR INC2 IN (SELECT COMPONENT_ID,
                       PARAM_ID,
                       CONVERTER_ID
                  FROM COMPONENTS
                 WHERE (CONVERTER_ID = P_ID)
                   AND (PARAM_ID = 16140))
   LOOP
      COMP_ID := INC2.COMPONENT_ID;
   END LOOP;

   /* Запоминаем группу отвеса */
   FOR INC2 IN (SELECT COMPONENT_ID,
                       VALUE
                  FROM CONVERTER_PASSPORTS
                 WHERE (COMPONENT_ID = COMP_ID))
   LOOP
      GRUPPA_OTVESA := INC2.VALUE;
   END LOOP;

   /* Если измеренное значение есть отсчет по X */      /* Находим подходящее значение базового смещения и номер прибора */
   FOR INC2 IN (SELECT COMPONENT_ID,
                       PARAM_ID,
                       CONVERTER_ID
                  FROM COMPONENTS
                 WHERE (CONVERTER_ID = P_ID)
                   AND (PARAM_ID = 17156))
   LOOP
      COMP_ID := INC2.COMPONENT_ID;

      FOR INC3 IN (SELECT COMPONENT_ID,
                          INSTRUMENT_ID,
                          DATE_BEGIN,
                          DATE_END,
                          VALUE
                     FROM CONVERTER_PASSPORTS
                    WHERE (COMPONENT_ID = COMP_ID))
      LOOP
         IF (   (    (D_O >= INC3.DATE_BEGIN)
                 AND (D_O < INC3.DATE_END))
             OR (    (D_O >= INC3.DATE_BEGIN)
                 AND (INC3.DATE_END IS NULL)))
         THEN
            INSTR_ID := INC3.INSTRUMENT_ID;
            BAZ_ZN := INC3.VALUE;
         END IF;
      END LOOP;
   END LOOP;

   SELECT REPLACE (BAZ_ZN, ',', '.')
     INTO BAZ_ZN
     FROM DUAL;

   BAZ_ZN_F := TO_NUMBER (BAZ_ZN);

   /* Производим расчет смещения по оси на основании полученных данных для ОО */
   IF    (GRUPPA_OTVESA = 'ОО глубинный')
      OR (GRUPPA_OTVESA = 'ОО контактный')
   THEN
      IF (INSTR_ID = 5162)
      THEN
         SM := VAL - BAZ_ZN_F;
      END IF;

      IF     (INSTR_ID = 5163)
         AND (POL_IZM_STOL = 'Со стороны ВБ')
      THEN
         SM := BAZ_ZN_F - VAL;
      END IF;

      IF     (INSTR_ID = 5163)
         AND (POL_IZM_STOL = 'Со стороны НБ')
      THEN
         SM := VAL - BAZ_ZN_F;
      END IF;
   END IF;

   /* Производим расчет смещения по оси на основании полученных данных для ПО */
   IF (GRUPPA_OTVESA = 'ПО')
   THEN
      IF (POL_IZM_STOL = 'Со стороны ВБ')
      THEN
         SM := VAL - BAZ_ZN_F;
      END IF;

      IF (POL_IZM_STOL = 'Со стороны НБ')
      THEN
         SM := BAZ_ZN_F - VAL;
      END IF;
   END IF;

   /* Обработка */
   VALUE_3 := SM;
END;

--

/* Фиксация изменений */

COMMIT
