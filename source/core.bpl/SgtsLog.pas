unit SgtsLog;

interface

uses Classes,
     SgtsCoreObj, SgtsLogIntf, SgtsCoreIntf;

type

  TSgtsLogMode=(lmDefault,lmClearOnInit);

  TSgtsLog=class(TSgtsCoreObj,ISgtsLog)
  private
    FFileStream: TFileStream;
    FFileName: String;
    FMode: TSgtsLogMode;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

    procedure Init; override;
    procedure Done; override;

    function Write(const Message: String; LogType: TSgtsLogType): Boolean;
    function WriteInfo(const Message: String): Boolean;
    function WriteError(const Message: String): Boolean;
    function WriteWarn(const Message: String): Boolean;

    procedure Clear;
  end;

implementation

uses SysUtils,
     SgtsConsts, SgtsConfigIntf, SgtsDialogs;

{ TSgtsLog }

constructor TSgtsLog.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FFileStream:=nil;
end;

destructor TSgtsLog.Destroy; 
begin
  Done;
  inherited Destroy;
end;

procedure TSgtsLog.Init;
var
  Dir: String;
begin
  inherited Init;
  Done;

  with CoreIntf.Config do begin
    FFileName:=Read(Self.Name,SConfigParamFileName,FFileName);
    FMode:=Read(Self.Name,SConfigParamMode,FMode);
  end;

  try
    if Trim(FFileName)<>'' then begin
      Dir:=ExtractFileDir(FFileName);
      if Trim(Dir)='' then
        FFileName:=ExtractFilePath(CoreIntf.CmdLine.FileName)+FFileName;

      if not FileExists(FFileName) or (FMode=lmClearOnInit) then begin
        FFileStream:=TFileStream.Create(FFileName,fmCreate);
        FreeAndNil(FFileStream);
      end;

      FFileStream:=TFileStream.Create(FFileName,fmOpenWrite or fmShareDenyNone);
      FFileStream.Position:=FFileStream.Size;
    end;  
  except
    on E: Exception do begin
      ShowError(E.Message);
    end;
  end;

end;

procedure TSgtsLog.Done;
begin
  if Assigned(FFileStream) then begin
    FreeAndNil(FFileStream);
  end;
  inherited Done;
end;

function TSgtsLog.Write(const Message: String; LogType: TSgtsLogType): Boolean;
var
  Buffer: String;
  S: string;
begin
  Result:=false;
  S:=SLogUnknown;
  case LogType of
    ltInformation: S:=SLogInformation;
    ltWarning: S:=SLogWarning;
    ltError: S:=SLogError;
  end;
  Buffer:=Format(SLogFormatMessage,[FormatDateTime(SLogFormatDateTime,Now),S,Message]);
  if Assigned(FFileStream) then begin
    Buffer:=Buffer+SLogReturn;
    FFileStream.Write(Pointer(Buffer)^,Length(Buffer));
  end;
end;

function TSgtsLog.WriteInfo(const Message: String): Boolean;
begin
  Result:=Write(Message,ltInformation);
end;

function TSgtsLog.WriteError(const Message: String): Boolean;
begin
  Result:=Write(Message,ltError);
end;

function TSgtsLog.WriteWarn(const Message: String): Boolean;
begin
  Result:=Write(Message,ltWarning);
end;

procedure TSgtsLog.Clear;
var
  Old: TSgtsLogMode;
begin
  Old:=FMode;
  try
    FMode:=lmClearOnInit;
    Init;
  finally
    FMode:=Old;
  end;  
end;

end.
