/* Создание процедуры контроля CHECK_DIFFERENCE_COURSE_N */

CREATE OR REPLACE PROCEDURE CHECK_DIFFERENCE_COURSE_N  (
  VALUE_0 IN FLOAT, 
  VALUE_1 IN FLOAT,     
  SUCCESS OUT INTEGER,     
  INFO OUT VARCHAR2  )   
AS   
  AVALUE FLOAT; 
BEGIN     
  AVALUE:=ABS(VALUE_0-VALUE_1); 
  IF (AVALUE>0.25) THEN       
    SUCCESS:=0;       
 INFO:='Контроль не пройден. Модуль максимальной допустимой разности между отсчетами ходов прямо и обратно ='||TO_CHAR(AVALUE)||' и > 0.25';     
  ELSE        
    SUCCESS:=1;       
 INFO:='Контроль пройден. Модуль максимальной допустимой разности между отсчетами ходов прямо и обратно ='||TO_CHAR(AVALUE)||' и <= 0.25';     
  END IF;     
END;

--

/* Фиксация изменений */

COMMIT

