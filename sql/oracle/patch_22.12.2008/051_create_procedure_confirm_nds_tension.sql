/* Создание процедуры расчета напряжения, в том числе с учетом ползучести */

CREATE OR REPLACE PROCEDURE CONFIRM_NDS_TENSION
(
  JOURNAL_FIELD_ID IN INTEGER,
  ALGORITHM_ID IN INTEGER
)
AS
  JOURNAL_OBSERVATION_ID INTEGER;
  AMEASURE_TYPE_ID INTEGER;
  ACYCLE_ID INTEGER;
  AWHO_CONFIRM INTEGER;
  ADATE_CONFIRM DATE;
  AGROUP_ID VARCHAR2(32);
  APRIORITY INTEGER;
  APOINT_ID INTEGER;
  APARAM_ID INTEGER;
  ADATE_OBSERVATION DATE;
  AVALUE FLOAT;
  AINSTRUMENT_ID INTEGER;
  AMEASURE_UNIT_ID INTEGER;
  AIS_BASE INTEGER;
  TENSION FLOAT;
  TENSION_CREEPING FLOAT;
  FLAG_TENSION INTEGER;
  FLAG_TENSION_CREEPING INTEGER;
  TYPE_INSTRUMENT VARCHAR2(100);
  PLACE_INSTRUMENT VARCHAR2(100);
  ROZETKA INTEGER;
  TENSION_B FLOAT;
  TENSION_V_B FLOAT;
  TENSION_G_B FLOAT;
  TENSION_PR_B FLOAT;
  TENSION_V FLOAT;
  TENSION_G FLOAT;
  TENSION_PR FLOAT;
BEGIN
  SELECT MEASURE_TYPE_ID,CYCLE_ID,WHO_CONFIRM,DATE_CONFIRM,GROUP_ID,PRIORITY,POINT_ID,
         DATE_OBSERVATION,VALUE,PARAM_ID,INSTRUMENT_ID,MEASURE_UNIT_ID,IS_BASE  
    INTO AMEASURE_TYPE_ID,ACYCLE_ID,AWHO_CONFIRM,ADATE_CONFIRM,AGROUP_ID,APRIORITY,APOINT_ID,
         ADATE_OBSERVATION,AVALUE,APARAM_ID,AINSTRUMENT_ID,AMEASURE_UNIT_ID,AIS_BASE
    FROM JOURNAL_FIELDS
   WHERE JOURNAL_FIELD_ID=CONFIRM_NDS_TENSION.JOURNAL_FIELD_ID;
   
   
  IF (APARAM_ID=60003) /* Частота */ AND (AVALUE<>0.0) THEN 

     DELETE FROM JOURNAL_OBSERVATIONS
	       WHERE JOURNAL_FIELD_ID=CONFIRM_NDS_TENSION.JOURNAL_FIELD_ID
             AND ALGORITHM_ID=CONFIRM_NDS_TENSION.ALGORITHM_ID 
             AND MEASURE_TYPE_ID=AMEASURE_TYPE_ID
             AND CYCLE_ID=ACYCLE_ID
             AND DATE_OBSERVATION=ADATE_OBSERVATION
             AND GROUP_ID=AGROUP_ID
             AND POINT_ID=APOINT_ID
             AND PARAM_ID IN (60034,60035); /* Напряжение, Напряжение с учетом ползучести */
    COMMIT;
			 
    IF (AWHO_CONFIRM IS NOT NULL) THEN
	  
	  FLAG_TENSION:=0;
	  FLAG_TENSION_CREEPING:=0;
	  
	  TYPE_INSTRUMENT:=NULL;
      FOR INC IN (SELECT CP.VALUE,
 	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C, POINTS P
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=P.POINT_ID
                     AND P.POINT_ID=APOINT_ID
                     AND C.PARAM_ID=60030 /* Тип прибора */
                   ORDER BY CP.DATE_BEGIN) LOOP
        TYPE_INSTRUMENT:=INC.VALUE;				   
		EXIT WHEN TYPE_INSTRUMENT IS NOT NULL;
      END LOOP;
	  
	  PLACE_INSTRUMENT:=NULL;
      FOR INC IN (SELECT CP.VALUE,
 	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C, POINTS P
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=P.POINT_ID
                     AND P.POINT_ID=APOINT_ID
                     AND C.PARAM_ID=60008 /* Расположение прибора */
                   ORDER BY CP.DATE_BEGIN) LOOP
        PLACE_INSTRUMENT:=INC.VALUE;				   
		EXIT WHEN PLACE_INSTRUMENT IS NOT NULL;
      END LOOP;
	  
	  ROZETKA:=NULL;
      FOR INC IN (SELECT CP.VALUE,
 	                     CP.DATE_BEGIN,
                         CP.DATE_END
                    FROM CONVERTER_PASSPORTS CP, COMPONENTS C, POINTS P
                   WHERE CP.COMPONENT_ID=C.COMPONENT_ID
                     AND C.CONVERTER_ID=P.POINT_ID
                     AND P.POINT_ID=APOINT_ID
                     AND C.PARAM_ID=60017 /* № розетки */
                   ORDER BY CP.DATE_BEGIN) LOOP
        ROZETKA:=TO_NUMBER(INC.VALUE);				   
		EXIT WHEN ROZETKA IS NOT NULL;
      END LOOP;
	  
	  IF (TYPE_INSTRUMENT IS NOT NULL) AND
	     (PLACE_INSTRUMENT IS NOT NULL) THEN
  	    
		IF (UPPER(TYPE_INSTRUMENT)=UPPER('телетензометр')) THEN
		  IF (ROZETKA IS NOT NULL) AND (ROZETKA<>0) THEN
		    IF (UPPER(PLACE_INSTRUMENT) IN (UPPER('вертикальный'),UPPER('горизонтальный'),UPPER('продольный'))) THEN 
			     
