unit SgtsReportModules;

interface

uses SgtsModules,
     SgtsReportModulesIntf, SgtsCoreIntf, SgtsFileReportIntf;

type

  TSgtsReportModule=class(TSgtsModule,ISgtsReportModule)
  private
    FReportIntf: ISgtsFileReport;
    FFilter: String;
    procedure InitByReport(AReportIntf: ISgtsFileReport);
    function _GetReport: ISgtsFileReport;
  protected
    procedure DoInitProc(AProc: TSgtsInitProc); override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    procedure Init; override;

    property Report: ISgtsFileReport read FReportIntf;
    property Filter: String read FFilter write FFilter;
  end;

  TSgtsReportModules=class(TSgtsModules,ISgtsReportModules)
  private
    function GetItems(Index: Integer): TSgtsReportModule;
    procedure SetItems(Index: Integer; Value: TSgtsReportModule);
  protected
    function GetModuleClass: TSgtsModuleClass; override;
  public
    property Items[Index: Integer]: TSgtsReportModule read GetItems write SetItems;
  end;

implementation

uses Windows, SysUtils,
     SgtsObj, SgtsConsts, SgtsDialogs;

{ TSgtsReportModule }

constructor TSgtsReportModule.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FReportIntf:=nil;
  InitProcName:=SInitReportProcName;
end;

procedure TSgtsReportModule.Init;
begin
  inherited Init;
  with CoreIntf.Config do begin
    FFilter:=Read(Self.Name,SConfigParamFilter,FFilter);
  end;  
end;

procedure TSgtsReportModule.InitByReport(AReportIntf: ISgtsFileReport);
begin
  FReportIntf:=AReportIntf;
end;

function TSgtsReportModule._GetReport: ISgtsFileReport;
begin
  Result:=FReportIntf;
end;

procedure TSgtsReportModule.DoInitProc(AProc: TSgtsInitProc);
begin
  AProc(CoreIntf,Self as ISgtsReportModule);
end;

{ TSgtsReportModules }

function TSgtsReportModules.GetItems(Index: Integer): TSgtsReportModule;
begin
  Result:=TSgtsReportModule(inherited Items[Index]);
end;

procedure TSgtsReportModules.SetItems(Index: Integer; Value: TSgtsReportModule);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsReportModules.GetModuleClass: TSgtsModuleClass;
begin
  Result:=TSgtsReportModule;
end;

end.
