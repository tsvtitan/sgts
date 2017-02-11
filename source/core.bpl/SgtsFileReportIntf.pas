unit SgtsFileReportIntf;

interface

type

  TSgtsFileReportGenerateProgressProc=procedure (Min, Max, Position: Integer; var Breaked: Boolean) of object;

  ISgtsFileReport=interface
  ['{8F602A40-4111-4669-B9F0-FA9C6FDB9A59}']
  { methods }
    function Generate(const FileName: String; ProgressProc: TSgtsFileReportGenerateProgressProc=nil): Boolean;
  end;

implementation

end.
