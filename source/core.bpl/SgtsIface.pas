unit SgtsIface;

interface

uses Classes, Contnrs,
     SgtsCoreObj, SgtsMenus,
     SgtsIfaceIntf, SgtsCoreIntf, SgtsConfigIntf;

type
  TSgtsIface=class;

  TSgtsIfacePermissionValues=class(TStringList)
  private
    function GetExists(Index: Integer): Boolean;
    procedure SetExists(Index: Integer; Value: Boolean);
  public
    function AddExists(const S: string; AExists: Boolean): Integer;
    property Exists[Index: Integer]: Boolean read GetExists write SetExists;
  end;

  TSgtsIfacePermission=class;

  TSgtsIfacePermissionProc=procedure (Permission: TSgtsIfacePermission; Value: String; Exists: Boolean) of object;

  TSgtsIfacePermission=class(TObject)
  private
    FName: String;
    FValues: TSgtsIfacePermissionValues;
    FProc: TSgtsIfacePermissionProc;
  public
    constructor Create;
    destructor Destroy; override;

    property Name: String read FName write FName;
    property Values: TSgtsIfacePermissionValues read FValues;
    property Proc: TSgtsIfacePermissionProc read FProc write FProc;
  end;

  TSgtsIfacePermissions=class(TObjectList)
  private
    FIface: TSgtsIface;
    FEnabled: Boolean;
    function GetItems(Index: Integer): TSgtsIfacePermission;
    procedure SetItems(Index: Integer; Value: TSgtsIfacePermission);
  public
    constructor Create(AIface: TSgtsIface); reintroduce;
    function Add(const AName: String; AProc: TSgtsIfacePermissionProc=nil): TSgtsIfacePermission;
    function AddDefault(const AName: String; AProc: TSgtsIfacePermissionProc=nil): TSgtsIfacePermission;
    function Find(const AName: String): TSgtsIfacePermission;
    property Items[Index: Integer]: TSgtsIfacePermission read GetItems write SetItems;
    property Enabled: Boolean read FEnabled write FEnabled;
  end;

  TSgtsIface=class(TSgtsCoreObj,ISgtsIface)
  private
    FPermissions: TSgtsIfacePermissions;
    FInterfaceName: String;
    FSectionName: String;
    FStoredInConfig: Boolean;
    FMenuPath: String;
    FMenuHint: String;
    FMenuIndex: Integer;
    FMenuItem: TMenuItem;
    procedure SetInterfaceName(Value: String);
    procedure SetMenuItem(Value: TMenuItem);
  protected
    property SectionName: String read FSectionName write FSectionName;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure Done; override;
    procedure WriteParam(const Param: String; Value: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true);
    function ReadParam(const Param: String; Default: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true): Variant;
    procedure ReadParams(DatabaseConfig: Boolean=true); virtual;
    procedure WriteParams(DatabaseConfig: Boolean=true); virtual;
    procedure DatabaseLink; virtual;
    procedure CheckPermissions; virtual;
    function PermissionExists(const AName, AValue: String): Boolean; overload;
    function PermissionExists(const AName: String): Boolean; overload;
    procedure AfterLogin; virtual;
    procedure BeforeReadParams; virtual;
    procedure BeforeWriteParams; virtual;
    function CanShow: Boolean; virtual;
    procedure Show; virtual;

    property Permissions: TSgtsIfacePermissions read FPermissions;
    property InterfaceName: String read FInterfaceName write SetInterfaceName;
    property StoredInConfig: Boolean read FStoredInConfig write FStoredInConfig;
    property MenuPath: String read FMenuPath write FMenuPath;
    property MenuHint: String read FMenuHint write FMenuHint;
    property MenuIndex: Integer read FMenuIndex write FMenuIndex;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
  end;

implementation

uses SysUtils,
     SgtsConsts, SgtsObj, SgtsDatabaseModulesIntf;

{ TSgtsIfacePermissionValues }

function TSgtsIfacePermissionValues.AddExists(const S: string; AExists: Boolean): Integer;
begin
  Result:=inherited AddObject(S,Pointer(Integer(AExists)));
end;

function TSgtsIfacePermissionValues.GetExists(Index: Integer): Boolean;
begin
  Result:=False;
  if Assigned(Objects[Index]) then
    Result:=Boolean(Integer(Objects[Index]));
end;

procedure TSgtsIfacePermissionValues.SetExists(Index: Integer; Value: Boolean);
begin
  Objects[Index]:=Pointer(Integer(Value));
end;

{ TSgtsIfacePermission }

constructor TSgtsIfacePermission.Create;
begin
  inherited Create;
  FValues:=TSgtsIfacePermissionValues.Create;
end;

destructor TSgtsIfacePermission.Destroy; 
begin
  FValues.Free;
  inherited Destroy;
end;

{ TSgtsIfacePermissions }

constructor TSgtsIfacePermissions.Create(AIface: TSgtsIface);
begin
  inherited Create;
  FIface:=AIface;
  FEnabled:=true;
end;

