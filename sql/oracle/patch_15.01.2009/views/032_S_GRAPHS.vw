/* Создание просмотра графиков */

CREATE OR REPLACE VIEW S_GRAPHS
AS 
SELECT G.GRAPH_ID,
       G.CUT_ID,
       G.NAME,
       G.DESCRIPTION,
       G.GRAPH_TYPE,
       G.DETERMINATION,
       G.PRIORITY,
       G.MENU,
       C.NAME AS CUT_NAME,
       C.DETERMINATION AS CUT_DETERMINATION,
       C.VIEW_NAME,
       C.CONDITION
  FROM GRAPHS G,
       CUTS C
 WHERE G.CUT_ID = C.CUT_ID

--

/* Фиксация изменений */

COMMIT


