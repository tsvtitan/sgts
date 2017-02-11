unit SgtsReportModulesIntf;

interface

uses SgtsModulesIntf, SgtsFileReportIntf;

type

  ISgtsReportModule=interface(ISgtsModule)
  ['{3F24FA06-0141-4F72-9C6D-9D6E0327BFA7}']
  { methods }
    procedure InitByReport(AReportIntf: ISgtsFileReport);

  { properties }
    function _GetReport: ISgtsFileReport;

    property Report: ISgtsFileReport read _GetReport;
  end;

  ISgtsReportModules=interface(ISgtsModules)
  ['{7DB7910B-5775-4730-9726-6506A11DE53A}']
  end;

implementation

end.
