/* �������� ��������� ��������� ��������� � ������������������ � ������� ���������� */

CREATE OR REPLACE VIEW S_SLF_JOURNAL_OBSERVATIONS_GMO
AS
  SELECT SLF.*,
         GMO.UVB, 
		 GMO.UNB,
		 GMO.T_AIR,
		 GMO.T_WATER AS GMO_T_WATER,
		 GMO.RAIN_DAY,
		 GMO.PREC,
		 GMO.PREC_NAME,
		 GMO.UNSET,
		 GMO.INFLUX,
		 GMO.V_VAULT,
		 GMO.UVB_INC,
		 GMO.RAIN_YEAR,
		 GMO.T_AIR_10,
		 GMO.T_AIR_30
    FROM S_SLF_JOURNAL_OBSERVATIONS SLF, S_GMO_JOURNAL_OBSERVATIONS GMO
   WHERE SLF.DATE_OBSERVATION=GMO.DATE_OBSERVATION (+)

--

/* �������� ��������� �� */

COMMIT