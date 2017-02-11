/* Создание просмотра суммирования расхода фильтрации по секциям 08-28 */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_SEC_08_28
AS
SELECT CYCLE_NUM,
       SECTION,
       EXPENSE
  FROM S_FLT_SUM_EXPENSE_BET
 WHERE SECTION IN ('12', '13', '17', '23', '26')
   AND COORDINATE_Z = 131
UNION
SELECT CYCLE_NUM,
       SECTION,
       EXPENSE
  FROM S_FLT_SUM_EXPENSE_SHVI
 WHERE SECTION IN ('13-14', '17-18', '22-23', '26-27', '27-28')
   AND COORDINATE_Z = 131

--

/* Фиксация изменений */

COMMIT


