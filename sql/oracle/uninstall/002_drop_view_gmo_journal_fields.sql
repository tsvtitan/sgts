/* Удаление просмотра Гидрометеорологии в полевом журнале */

DROP VIEW S_GMO_JOURNAL_FIELDS

--

/* Удаление просмотра Гидрометеорологии в полевом журнале новых данных */

DROP VIEW S_GMO_JOURNAL_FIELDS_NEW

--

/* Удаление просмотра Гидрометеорологии в полевом журнале старых данных */ 

DROP MATERIALIZED VIEW S_GMO_JOURNAL_FIELDS_OLD

--

/* Удаление функции просмотра Гидрометеорологии в полевом журнале */

DROP FUNCTION GET_GMO_JOURNAL_FIELDS

--

/* Удаление типа таблицы Гидрометеорологии полевого журнала */

DROP TYPE GMO_JOURNAL_FIELD_TABLE 

--

/* Удаление типа объекта Гидрометеорологии полевого журнала */

DROP TYPE GMO_JOURNAL_FIELD_OBJECT

--

/* Фиксация изменений БД */

COMMIT
