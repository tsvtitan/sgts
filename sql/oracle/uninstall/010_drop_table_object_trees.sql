/* Удаление просмотра таблицы дерева объектов */

DROP VIEW S_OBJECT_TREES

--

/* Удаление процедуры определения пути в дереве объектов */

DROP PROCEDURE G_OBJECT_PATHS

--

/* Удаление функции определения пути в дереве объектов */

DROP FUNCTION GET_OBJECT_PATHS

--

/* Удаление процедуры создания узла дерева объектов  */

DROP PROCEDURE I_OBJECT_TREE

--

/* Удаление процедуры изменения узла дерева объектов */

DROP PROCEDURE U_OBJECT_TREE

--

/* Удаление процедуры удаления узла дерева объектов */

DROP PROCEDURE D_OBJECT_TREE

--

/* Удаление последовательности для таблицы дерева объектов  */

DROP SEQUENCE SEQ_OBJECT_TREES

--

/* Удаление функции генерации для таблицы дерева объектов */

DROP FUNCTION GET_OBJECT_TREE_ID

--

/* Удаление таблицы дерева объектов */

DROP TABLE OBJECT_TREES

--

/* Фиксация изменений БД */

COMMIT