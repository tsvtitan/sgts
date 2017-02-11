/* Создание просмотра документов */

CREATE OR REPLACE VIEW S_DOCUMENTS
AS 
SELECT D.DOCUMENT_ID,D.NAME,D.DESCRIPTION,D.FILE_NAME
  FROM DOCUMENTS D

--

/* Фиксация изменений */

COMMIT


