/* Создание процедуры расчета раскрытия */

CREATE OR REPLACE PROCEDURE CONFIRM_NDS_OPENING
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
  OPENING FLOAT;
  FLAG_OPENING INTEGER;
  TYPE_INSTRUMENT VARCHAR2(100);
  RESISTANCE FLOAT;
  RESISTANCE_LINE FLOAT;
BEGIN
  SELECT MEASURE_TYPE_ID,CYCLE_ID,WHO_CONFIRM,DATE_CONFIRM,GROUP_ID,PRIORITY,POINT_ID,
         DATE_OBSERVATION,VALUE,PARAM_ID,INSTRUMENT_ID,MEASURE_UNIT_ID,IS_BASE  
    INTO AMEASURE_TYPE_ID,ACYCLE_ID,AWHO_CONFIRM,ADATE_CONFIRM,AGROUP_ID,APRIORITY,APOINT_ID,
         ADATE_OBSERVATION,AVALUE,APARAM_ID,AINSTRUMENT_ID,AMEASURE_UNIT_ID,AIS_BASE
    FROM JOURNAL_FIELDS
   WHERE JOURNAL_FIELD_ID=CONFIRM_NDS_OPENING.JOURNAL_FIELD_ID;
   
   
  IF (APARAM_ID=60003) /* Частота */ AND (AVALUE<>0.0) THEN 

     DELETE FROM JOURNAL_OBSERVATIONS
	       WHERE JOURNAL_FIELD_ID=CONFIRM_NDS_OPENING.JOURNAL_FIELD_ID
             AND ALGORITHM_ID=CONFIRM_NDS_OPENING.ALGORITHM_ID 
             AND MEASURE_TYPE_ID=AMEASURE_TYPE_ID
             AND CYCLE_ID=ACYCLE_ID
             AND DATE_OBSERVATION=ADATE_OBSERVATION
             AND GROUP_ID=AGROUP_ID
             AND POINT_ID=APOINT_ID
             AND PARAM_ID IN (60037); /* Раскрытие */
    COMMIT;
			 
    IF (AWHO_CONFIRM IS NOT NULL) THEN
	  
	  FLAG_OPENING:=0;
	  
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
	  
	  IF (TYPE_INSTRUMENT IS NOT NULL) THEN
		IF (UPPER(TYPE_INSTRUMENT) IN (UPPER('щелемер дистанционный'),UPPER('деформометр'),UPPER('телещелемер'))) THEN

		  IF (UPPER(TYPE_INSTRUMENT)=UPPER('телещелемер')) THEN
  		    DBMS_OUTPUT.PUT_LINE('==========================================================');		 
  		    DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);
			
			RESISTANCE_LINE:=NULL;
		    FOR INC IN (SELECT JF.VALUE
		                  FROM JOURNAL_FIELDS JF
				  	     WHERE JF.POINT_ID=APOINT_ID
					       AND JF.MEASURE_TYPE_ID=AMEASURE_TYPE_ID
						   AND JF.CYCLE_ID=ACYCLE_ID
						   AND JF.DATE_OBSERVATION=ADATE_OBSERVATION
						   AND JF.IS_BASE=AIS_BASE
						   AND JF.GROUP_ID=AGROUP_ID
						   AND JF.PARAM_ID IN (60001) /* Сопротивление линии */) LOOP
              RESISTANCE_LINE:=INC.VALUE;            					
              EXIT WHEN RESISTANCE_LINE IS NOT NULL;									 
            END LOOP; 						 

			RESISTANCE:=NULL;
		    FOR INC IN (SELECT JF.VALUE
		                  FROM JOURNAL_FIELDS JF
				  	     WHERE JF.POINT_ID=APOINT_ID
					       AND JF.MEASURE_TYPE_ID=AMEASURE_TYPE_ID
						   AND JF.CYCLE_ID=ACYCLE_ID
						   AND JF.DATE_OBSERVATION=ADATE_OBSERVATION
						   AND JF.IS_BASE=AIS_BASE
						   AND JF.GROUP_ID=AGROUP_ID
						   AND JF.PARAM_ID IN (60002) /* Сопротивление */) LOOP
              RESISTANCE:=INC.VALUE;            					
              EXIT WHEN RESISTANCE IS NOT NULL;									 
            END LOOP; 						 
			
		    CALCULATE_NDS_BUILDING_OPENING(APOINT_ID,AVALUE,RESISTANCE,RESISTANCE_LINE,0,
 	                                       ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
		                                   OPENING);
          END IF;
		
		  IF (UPPER(TYPE_INSTRUMENT)=UPPER('деформометр')) THEN
  		    DBMS_OUTPUT.PUT_LINE('==========================================================');		 
  		    DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);
			
		    CALCULATE_NDS_CONTACT_OPENING(APOINT_ID,AVALUE,
 	                                      ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
		                                  OPENING);
          END IF; 									  

		  IF (UPPER(TYPE_INSTRUMENT)=UPPER('щелемер дистанционный')) THEN
  		    DBMS_OUTPUT.PUT_LINE('==========================================================');		 
  		    DBMS_OUTPUT.PUT_LINE(TYPE_INSTRUMENT);
			
		    CALCULATE_NDS_BUILDING_OPENING(APOINT_ID,AVALUE,RESISTANCE,RESISTANCE_LINE,1,
 	                                       ADATE_OBSERVATION,AMEASURE_TYPE_ID,ACYCLE_ID,AIS_BASE,
		                                   OPENING);
          END IF;
		   									  
        END IF;									
	  END IF;
	  
	  IF (OPENING IS NOT NULL) THEN
	    FLAG_OPENING:=1;
	  END IF;
	  
	  IF (FLAG_OPENING=1) THEN
        I_JOURNAL_OBSERVATION(GET_JOURNAL_OBSERVATION_ID,
                              JOURNAL_FIELD_ID,
                              NULL,
                              AMEASURE_TYPE_ID,
                              NULL,
                              ADATE_OBSERVATION,
                              ACYCLE_ID,
                              APOINT_ID,
                              60037, /* Раскрытие */
                              OPENING,
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