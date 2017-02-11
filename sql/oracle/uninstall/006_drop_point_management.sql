/* Удаление последовательности для ввода измерительных точек */

DROP SEQUENCE SEQ_POINT_MANAGEMENT

--

/* Удаление функции генерации для ввода измерительных точек */

DROP FUNCTION GET_POINT_MANAGEMENT_ID

--

/* Фиксация изменений БД */

COMMIT
