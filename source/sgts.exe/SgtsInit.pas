unit SgtsInit;

interface

uses SgtsCoreIntf;

procedure InitCore;

var
  FCoreIntf: ISgtsCore;

implementation

uses Windows, Classes, SysUtils, Forms, ComServ, Dialogs, Controls,
     SgtsCore, SgtsConsts, SgtsDialogs;

var
  FCore: TSgtsCore;

procedure InitCoreStandalone;
var
  ConfigFile: String;
begin
  with FCoreIntf do begin

    ConfigFile:='';

    SetCurrentDir(ExtractFileDir(CmdLine.FileName));

    if CmdLine.ParamExists(SParamConfig) then
      ConfigFile:=CmdLine.ValueByParam(SParamConfig)
    else ConfigFile:=ChangeFileExt(CmdLine.FileName,SExtensionIni);

    if not FileExists(ConfigFile) then begin;
      if ShowQuestion(Format(SQuestionFindConfig,[ConfigFile]),mbNo)=mrYes then begin
        with TOpenDialog.Create(nil) do begin
          try
            DefaultExt:=SExtensionIni;
            Filter:=SFilterIni;
            InitialDir:=ExtractFileDir(CmdLine.FileName);
            if Execute then begin
              ConfigFile:=FileName;
            end;
          finally
            Free;
          end;
        end;
      end;
    end;

    if FileExists(ConfigFile) then begin;
      Config.LoadFromFile(ConfigFile);
      if not Exists then begin
        Init;
        try
          Start;
          Stop;
        finally
          Done;
        end;
      end else
        ShowWarning(Format(SApplicationAlreadyExists,[Title]));
      Config.SaveToFile(ConfigFile);
    end;
    
  end;
end;

procedure InitCoreAutomation;
var
  Msg: TMsg;
begin
  try
    FCoreIntf.Init;
    FCoreIntf.Start;
    while GetMessage(Msg,0,0,0) do begin
      DispatchMessage(Msg);
    end;
    FCoreIntf.Stop;
  finally
    FCoreIntf.Done;
  end;
end;


procedure InitCoreOther;
begin
  try
    FCoreIntf.Init;
    FCoreIntf.Start;
    FCoreIntf.Stop;
  finally
    FCoreIntf.Done;
  end;
end;

procedure InitCore;
begin
  case ComServer.StartMode of
    smStandalone: InitCoreStandalone;
    smAutomation: InitCoreAutomation;
  else
    InitCoreOther;
  end;
end;

initialization
  FCore:=TSgtsCore.Create;
  FCoreIntf:=FCore as ISgtsCore;

finalization
  FCoreIntf:=nil;
  FreeAndNil(FCore);

end.