/*  		      DBMS_OUTPUT.PUT_LINE('==========================================================');		 
  		      DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);		 
  		      DBMS_OUTPUT.PUT_LINE(PLACE_INSTRUMENT);*/		 

			  TENSION_B:=0.0;
			  TENSION_V_B:=0.0;
			  TENSION_G_B:=0.0;
			  TENSION_PR_B:=0.0;
			  
			  FOR INC IN (SELECT VALUE
			                FROM JOURNAL_OBSERVATIONS
						   WHERE POINT_ID=APOINT_ID
						     AND MEASURE_TYPE_ID=AMEASURE_TYPE_ID
							 AND PARAM_ID=60034 /* Напряжение */
							 AND DATE_OBSERVATION<ADATE_OBSERVATION
						   ORDER BY DATE_OBSERVATION DESC) LOOP
                TENSION_B:=INC.VALUE;						   
			    EXIT;
			  END LOOP;
			  
/*			  DBMS_OUTPUT.PUT_LINE('TENSION_B='||TO_CHAR(TENSION_B));*/

			  CASE UPPER(PLACE_INSTRUMENT)
				WHEN UPPER('вертикальный') THEN
                  TENSION_V_B:=TENSION_B;				 
				WHEN UPPER('горизонтальный') THEN 
                  TENSION_G_B:=TENSION_B;				 
				WHEN UPPER('продольный') THEN 
                  TENSION_PR_B:=TENSION_B;				 
		      END CASE;
			  
	          CALCULATE_NDS_ROZETKA_TENSION(APOINT_ID,ROZETKA,
			                                ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
											TENSION_V_B,TENSION_G_B,TENSION_PR_B, 
			                                TENSION_V,TENSION_G,TENSION_PR);
              
			  CASE UPPER(PLACE_INSTRUMENT)
				WHEN UPPER('вертикальный') THEN
                  TENSION:=TENSION_V;				 
				WHEN UPPER('горизонтальный') THEN 
                  TENSION:=TENSION_G;				 
				WHEN UPPER('продольный') THEN 
                  TENSION:=TENSION_PR;				 
		      END CASE;
			  
			  CALCULATE_NDS_TENSION_CREEPING(APOINT_ID,
			                                 ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
											 TENSION,TENSION_CREEPING);
  
			END IF;
		  ELSE
		    IF (UPPER(PLACE_INSTRUMENT) IN (UPPER('одиночный'),UPPER('неопределено'))) THEN 
