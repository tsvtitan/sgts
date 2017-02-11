/* Удаление просмотра таблицы отчетов интерфейсов */

DROP VIEW S_INTERFACE_REPORTS

--

/* Удаление процедуры создания отчета интерфейса */

DROP PROCEDURE I_INTERFACE_REPORT

--

/* Удаление процедуры изменения отчета интерфейса */

DROP PROCEDURE U_INTERFACE_REPORT

--

/* Удаление процедуры удаления отчета интерфейса */

DROP PROCEDURE D_INTERFACE_REPORT

--

/* Удаление последовательности для таблицы отчетов интерфейсов */

DROP SEQUENCE SEQ_INTERFACE_REPORTS

--

/* Удаление функции генерации для таблицы отчетов интерфейсов */

DROP FUNCTION GET_INTERFACE_REPORT_ID

--

/* Удаление таблицы отчетов интерфейсов */

DROP TABLE INTERFACE_REPORTS

--

/* Фиксация изменений БД */

COMMIT