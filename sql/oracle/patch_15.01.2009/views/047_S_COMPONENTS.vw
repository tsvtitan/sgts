/* Создание просмотра компонент */

CREATE OR REPLACE VIEW S_COMPONENTS
AS 
SELECT   D.COMPONENT_ID,
         D.CONVERTER_ID,
         D.PARAM_ID,
         D.NAME,
         D.DESCRIPTION,
         C.NAME AS CONVERTER_NAME,
         P.NAME AS PARAM_NAME
    FROM COMPONENTS D,
         CONVERTERS C,
         PARAMS P
   WHERE D.CONVERTER_ID = C.CONVERTER_ID
     AND D.PARAM_ID = P.PARAM_ID
ORDER BY D.NAME

--

/* Фиксация изменений */

COMMIT


