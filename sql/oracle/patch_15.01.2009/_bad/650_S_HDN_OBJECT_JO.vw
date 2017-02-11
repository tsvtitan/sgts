/* Создание просмотра журнала наблюдений гидронивелиров вместе с объектом */

CREATE OR REPLACE VIEW S_HDN_OBJECT_JO
AS
SELECT JO.CYCLE_NUM,
       JO.DATE_OBSERVATION,
       JO.OBJECT_ID,
       (SELECT O.SHORT_NAME
          FROM OBJECTS O
         WHERE O.OBJECT_ID = (SELECT GO.OBJECT_ID
                                FROM GROUP_OBJECTS GO
                               WHERE GO.PRIORITY = JO.PRIORITY
                                 AND GO.GROUP_ID = JO.GROUP_ID)) AS OBJECT_NAME,
       JO.GROUP_ID,
       JO.PRIORITY,
       JO.VALUE_MOTION_FORWARD,
       JO.VALUE_MOTION_BACK,
       JO.VALUE_AVERAGE,
       JO.VALUE_ERROR,
       JO.VALUE_DISPLACEMENT_BEGIN,
       JO.VALUE_CURRENT_DISPLACEMENT,
       JO.VALUE_MARK_POINT,
       JO.POINT_ID
  FROM S_HDN_JOURNAL_OBSERVATIONS_OBJ JO

--

/* Фиксация изменений */

COMMIT


