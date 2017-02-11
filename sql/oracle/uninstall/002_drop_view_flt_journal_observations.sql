/* Удаление просмотра Фильтрации в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS

--

/* Удаление просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_6

--

/* Удаление просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений новых данных */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_N6

--

/* Удаление просмотра Дренажа осн. плотины 2 ряда в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O6

--

/* Удаление просмотра Автоном. источн. и водосливы в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_5

--

/* Удаление просмотра Автоном. источн. и водосливы в журнале наблюдений новых данных */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_N5

--

/* Удаление просмотра Автоном. источн. и водосливы в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O5

--

/* Удаление просмотра Через агрегатные швы в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_4

--

/* Удаление просмотра Через агрегатные швы в журнале наблюдений новых данных */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_N4

--

/* Удаление просмотра Через агрегатные швы в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O4

--

/* Удаление просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_3

--

/* Удаление просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений новых данных */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_N3

--

/* Удаление просмотра Дренажа осн. плотины 1 ряда в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O3

--

/* Удаление просмотра Через швы НГ плотины в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_2

--

/* Удаление просмотра Через швы НГ плотины в журнале наблюдений новых данных */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_N2

--

/* Удаление просмотра Через швы НГ плотины в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O2

--

/* Удаление просмотра Через бетон НГ плотины в журнале наблюдений */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_1

--

/* Удаление просмотра Через бетон НГ плотины в журнале наблюдений новых данных */

DROP VIEW S_FLT_JOURNAL_OBSERVATIONS_N1

--

/* Удаление просмотра Через бетон НГ плотины в журнале наблюдений старых данных */

DROP MATERIALIZED VIEW S_FLT_JOURNAL_OBSERVATIONS_O1

--

/* Удаление функции просмотра Фильтрации в журнале наблюдений */

DROP FUNCTION GET_FLT_JOURNAL_OBSERVATIONS

--

/* Удаление типа таблицы Фильтрации журнала наблюдений */

DROP TYPE FLT_JOURNAL_OBSERVATION_TABLE 

--

/* Удаление типа объекта Фильтрация журнала наблюдений */

DROP TYPE FLT_JOURNAL_OBSERVATION_OBJECT

--

/* Фиксация изменений БД */

COMMIT
