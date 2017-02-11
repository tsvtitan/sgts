/* �������� ��������� ����������� ������ ��� �������������� */

CREATE OR REPLACE PROCEDURE CONFIRM_HND_DRAFT_BEGIN (
   JOURNAL_FIELD_ID IN INTEGER,
   ALGORITHM_ID IN INTEGER
)
AS
   APOINT_ID INTEGER;
   APARAM_ID INTEGER;
   AROUTE_ID INTEGER;
BEGIN
   SELECT POINT_ID,
          PARAM_ID
     INTO APOINT_ID,
          APARAM_ID
     FROM JOURNAL_FIELDS
    WHERE JOURNAL_FIELD_ID = CONFIRM_HND_DRAFT_BEGIN.JOURNAL_FIELD_ID;

   IF (APARAM_ID = 50008)
   THEN   /* ������ (��� �������) */
      AROUTE_ID := NULL;

      FOR INC IN (SELECT ROUTE_ID
                    FROM ROUTE_POINTS
                   WHERE POINT_ID = APOINT_ID)
      LOOP
         AROUTE_ID := INC.ROUTE_ID;
         EXIT WHEN AROUTE_ID IS NOT NULL;
      END LOOP;

      IF (AROUTE_ID IS NOT NULL)
      THEN
         IF (AROUTE_ID IN (50028, 50029))
         THEN   /* ������� 1,2 */
            CONFIRM_HND_DRAFT_BEGIN_1_2 (JOURNAL_FIELD_ID, ALGORITHM_ID);
         ELSE
            CONFIRM_HND_DRAFT_BEGIN_OTHER (JOURNAL_FIELD_ID, ALGORITHM_ID);
         END IF;
      END IF;
   END IF;
END;

--

/* �������� */

COMMIT