function TSgtsIfacePermissions.Find(const AName: String): TSgtsIfacePermission;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if AnsiSameText(Items[i].Name,AName) then begin
      Result:=Items[i];
      exit;
    end;
  end;
end;

function TSgtsIfacePermissions.Add(const AName: String; AProc: TSgtsIfacePermissionProc=nil): TSgtsIfacePermission;
begin
  Result:=TSgtsIfacePermission.Create;
  Result.Name:=AName;
  Result.Proc:=AProc;
  inherited Add(Result);
end;

function TSgtsIfacePermissions.AddDefault(const AName: String; AProc: TSgtsIfacePermissionProc=nil): TSgtsIfacePermission;
begin
  Result:=Add(AName,AProc);
  if Assigned(Result) then begin
    Result.Values.Add(SPermissionValueOpen);
    Result.Values.Add(SPermissionValueClose);
  end;
end;

function TSgtsIfacePermissions.GetItems(Index: Integer): TSgtsIfacePermission;
begin
  Result:=TSgtsIfacePermission(inherited Items[Index]);
end;

procedure TSgtsIfacePermissions.SetItems(Index: Integer; Value: TSgtsIfacePermission);
begin
  inherited Items[Index]:=Value;
end;

{ TSgtsIface }

constructor TSgtsIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  Name:=Copy(Name,1,Length(Name)-5);
  SectionName:=Name;
  FPermissions:=TSgtsIfacePermissions.Create(Self);
  FStoredInConfig:=true;
end;

destructor TSgtsIface.Destroy;
begin
  FPermissions.Free;
  inherited Destroy;
end;

procedure TSgtsIface.SetInterfaceName(Value: String);
begin
  FInterfaceName:=Value;
  Caption:=Value;
end;

procedure TSgtsIface.Init;
begin
  inherited Init;
end;

procedure TSgtsIface.Done;
begin
  inherited Done;
end;

procedure TSgtsIface.WriteParam(const Param: String; Value: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true);
begin
  if Assigned(CoreIntf) and FStoredInConfig then
    if DatabaseConfig then
      CoreIntf.DatabaseConfig.Write(FSectionName,Param,Value,Mode)
    else
      CoreIntf.Config.Write(FSectionName,Param,Value,Mode);
end;

function TSgtsIface.ReadParam(const Param: String; Default: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true): Variant;
begin
  Result:=Default;
  if Assigned(CoreIntf) and FStoredInConfig then
    if DatabaseConfig then
      Result:=CoreIntf.DatabaseConfig.Read(FSectionName,Param,Default,Mode)
    else
      Result:=CoreIntf.Config.Read(FSectionName,Param,Default,Mode);
end;

procedure TSgtsIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  Caption:=ReadParam(SConfigParamCaption,Caption,cmDefault,DatabaseConfig);
end;

procedure TSgtsIface.WriteParams(DatabaseConfig: Boolean=true);
begin
end;

procedure TSgtsIface.DatabaseLink;
begin
  CheckPermissions;
end;

procedure TSgtsIface.CheckPermissions;
var
  i,j: Integer;
  Perm: TSgtsIfacePermission;
begin
  with CoreIntf.DatabaseModules do begin
    if Assigned(Current) and
       Assigned(Current.Database) and
       (Trim(Caption)<>'') then begin
      CoreIntf.SplashForm.Status(Format(SCheckPermission,[Caption]));
      for i:=0 to FPermissions.Count-1 do begin
        Perm:=FPermissions.Items[i];
        for j:=0 to Perm.Values.Count-1 do begin
          if Trim(InterfaceName)<>'' then begin
            Perm.Values.Exists[j]:=Current.Database.CheckPermission(InterfaceName,Perm.Name,Perm.Values[j]);
          end else Perm.Values.Exists[j]:=True;
        end;
      end;
    end;
  end;
end;

function TSgtsIface.PermissionExists(const AName, AValue: String): Boolean;
var
  Perm: TSgtsIfacePermission;
  Index: Integer;
begin
  Result:=false;
  if Permissions.Enabled then begin
    try
      Perm:=Permissions.Find(AName);
      if Assigned(Perm) then begin
        Index:=Perm.Values.IndexOf(AValue);
        if Index<>-1 then
          Result:=Perm.Values.Exists[Index];
      end;
    except
      on E: Exception do begin
        raise;
      end;
    end;  
  end else
    Result:=true;  
end;

function TSgtsIface.PermissionExists(const AName: String): Boolean;
begin
  Result:=PermissionExists(AName,SPermissionValueOpen);
end;

procedure TSgtsIface.AfterLogin; 
begin
end;

procedure TSgtsIface.BeforeReadParams;
begin
end;

procedure TSgtsIface.BeforeWriteParams;
begin
end;

function TSgtsIface.CanShow: Boolean;
begin
  Result:=true;
end;

procedure TSgtsIface.Show;
begin
end;

procedure TSgtsIface.SetMenuItem(Value: TMenuItem);
begin
  FMenuItem:=Value;
end;

end.
