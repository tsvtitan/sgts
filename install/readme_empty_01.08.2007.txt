1. install.avi (ролик установки)
2. uninstall.avi (ролик удаления)
3. K-Lite Codec Pack Full 2.77.exe (кодеки для роликов)
4. install.doc (документ по установке с картинками)
5. uninstall.doc (документ по удалению с картинками)
6. sgts_oracle_empty_01.08.2007.exe (новый релиз + данные начиная с 2004 года)
7. 002_create_user_sgts.sql (sql-скрипт для создания пользователя и раздачи ему прав)

Это ВАЖНО !!!

Перед установкой сделайте следующее:

1. Удалить предыдущую версию вместе с SQL-скриптами, если она установлена

2. Убедитесь что на жестком диске, на который будете устанавливать 
достаточно места. Необходимо 200 Mb.

3. Если база данных SGTS существует, необходимо удостовериться
что она создана со следующими параметрами 
(запрос: select * from nls_database_parameters):

NLS_LANGUAGE		AMERICAN
NLS_TERRITORY		AMERICA
NLS_CURRENCY		$
NLS_ISO_CURRENCY		AMERICA
NLS_NUMERIC_CHARACTERS	.,
NLS_CHARACTERSET		CL8MSWIN1251
NLS_CALENDAR		GREGORIAN
NLS_DATE_FORMAT		DD-MON-RR
NLS_DATE_LANGUAGE		AMERICAN
NLS_SORT			BINARY
NLS_TIME_FORMAT		HH.MI.SSXFF AM
NLS_TIMESTAMP_FORMAT	DD-MON-RR HH.MI.SSXFF AM
NLS_TIME_TZ_FORMAT	HH.MI.SSXFF AM TZR
NLS_TIMESTAMP_TZ_FORMAT	DD-MON-RR HH.MI.SSXFF AM TZR
NLS_DUAL_CURRENCY		$
NLS_COMP			BINARY
NLS_LENGTH_SEMANTICS	BYTE
NLS_NCHAR_CONV_EXCP	FALSE
NLS_NCHAR_CHARACTERSET	AL16UTF16

Если параметры существующей базы данных SGTS отличаются от
выше приведенных, то необходимо её пересоздать с этими параметрами.

Если база данных SGTS не существует, то необходимо её создать
используя выше приведенные параметры.

4. Создать пользователя SGTS, если его нет в базе данных,
и раздать ему права из скрипта: 002_create_user_sgts.sql

5. Установить новый релиз из файла: sgts_oracle_empty_01.08.2007.exe


Установка длится около 1-2 часа.
