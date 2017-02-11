/* Добавление даты начала действия алгоритма в таблицу связи алгоритмов и видов измерения */

ALTER TABLE MEASURE_TYPE_ALGORITHMS
ADD DATE_BEGIN DATE

--

/* Установка значения для даты начала */

BEGIN
  UPDATE MEASURE_TYPE_ALGORITHMS
  SET DATE_BEGIN=TO_DATE('01.01.1960','DD.MM.YYYY');
  COMMIT;
END;

--

/* Изменение даты начала действия алгоритма */

ALTER TABLE MEASURE_TYPE_ALGORITHMS
MODIFY DATE_BEGIN NOT NULL

--

/* Добавление даты окончания алгоритма в балицу связку алгоритмов и видов измерения */

ALTER TABLE MEASURE_TYPE_ALGORITHMS
ADD DATE_END DATE

--

/* Фиксация изменений */

COMMIT