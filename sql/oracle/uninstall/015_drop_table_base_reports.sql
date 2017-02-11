/* Удаление просмотра таблицы базовых отчетов */

DROP VIEW S_BASE_REPORTS

--

/* Удаление процедуры создания базового отчета */

DROP PROCEDURE I_BASE_REPORT

--

/* Удаление процедуры изменения базового отчета */

DROP PROCEDURE U_BASE_REPORT

--

/* Удаление процедуры удаления базового отчета */

DROP PROCEDURE D_BASE_REPORT

--

/* Удаление последовательности для таблицы базовых отчетов */

DROP SEQUENCE SEQ_BASE_REPORTS

--

/* Удаление функции генерации для таблицы базовых отчетов */

DROP FUNCTION GET_BASE_REPORT_ID

--

/* Удаление таблицы базовых отчетов */

DROP TABLE BASE_REPORTS

--

/* Фиксация изменений БД */

COMMIT