/*  		      DBMS_OUTPUT.PUT_LINE('==========================================================');		 
  		      DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);		 
  		      DBMS_OUTPUT.PUT_LINE(PLACE_INSTRUMENT);*/

			 /* TENSION_B:=0.0;
			  FOR INC IN (SELECT VALUE
			                FROM JOURNAL_OBSERVATIONS
						   WHERE POINT_ID=APOINT_ID
						     AND MEASURE_TYPE_ID=AMEASURE_TYPE_ID
							 AND PARAM_ID=60034 /* Напряжение */ /*
							 AND DATE_OBSERVATION<ADATE_OBSERVATION
							 AND VALUE<>0.0
						   ORDER BY DATE_OBSERVATION DESC) LOOP
                TENSION_B:=INC.VALUE;						   
			    EXIT;
			  END LOOP;
			  
			  CALCULATE_NDS_SINGLE_TENSION(APOINT_ID,AVALUE,
			                               ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
		                                   TENSION_B,TENSION);		 

			  CALCULATE_NDS_TENSION_CREEPING(APOINT_ID,
			                                 ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
											 TENSION,TENSION_CREEPING); */
			  TENSION:=NULL;
			  TENSION_CREEPING:=NULL;							 
			END IF;  
		  END IF; 	
		END IF;
		 
		IF (UPPER(TYPE_INSTRUMENT)=UPPER('арматурный динамометр')) THEN
/*          DBMS_OUTPUT.PUT_LINE('==========================================================');		 
          DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);		 
  		  DBMS_OUTPUT.PUT_LINE(PLACE_INSTRUMENT);*/
		  
		  CALCULATE_NDS_ARMATURE_TENSION(APOINT_ID,AVALUE,
 		                                 ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
		                                 TENSION);
		END IF;
		 
		IF (UPPER(TYPE_INSTRUMENT)=UPPER('накладной телетензометр')) THEN
/*          DBMS_OUTPUT.PUT_LINE('==========================================================');		 
          DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);		 
  		  DBMS_OUTPUT.PUT_LINE(PLACE_INSTRUMENT);*/
		
		  CALCULATE_NDS_IMPOSE_TENSION(APOINT_ID,AVALUE,
 		                               ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
		                               TENSION);
		END IF;
	  
	  END IF;
	  
	  IF (TENSION IS NOT NULL) THEN
        FLAG_TENSION:=1;
	  END IF;
	  
	  IF (TENSION_CREEPING IS NOT NULL) THEN
        FLAG_TENSION_CREEPING:=1;
	  END IF;
	  
	  IF (FLAG_TENSION=1) THEN
        I_JOURNAL_OBSERVATION(GET_JOURNAL_OBSERVATION_ID,
                              JOURNAL_FIELD_ID,
                              NULL,
                              AMEASURE_TYPE_ID,
                              NULL,
                              ADATE_OBSERVATION,
                              ACYCLE_ID,
                              APOINT_ID,
                              60034,/* Напряжение */
                              TENSION,
                              AWHO_CONFIRM,
                              ADATE_CONFIRM,
                              ALGORITHM_ID,
                              AGROUP_ID,
                              APRIORITY);
      END IF;
	  							  
	  IF (FLAG_TENSION_CREEPING=1) THEN
        I_JOURNAL_OBSERVATION(GET_JOURNAL_OBSERVATION_ID,
                              JOURNAL_FIELD_ID,
                              NULL,
                              AMEASURE_TYPE_ID,
                              NULL,
                              ADATE_OBSERVATION,
                              ACYCLE_ID,
                              APOINT_ID,
                              60035,/* Напряжение с учетом ползучести */
                              TENSION_CREEPING,
                              AWHO_CONFIRM,
                              ADATE_CONFIRM,
                              ALGORITHM_ID,
                              AGROUP_ID,
                              APRIORITY);
      END IF;
	  							  
	END IF;  
  END IF;		 
END;

--

/* Фиксация изменений БД */

COMMIT