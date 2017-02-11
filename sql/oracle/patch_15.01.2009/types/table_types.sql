/* Создание типа таблицы для критериев безопасности */

CREATE OR REPLACE TYPE CRITERIA_TABLE AS TABLE OF CRITERIA_OBJECT

--

/* Создание типа таблицы для полевого журнала фильтрации */

CREATE OR REPLACE TYPE FLT_JOURNAL_FIELD_TABLE AS TABLE OF FLT_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений фильтрации */

CREATE OR REPLACE TYPE FLT_JOURNAL_OBSERVATION_TABLE AS TABLE OF FLT_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала гидрометеорологии */

CREATE OR REPLACE TYPE GMO_JOURNAL_FIELD_TABLE AS TABLE OF GMO_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений гидромтеорологии */

CREATE OR REPLACE TYPE GMO_JOURNAL_OBSERVATION_TABLE AS TABLE OF GMO_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала гидронивелиров */

CREATE OR REPLACE TYPE HDN_JOURNAL_FIELD_TABLE AS TABLE OF HDN_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений гидронивелиров */

CREATE OR REPLACE TYPE HDN_JOURNAL_OBSERVATION_TABLE AS TABLE OF HDN_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала химанализа */

CREATE OR REPLACE TYPE HMZ_JOURNAL_FIELD_TABLE AS TABLE OF HMZ_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений химанализа */

CREATE OR REPLACE TYPE HMZ_JOURNAL_OBSERVATION_TABLE AS TABLE OF HMZ_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала индикаторов прогиба */

CREATE OR REPLACE TYPE IND_JOURNAL_FIELD_TABLE AS TABLE OF IND_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений индикаторов прогиба */

CREATE OR REPLACE TYPE IND_JOURNAL_OBSERVATION_TABLE AS TABLE OF IND_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала напряженно-деформированного состояния */

CREATE OR REPLACE TYPE NDS_JOURNAL_FIELD_TABLE AS TABLE OF NDS_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений напряженно-деформированного состояния */

CREATE OR REPLACE TYPE NDS_JOURNAL_OBSERVATION_TABLE AS TABLE OF NDS_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала нивелирования */

CREATE OR REPLACE TYPE NIV_JOURNAL_FIELD_TABLE AS TABLE OF NIV_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений нивелирования */

CREATE OR REPLACE TYPE NIV_JOURNAL_OBSERVATION_TABLE AS TABLE OF NIV_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала NMH */

CREATE OR REPLACE TYPE NMH_JOURNAL_FIELD_TABLE AS TABLE OF NMH_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для полевого журнала отвесов */

CREATE OR REPLACE TYPE OTV_JOURNAL_FIELD_TABLE AS TABLE OF OTV_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений отвесов */

CREATE OR REPLACE TYPE OTV_JOURNAL_OBSERVATION_TABLE AS TABLE OF OTV_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для измерительных точек */

CREATE OR REPLACE TYPE POINT_TABLE AS TABLE OF POINT_OBJECT

--

/* Создание типа таблицы для полевого журнала планово-высотного обоснования */

CREATE OR REPLACE TYPE PVO_JOURNAL_FIELD_TABLE AS TABLE OF PVO_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений планово-высотного обоснования */

CREATE OR REPLACE TYPE PVO_JOURNAL_OBSERVATION_TABLE AS TABLE OF PVO_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала пьезометров */

CREATE OR REPLACE TYPE PZM_JOURNAL_FIELD_TABLE AS TABLE OF PZM_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений пьезометров */

CREATE OR REPLACE TYPE PZM_JOURNAL_OBSERVATION_TABLE AS TABLE OF PZM_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для отчета критерия безопасности */

CREATE OR REPLACE TYPE REPORT_CRITERIA_TABLE AS TABLE OF REPORT_CRITERIA_OBJECT

--

/* Создание типа таблицы для полевого журнала одноосных щелемеров */

CREATE OR REPLACE TYPE SL1_JOURNAL_FIELD_TABLE AS TABLE OF SL1_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений одноосных щелемеров */

CREATE OR REPLACE TYPE SL1_JOURNAL_OBSERVATION_TABLE AS TABLE OF SL1_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала напольных щелемеров */

CREATE OR REPLACE TYPE SLF_JOURNAL_FIELD_TABLE AS TABLE OF SLF_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений напольных щелемеров */

CREATE OR REPLACE TYPE SLF_JOURNAL_OBSERVATION_TABLE AS TABLE OF SLF_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала настенных щелемеров */

CREATE OR REPLACE TYPE SLW_JOURNAL_FIELD_TABLE AS TABLE OF SLW_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений настенных щелемеров */

CREATE OR REPLACE TYPE SLW_JOURNAL_OBSERVATION_TABLE AS TABLE OF SLW_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевго журнала струнно-оптического створа */

CREATE OR REPLACE TYPE SOS_JOURNAL_FIELD_TABLE AS TABLE OF SOS_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений струнно-оптического створа */

CREATE OR REPLACE TYPE SOS_JOURNAL_OBSERVATION_TABLE AS TABLE OF SOS_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для полевого журнала температуры и влажности */

CREATE OR REPLACE TYPE TVL_JOURNAL_FIELD_TABLE AS TABLE OF TVL_JOURNAL_FIELD_OBJECT

--

/* Создание типа таблицы для журнала наблюдений температуры и влажности */

CREATE OR REPLACE TYPE TVL_JOURNAL_OBSERVATION_TABLE AS TABLE OF TVL_JOURNAL_OBSERVATION_OBJECT

--

/* Создание типа таблицы для строк */

CREATE OR REPLACE TYPE VARCHAR_TABLE AS TABLE OF VARCHAR_OBJECT

--

/* Фиксация изменений */

COMMIT
