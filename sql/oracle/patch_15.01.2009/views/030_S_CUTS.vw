/* Создание просмотра срезов */

CREATE OR REPLACE VIEW S_CUTS
AS
   SELECT C.CUT_ID,
          C.MEASURE_TYPE_ID,
          C.OBJECT_ID,
          C.NAME,
          C.DESCRIPTION,
          C.VIEW_NAME,
          C.PROC_NAME,
          C.DETERMINATION,
          C.CONDITION,
          C.PRIORITY,
          C.CUT_TYPE,
          MT.NAME AS MEASURE_TYPE_NAME,
          O.NAME AS OBJECT_NAME,
          MT2.PATH AS MEASURE_TYPE_PATH
     FROM CUTS C,
          MEASURE_TYPES MT,
          OBJECTS O,
          (SELECT     MT.MEASURE_TYPE_ID,
                      SUBSTR (MAX (SYS_CONNECT_BY_PATH (MT.NAME, '\')), 2) AS PATH
                 FROM MEASURE_TYPES MT
           START WITH MT.PARENT_ID IS NULL
           CONNECT BY MT.PARENT_ID = PRIOR MT.MEASURE_TYPE_ID
             GROUP BY MT.MEASURE_TYPE_ID) MT2
    WHERE C.MEASURE_TYPE_ID = MT.MEASURE_TYPE_ID(+)
      AND C.OBJECT_ID = O.OBJECT_ID(+)
      AND MT.MEASURE_TYPE_ID = MT2.MEASURE_TYPE_ID

--

/* Фиксация изменений */

COMMIT


