/* Удаление просмотра таблицы персонала */

DROP VIEW S_PERSONNELS

--

/* Удаление просмотра таблицы персонала только исполнителей */

DROP VIEW S_PERSONNEL_ONLY_PERFORMERS

--

/* Удаление процедуры создания персоны */

DROP PROCEDURE I_PERSONNEL

--

/* Удаление процедуры изменения персоны */

DROP PROCEDURE U_PERSONNEL

--

/* Удаление процедуры удаления персоны */

DROP PROCEDURE D_PERSONNEL

--

/* Удаление последовательности для таблицы персонала */

DROP SEQUENCE SEQ_PERSONNELS

--

/* Удаление функции генерации для таблицы персонала */

DROP FUNCTION GET_PERSONNEL_ID

--

/* Удаление таблицы персонала */

DROP TABLE PERSONNELS

--

/* Фиксация изменений БД */

COMMIT
