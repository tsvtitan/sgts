unit SgtsOraRptReport;

interface

uses Classes, DB, ADODB, Variants, SysUtils, Contnrs, Windows,
     SgtsFileReport, SgtsReportModulesIntf, SgtsFileReportIntf, SgtsCoreIntf;

type
  TSgtsOraRptProcess=class(TObject)
  private
    FFileReport: String;
    FProgressProc: TSgtsFileReportGenerateProgressProc;
    FUserName: String;
    FPassword: String;
    FDatabase: String;
    FFileRuntime: String;
    FReportWindow: String;
    FStartupInfo: TStartupInfo;
    FProcessInformation: TProcessInformation;
    FParentWindow: THandle;
    FChildWindow: THandle;
    FOldChildWindow: THandle;

    function BuildCommandLine: String;
    function SetParentWindow: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function Execute: Boolean;

    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property Database: String read FDatabase write FDatabase;
    property FileRuntime: String read FFileRuntime write FFileRuntime;
    property FileReport: String read FFileReport write FFileReport;
    property ProgressProc: TSgtsFileReportGenerateProgressProc read FProgressProc write FProgressProc;
    property ReportWindow: String read FReportWindow write FReportWindow;
    property ParentWindow: THandle read FParentWindow write FParentWindow;
  end;

  TSgtsOraRptProcesses=class(TObjectList)
  public
    function AddProcess(const FileName: String; ProgressProc: TSgtsFileReportGenerateProgressProc=nil): TSgtsOraRptProcess;
  end;

  TSgtsOraRptReport=class(TSgtsFileReport)
  private
    FProcesses: TSgtsOraRptProcesses;
    FFileRunTime: String;
    FReportWindow: String;
  protected
    function Generate(const FileName: String; ProgressProc: TSgtsFileReportGenerateProgressProc=nil): Boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsReportModule); override;
  end;

implementation

uses StrUtils, ComObj, ShellApi, Forms,
     SgtsUtils, SgtsConsts,
     SgtsOraRptConsts, SgtsDatabaseIntf, SgtsMainFmIntf;

{ TSgtsOraRptProcess }

constructor TSgtsOraRptProcess.Create;
begin
  inherited Create;

  FillChar(FStartupInfo,SizeOf(FStartupInfo),0);
  FStartupInfo.cb:=SizeOf(TStartupInfo);
  FStartupInfo.dwFlags:=STARTF_USESHOWWINDOW;
  FStartupInfo.wShowWindow:=SW_SHOW;
end;

destructor TSgtsOraRptProcess.Destroy;
begin
  TerminateProcess(FProcessInformation.hProcess,0);
  inherited Destroy;
end;

function TSgtsOraRptProcess.BuildCommandLine: String;
begin
  Result:=Format(SCmdLineFormat,[FFileReport,FUserName,FPassword,FDatabase]);
end;

function TSgtsOraRptProcess.SetParentWindow: Boolean;
var
  WI: TWindowInfo;
  WL_STYLE: Longint;
  WL_EXSTYLE: Longint;
begin
  FChildWindow:=FindWindow(PChar(FReportWindow),nil);
  Result:=FChildWindow<>0;
  if Result then begin
    ShowWindow(FChildWindow,SW_HIDE);
    FillChar(WI,SizeOf(TWindowInfo),0);
    WI.cbSize:=SizeOf(TWindowInfo);
    GetWindowInfo(FParentWindow,WI);
    WL_EXSTYLE:=GetWindowLong(FChildWindow,GWL_EXSTYLE);
    SetWindowLong(FChildWindow,GWL_EXSTYLE,WL_EXSTYLE or WS_EX_MDICHILD);
    WL_STYLE:=GetWindowLong(FChildWindow,GCL_STYLE);
    SetWindowLong(FChildWindow,GCL_STYLE,WL_STYLE or WS_CHILD);
    SetWindowPos(FChildWindow,HWND_TOP,0,0,0,0,SWP_NOSIZE);

    FOldChildWindow:=SetParent(FChildWindow,FParentWindow);
    SetWindowPos(FChildWindow,HWND_TOP,0,0,0,0,SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE);
  end;
end;

function TSgtsOraRptProcess.Execute: Boolean;
var
  Ret: Boolean;
  CommandLine: String;
  Directory: String;
  dwExitCode: Cardinal;
  Flag: Boolean;
begin
  Result:=false;
  if FileExists(FFileRuntime) then begin
    CommandLine:=BuildCommandLine;
    Directory:=ExtractFileDir(FFileRuntime);
    Ret:=CreateProcess(PChar(FFileRuntime),PChar(CommandLine),nil,nil,true,CREATE_DEFAULT_ERROR_MODE,
                       nil,PChar(Directory),FStartupInfo,FProcessInformation);
    if Ret then begin
      dwExitCode:=STILL_ACTIVE;
      Flag:=SetParentWindow;
      while (dwExitCode=STILL_ACTIVE) and not Flag do begin
        WaitForSingleObject(FProcessInformation.hProcess,10);
        GetExitCodeProcess(FProcessInformation.hProcess,dwExitCode);
        Flag:=SetParentWindow;
        Application.ProcessMessages;
      end;
      Result:=true;      
    end;
  end;
end;

{ TSgtsOraRptProcesses }

function TSgtsOraRptProcesses.AddProcess(const FileName: String;
                                         ProgressProc: TSgtsFileReportGenerateProgressProc=nil): TSgtsOraRptProcess;
begin
  Result:=TSgtsOraRptProcess.Create;
  Result.FileReport:=FileName;
  Result.ProgressProc:=ProgressProc;
  Add(Result);
end;
     
{ TSgtsOraRptReport }

constructor TSgtsOraRptReport.Create;
begin
  inherited Create;
  FProcesses:=TSgtsOraRptProcesses.Create;
end;

destructor TSgtsOraRptReport.Destroy;
begin
  FProcesses.Free;
  inherited Destroy;
end;

procedure TSgtsOraRptReport.InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsReportModule);
begin
  inherited InitByModule(ACoreIntf,AModuleIntf);
  with ACoreIntf.Config do begin
    FFileRunTime:=Read(AModuleIntf.Name,SParamFileRuntime,FFileRunTime);
    FReportWindow:=Read(AModuleIntf.Name,SParamReportWindow,FReportWindow);
  end;  
end;

function TSgtsOraRptReport.Generate(const FileName: String; ProgressProc: TSgtsFileReportGenerateProgressProc=nil): Boolean; 
var
  Database: ISgtsDatabase;
  Process: TSgtsOraRptProcess;
begin
  Result:=false;
  Process:=FProcesses.AddProcess(FileName,ProgressProc);
  if Assigned(Process) and
    Assigned(CoreIntf) and
    Assigned(CoreIntf.MainForm) then begin
    Database:=GetDatabase;
    if Assigned(Database) then begin
      Process.UserName:=Database.DbUserName;
      Process.Password:=Database.DbPassword;
      Process.Database:=Database.DbSource;
    end;
    Process.FileRuntime:=FFileRunTime;
    Process.ReportWindow:=FReportWindow;
    Process.ParentWindow:=CoreIntf.MainForm.ClientHandle;
    Result:=Process.Execute;
  end;  
end;

end.
