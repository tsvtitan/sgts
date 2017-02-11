/* Создание просмотра суммирования расхода фильтрации по секциям 29-58 */

CREATE OR REPLACE VIEW S_FLT_SUM_EXPENSE_SEC_29_58
AS 
SELECT CYCLE_NUM,
       SECTION,
       EXPENSE
  FROM S_FLT_SUM_EXPENSE_BET
 WHERE SECTION IN ('36', '44')
   AND COORDINATE_Z = 131
UNION
SELECT CYCLE_NUM,
       SECTION,
       EXPENSE
  FROM S_FLT_SUM_EXPENSE_SHVI
 WHERE SECTION IN ('29-30', '31-32', '32-33', '35-36', '37-38', '39-40', '43-44', '44-45', '51-52', '53-54', '55-56')
   AND COORDINATE_Z = 131

--

/* Фиксация изменений */

COMMIT


