/* Удаление просмотра таблицы отделов */

DROP VIEW S_DIVISIONS

--

/* Удаление процедуры проверки родительского отдела */

DROP PROCEDURE A_DIVISION_PARENT_ID

--

/* Удаление процедуры создания отдела */

DROP PROCEDURE I_DIVISION

--

/* Удаление процедуры изменения отдела */

DROP PROCEDURE U_DIVISION

--

/* Удаление процедуры удаления отдела */

DROP PROCEDURE D_DIVISION

--

/* Удаление последовательности для таблицы отделов */

DROP SEQUENCE SEQ_DIVISIONS

--

/* Удаление функции генерации для таблицы отделов */

DROP FUNCTION GET_DIVISION_ID

--

/* Удаление таблицы отделов */

DROP TABLE DIVISIONS

--
/* Фиксация изменений БД */

COMMIT
