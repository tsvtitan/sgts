unit SgtsOraRpt;

interface

uses
  SgtsCoreIntf, SgtsReportModulesIntf;

procedure InitReport(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsReportModule); stdcall;

implementation

uses SysUtils, ActiveX,
     SgtsFileReport, SgtsOraRptReport, Contnrs;

var
  FReports: TSgtsFileReports;

procedure InitReport(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsReportModule); stdcall;
begin
  if Assigned(ACoreIntf) then begin
    if Assigned(AModuleIntf) then begin
      FReports.AddByModule(ACoreIntf,AModuleIntf,TSgtsOraRptReport);
    end;  
  end;
end;

initialization
  CoInitialize(nil);
  FReports:=TSgtsFileReports.Create;

finalization
  FreeAndNil(FReports);

end.
