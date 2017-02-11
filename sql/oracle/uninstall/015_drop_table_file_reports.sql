/* Удаление просмотра таблицы файловых отчетов */

DROP VIEW S_FILE_REPORTS

--

/* Удаление процедуры создания файлового отчета */

DROP PROCEDURE I_FILE_REPORT

--

/* Удаление процедуры изменения файлового отчета */

DROP PROCEDURE U_FILE_REPORT

--

/* Удаление процедуры удаления файлового отчета */

DROP PROCEDURE D_FILE_REPORT

--

/* Удаление последовательности для таблицы файловых отчетов */

DROP SEQUENCE SEQ_FILE_REPORTS

--

/* Удаление функции генерации для таблицы файловых отчетов */

DROP FUNCTION GET_FILE_REPORT_ID

--

/* Удаление таблицы файловых отчетов */

DROP TABLE FILE_REPORTS

--

/* Фиксация изменений БД */

COMMIT