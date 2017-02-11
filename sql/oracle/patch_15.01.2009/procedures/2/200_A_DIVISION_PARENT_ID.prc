/* Создание процедуры проверки родительского отдела */

CREATE OR REPLACE PROCEDURE A_DIVISION_PARENT_ID
( 
  DIVISION_ID IN INTEGER, 
  PARENT_ID IN INTEGER 
) 
AS 
  CNT INTEGER; 
  E EXCEPTION; 
  ERROR VARCHAR2(500); 
BEGIN 
  IF (DIVISION_ID=PARENT_ID) THEN 
    ERROR:='Отдел не может ссылаться сам на себя.'; 
    RAISE E; 
  END IF; 
   
  SELECT COUNT(*) INTO CNT FROM DUAL 
   WHERE PARENT_ID IN (SELECT D1.DIVISION_ID 
                         FROM DIVISIONS D1, DIVISIONS D2  
                        WHERE D1.PARENT_ID=D2.DIVISION_ID (+)   
                   START WITH D1.DIVISION_ID=A_DIVISION_PARENT_ID.DIVISION_ID 
                   CONNECT BY D1.PARENT_ID=PRIOR D1.DIVISION_ID); 
   
  IF (CNT>0) THEN 
    ERROR:='Отдел не может ссылаться на дочерние отделы.'; 
    RAISE E; 
  END IF; 
   
EXCEPTION 
  WHEN E THEN  
       RAISE_APPLICATION_ERROR(-20100,ERROR); 
END;

--

/* Фиксация изменений */

COMMIT

