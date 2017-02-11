/* Создание процедуры удаления плана-графика */

CREATE OR REPLACE PROCEDURE D_PLAN_GRAPH
(   
  YEAR IN INTEGER 
) 
AS       
BEGIN  
  DELETE FROM MEASURE_TYPE_GRAPHS    
 WHERE YEAR=D_PLAN_GRAPH.YEAR;   
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

