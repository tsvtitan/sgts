/* Удаление просмотра таблицы устройств */

DROP VIEW S_DEVICES

--

/* Удаление процедуры создания устройства */

DROP PROCEDURE I_DEVICE

--

/* Удаление процедуры изменения устройства */

DROP PROCEDURE U_DEVICE

--

/* Удаление процедуры удаления устройства */

DROP PROCEDURE D_DEVICE

--

/* Удаление последовательности для таблицы устройств */

DROP SEQUENCE SEQ_DEVICES

--

/* Удаление функции генерации для таблицы устройств */

DROP FUNCTION GET_DEVICE_ID

--

/* Удаление таблицы устройств */

DROP TABLE DEVICES

--

/* Фиксация изменений БД */

COMMIT