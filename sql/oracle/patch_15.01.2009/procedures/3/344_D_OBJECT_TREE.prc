/* Создание процедуры удаления узла в дереве объектов */

CREATE OR REPLACE PROCEDURE D_OBJECT_TREE
( 
  OLD_OBJECT_TREE_ID IN INTEGER 
) 
AS 
BEGIN 
  DELETE FROM OBJECT_TREES 
        WHERE OBJECT_TREE_ID=OLD_OBJECT_TREE_ID; 
  COMMIT;         
END;

--

/* Фиксация изменений */

COMMIT

