unit SgtsDatabase;

interface

uses Classes, Contnrs,
     SgtsProviders, SgtsRoles, SgtsGetRecordsConfig, SgtsExecuteConfig,
     SgtsCDS, SgtsLogIntf, SgtsCoreIntf,
     SgtsDatabaseIntf, SgtsDatabaseModulesIntf;

type
  TSgtsDatabaseGetRecordsFilterGroupType=(fgtDefault,fgtWithin);

  TSgtsDatabase=class(TComponent,ISgtsDatabase)
  private
    FModuleIntf: ISgtsDatabaseModule;
    FCoreIntf: ISgtsCore;
    FAccount: String;
    FAccountId: Variant;
    FDbUserName: String;
    FDbPassword: String;
    FDbSource: String;
    FPassword: String;
    FPersonnel: String;
    FPersonnelId: Variant;
    FPersonnelFirstName: String;
    FPersonnelSecondName: String;
    FPersonnelLastName: String;
    FGetRecordsProviders: TSgtsGetRecordsProviders;
    FExecuteProviders: TSgtsExecuteProviders;
    FRoles: TSgtsRoles;
    FInited: Boolean;
    FConnectionParams: TSgtsCDS;

    function _GetAccount: String;
    function _GetAccountId: Variant;
    function _GetConnected: Boolean;
    function _GetPersonnel: String;
    function _GetPersonnelId: Variant;
    function _GetPersonnelFirstName: String;
    function _GetPersonnelSecondName: String;
    function _GetPersonnelLastName: String;
    function _GetDbUserName: String;
    function _GetDbPassword: String;
    function _GetDbSource: String;
    function _GetExecuteProviders: TSgtsExecuteProviders;
    function _GetRecordsProviders: TSgtsGetRecordsProviders;

    function GetRecords(const Provider: String; Config: TSgtsGetRecordsConfig; ProgressProc: TSgtsDatabaseProgressProc=nil): OleVariant; overload;
    function GetNewId(const Provider: String): Variant; overload;
    procedure Execute(const Provider: String; Config: TSgtsExecuteConfig); overload;
    function GetConnectionParams: String; 
  protected
    function GetGetRecordsProvidersClass: TSgtsGetRecordsProvidersClass; virtual;
    function GetExecuteProviders: TSgtsExecuteProvidersClass; virtual;
    function GetConnected: Boolean; virtual;

    procedure AddConnectionParam(const AName, ADescription: String; AValue: String);
    procedure ReplaceConnectionParam(const AName, ADescription: String; AValue: String);

    property ConnectionParams: TSgtsCDS read FConnectionParams;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsDatabaseModule); virtual;

    function GetRecordsFieldName(Provider: TSgtsGetRecordsProvider; FieldName: TSgtsGetRecordsConfigFieldName): String; virtual;
    function GetRecordsFieldNames(Provider: TSgtsGetRecordsProvider; FieldNames: TSgtsGetRecordsConfigFieldNames): String; virtual;
    function GetRecordsParams(Params: TSgtsGetRecordsConfigParams): String; virtual;
    function GetRecordsFilterOperator(Operator: TSgtsGetRecordsConfigFilterOperator): string; virtual;
    function GetRecordsFilterCondition(Condition: TSgtsGetRecordsConfigFilterCondition): string; virtual;
    function GetRecordsFilterFieldName(Filter: TSgtsGetRecordsConfigFilter; CheckCase: Boolean): string; virtual;
    function GetRecordsFilterDateValue(Value: TDateTime): String; virtual;
    function GetRecordsFilterValue(Filter: TSgtsGetRecordsConfigFilter; var FieldName: string; var Exists: Boolean): string; virtual;
    function GetRecordsFilterGroupDefault(FilterGroup: TSgtsGetRecordsConfigFilterGroup; Fields: TStringList=nil): string; virtual;
    function GetRecordsFilterGroupWithIn(FilterGroup: TSgtsGetRecordsConfigFilterGroup; Fields: TStringList=nil): string; virtual;
    function GetRecordsFilterGroupType(FilterGroup: TSgtsGetRecordsConfigFilterGroup): TSgtsDatabaseGetRecordsFilterGroupType; virtual;
    function GetRecordsFilterGroup(FilterGroup: TSgtsGetRecordsConfigFilterGroup; Fields: TStringList=nil): String; virtual;
    function GetRecordsFilterGroups(FilterGroups: TSgtsGetRecordsConfigFilterGroups; Fields: TStringList=nil): String; virtual;
    function GetRecordsGroups(Provider: TSgtsGetRecordsProvider; FieldNames: TSgtsGetRecordsConfigFieldNames): string; virtual;
    function GetRecordsOrderType(OrderType: TSgtsGetRecordsConfigOrderType): string; virtual;
    function GetRecordsOrders(Orders: TSgtsGetRecordsConfigOrders): string; virtual;
    function GetExecuteInsertFieldNames(Params: TSgtsExecuteConfigParams): String; virtual;
    function GetExecuteInsertParams(Params: TSgtsExecuteConfigParams): String; virtual;
    function GetExecuteUpdateFieldParams(Params: TSgtsExecuteConfigParams): String; virtual;
    function GetExecuteParamFieldName(Param: TSgtsExecuteConfigParam): String; virtual;
    function GetExecuteUpdateFieldKeys(Params: TSgtsExecuteConfigParams): String; virtual;
    function GetExecuteDeleteFieldKeys(Params: TSgtsExecuteConfigParams): String; virtual;
    
    function Login(const Account, Password: String): Boolean; virtual;
    procedure Logout; virtual;
    function CheckPermission(const InterfaceName, Permission, Value: String): Boolean; virtual;
    function GetRecords(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig;
                        ProgressProc: TSgtsDatabaseProgressProc=nil): OleVariant; overload; virtual;
    function GetNewId(Provider: TSgtsExecuteProvider): Variant; overload; virtual;
    procedure Execute(Provider: TSgtsExecuteProvider; Config: TSgtsExecuteConfig); overload; virtual;
    function LoginDefault(Params: String): Boolean; virtual;
    procedure LogoutDefault; virtual;
    function Install(Value: String; InstallType: TSgtsDatabaseInstallType; ProgressProc: TSgtsDatabaseProgressProc=nil): Boolean; virtual;
    function ProviderExists(const Provider: String): Boolean; virtual;
    function Export(Value: String; ExportType: TSgtsDatabaseExportType; ProgressProc: TSgtsDatabaseProgressProc=nil): String; virtual;
    procedure RefreshPermissions; virtual;
    procedure LoadConfig(Stream: TStream); virtual;
    procedure SaveConfig(Stream: TStream); virtual;
    procedure ProgressByProc(ProgressProc: TSgtsDatabaseProgressProc; Min,Max,Position: Integer; var Breaked: Boolean); virtual;

    function CreateDefaultGetRecordsData: OleVariant;
    function LogWrite(const Message: String; LogType: TSgtsLogType=ltInformation): Boolean;

    property ModuleIntf: ISgtsDatabaseModule read FModuleIntf;
    property CoreIntf: ISgtsCore read FCoreIntf;
    property Account: String read FAccount write FAccount;
    property Password: String read FPassword write FPassword;
    property AccountId: Variant read FAccountId write FAccountId;
    property Personnel: String read FPersonnel write FPersonnel;
    property PersonnelId: Variant read FPersonnelId write FPersonnelId;
    property PersonnelFirstName: String read FPersonnelFirstName write FPersonnelFirstName;
    property PersonnelSecondName: String read FPersonnelSecondName write FPersonnelSecondName;
    property PersonnelLastName: String read FPersonnelLastName write FPersonnelLastName;

    property DbUserName: String read FDbUserName write FDbUserName;
    property DbPassword: String read FDbPassword write FDbPassword;
    property DbSource: String read FDbSource write FDbSource;
    property GetRecordsProviders: TSgtsGetRecordsProviders read FGetRecordsProviders;
    property ExecuteProviders: TSgtsExecuteProviders read FExecuteProviders;
    property Roles: TSgtsRoles read FRoles;
    property Inited: Boolean read FInited;
  end;

  TSgtsDatabaseClass=class of TSgtsDatabase;

  TSgtsDatabases=class(TObjectList)
  private
    function GetItem(Index: Integer): TSgtsDatabase;
    procedure SetItem(Index: Integer; Value: TSgtsDatabase);
  public
    function AddByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsDatabaseModule; AClass: TSgtsDatabaseClass): TSgtsDatabase;
    property Items[Index: Integer]: TSgtsDatabase read GetItem write SetItem;
  end;

implementation

uses SysUtils, Variants, DB, DBClient,
     SgtsUtils, SgtsConsts;

{ TSgtsDatabase }

constructor TSgtsDatabase.Create;
begin
  inherited Create(nil);
  FGetRecordsProviders:=GetGetRecordsProvidersClass.Create;
  FExecuteProviders:=GetExecuteProviders.Create;
  FRoles:=TSgtsRoles.Create;
  FConnectionParams:=TSgtsCDS.Create(nil);
  with FConnectionParams do begin
    FieldDefs.Clear;
    FieldDefs.Add(SDb_Name,ftString,150);
    FieldDefs.Add(SDb_Description,ftString,250);
    FieldDefs.Add(SDb_Value,ftBlob);
    CreateDataSet;
  end;
end;

destructor TSgtsDatabase.Destroy;
begin
  FModuleIntf:=nil;
  FCoreIntf:=nil;
  FConnectionParams:=nil;
  FRoles.Free;
  FExecuteProviders.Free;
  FGetRecordsProviders.Free;
  inherited Destroy;
end;

function TSgtsDatabase.GetConnected: Boolean;
begin
  Result:=false;
end;

function TSgtsDatabase.GetGetRecordsProvidersClass: TSgtsGetRecordsProvidersClass;
begin
  Result:=TSgtsGetRecordsProviders;
end;

function TSgtsDatabase.GetExecuteProviders: TSgtsExecuteProvidersClass;
begin
  Result:=TSgtsExecuteProviders;
end;

function TSgtsDatabase._GetAccount: String;
begin
  Result:=FAccount;
end;

function TSgtsDatabase._GetAccountId: Variant;
begin
  Result:=FAccountId;
end;

function TSgtsDatabase._GetConnected: Boolean;
begin
  Result:=GetConnected;
end;

function TSgtsDatabase._GetPersonnel: String;
begin
  Result:=FPersonnel;
end;

function TSgtsDatabase._GetPersonnelId: Variant;
begin
  Result:=FPersonnelId;
end;

function TSgtsDatabase._GetPersonnelFirstName: String;
begin
  Result:=FPersonnelFirstName;
end;

function TSgtsDatabase._GetPersonnelSecondName: String;
begin
  Result:=FPersonnelSecondName;
end;

function TSgtsDatabase._GetPersonnelLastName: String;
begin
  Result:=FPersonnelLastName;
end;

function TSgtsDatabase._GetDbUserName: String;
begin
  Result:=FDbUserName;
end;

function TSgtsDatabase._GetDbPassword: String;
begin
  Result:=FDbPassword;
end;

function TSgtsDatabase._GetDbSource: String;
begin
  Result:=FDbSource;
end;

function TSgtsDatabase._GetExecuteProviders: TSgtsExecuteProviders;
begin
  Result:=FExecuteProviders;
end;

function TSgtsDatabase._GetRecordsProviders: TSgtsGetRecordsProviders;
begin
  Result:=FGetRecordsProviders;
end;

procedure TSgtsDatabase.InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsDatabaseModule);
begin
  FCoreIntf:=ACoreIntf;
  FModuleIntf:=AModuleIntf;
  FModuleIntf.InitByDatabase(Self as ISgtsDatabase);
  if not FInited then begin
    FInited:=true;
  end else begin
    LogWrite(SOnlyOneInit,ltError);
    raise Exception.Create(SOnlyOneInit);
  end;  
end;

function TSgtsDatabase.CreateDefaultGetRecordsData: OleVariant;
var
  DSOut: TSgtsCDS;
begin
  DSOut:=TSgtsCDS.Create(nil);
  try
    with DSOut do begin
      FieldDefs.Add('ID',ftString,1);
      CreateDataSet;
      Result:=Data;
    end;
  finally
    DSOut.Free;
  end;
end;

function TSgtsDatabase.Login(const Account, Password: String): Boolean;
begin
  Result:=false;
end;

procedure TSgtsDatabase.Logout;
begin
end;

function TSgtsDatabase.CheckPermission(const InterfaceName, Permission, Value: String): Boolean;
begin
  Result:=false;
end;

function TSgtsDatabase.GetRecordsFieldName(Provider: TSgtsGetRecordsProvider; FieldName: TSgtsGetRecordsConfigFieldName): String;
begin
  Result:=FieldName.Name;
  case FieldName.FuncType of
    fftSum: begin
      Result:='SUM('+Result+') AS '+Result;
    end;
  end;
end;

function TSgtsDatabase.GetRecordsFieldNames(Provider: TSgtsGetRecordsProvider; FieldNames: TSgtsGetRecordsConfigFieldNames): String;
var
  i: Integer;
  Flag: Boolean;
  S: String;
begin
  Result:='';
  Flag:=false;
  if FieldNames.Count>0 then begin
    for i:=0 to FieldNames.Count-1 do begin
      S:=GetRecordsFieldName(Provider,FieldNames.Items[i]);
      if Trim(S)<>'' then begin
        if not Flag then begin
          Result:=S;
          Flag:=true;
        end else
          Result:=Result+','+S;
      end;    
    end;
  end else begin
    Result:=Format('%s.%s',[Provider.Alias,SAsterisk]);
  end;
end;

function TSgtsDatabase.GetRecordsParams(Params: TSgtsGetRecordsConfigParams): String; 
var
  i: Integer;
begin
  Result:='';
  for i:=0 to Params.Count-1 do begin
    if i=0 then
      Result:=':'+Params.Items[i].ParamName
    else
      Result:=Result+',:'+Params.Items[i].ParamName;
  end;
  if Trim(Result)<>'' then
    Result:='('+Result+')';
end;

function TSgtsDatabase.GetRecordsFilterOperator(Operator: TSgtsGetRecordsConfigFilterOperator): string;
begin
  Result:='';
  case Operator of
    foAnd: Result:='AND';
    foOr: Result:='OR';
  end;
end;

function TSgtsDatabase.GetRecordsFilterCondition(Condition: TSgtsGetRecordsConfigFilterCondition): string;
begin
  Result:='';
  case Condition of
    fcEqual: Result:='=';
    fcGreater: Result:='>';
    fcLess: Result:='<';
    fcNotEqual: Result:='<>';
    fcEqualGreater: Result:='>=';
    fcEqualLess: Result:='<=';
    fcLike: Result:='LIKE';
    fcNotLike: Result:='NOT LIKE';
    fcIsNull: Result:='IS NULL';
    fcIsNotNull: Result:='IS NOT NULL';
  end;
end;

function TSgtsDatabase.GetRecordsFilterFieldName(Filter: TSgtsGetRecordsConfigFilter; CheckCase: Boolean): string;
begin
  if CheckCase then
    Result:=Filter.FieldName
  else
    Result:='UPPER('+Filter.FieldName+')';
end;

function TSgtsDatabase.GetRecordsFilterDateValue(Value: TDateTime): String;
begin
  Result:=QuotedStr(DateTimeToStr(Value));
end;

function TSgtsDatabase.GetRecordsFilterValue(Filter: TSgtsGetRecordsConfigFilter; var FieldName: string; var Exists: Boolean): string;
var
  S: String;
begin
  Result:='';
  FieldName:=GetRecordsFilterFieldName(Filter,true);

  if not (Filter.Condition in [fcIsNull,fcIsNotNull]) then begin
    if VarType(Filter.Value) in [varEmpty,varNull,varUnknown] then
      exit
    else Exists:=true;
  end else begin
    Exists:=true;
    exit;
  end;

  case VarType(Filter.Value) of
    varSingle,varDouble,varCurrency: begin
      S:=VarToStr(Filter.Value);
      Result:=ChangeChar(S,',','.');
    end;
    varOleStr,varStrArg,varString: begin
      Result:=VarToStr(Filter.Value);
      FieldName:=GetRecordsFilterFieldName(Filter,Filter.CheckCase);
      if not Filter.CheckCase then
        Result:=AnsiUpperCase(Result);
      case Filter.Condition of
        fcLike,fcNotLike: begin
          if Filter.RightSide then
            Result:='%'+Result;
          if Filter.LeftSide then
            Result:=Result+'%';
          Result:=QuotedStr(Result);
        end;
      else
        Result:=QuotedStr(Result);
      end;
    end;
    varDate: begin
      Result:=GetRecordsFilterDateValue(Filter.Value);
    end;
    else begin
      Result:=VarToStr(Filter.Value);
    end;
  end;
end;

function TSgtsDatabase.GetRecordsFilterGroupDefault(FilterGroup: TSgtsGetRecordsConfigFilterGroup; Fields: TStringList=nil): string;
var
  i: Integer;
  S: string;
  FieldName: string;
  Exists: Boolean;
  FlagFirst: Boolean;
  AFilter: TSgtsGetRecordsConfigFilter;
begin
  Result:='';
  FlagFirst:=false;
  for i:=0 to FilterGroup.Filters.Count-1 do begin
    AFilter:=FilterGroup.Filters.Items[i];
    case AFilter.FilterType of
      ftFieldName: begin
        Exists:=false;
        S:=GetRecordsFilterValue(AFilter,FieldName,Exists);
        if Assigned(Fields) then
          Exists:=Exists and (Fields.IndexOf(AFilter.FieldName)<>-1);
        if Exists then begin 
          S:=Trim(FieldName+' '+GetRecordsFilterCondition(AFilter.Condition)+' '+S);
          if not FlagFirst then begin
            Result:=S;
            FlagFirst:=Trim(S)<>'';
          end else
            if Trim(S)<>'' then
              Result:=Result+' '+GetRecordsFilterOperator(AFilter.Operator)+' '+S;
        end;
      end;
      ftSQL: begin
        Result:=Trim(VarToStrDef(AFilter.Value,''));
      end;
    end;
  end;
end;

function TSgtsDatabase.GetRecordsFilterGroupWithIn(FilterGroup: TSgtsGetRecordsConfigFilterGroup; Fields: TStringList=nil): string;
var
  i: Integer;
  S: string;
  FieldName: string;
  Exists: Boolean;
  FlagFirst: Boolean;
  AFilter: TSgtsGetRecordsConfigFilter;
begin
  Result:='';
  FlagFirst:=false;
  for i:=0 to FilterGroup.Filters.Count-1 do begin
    AFilter:=FilterGroup.Filters.Items[i];
    S:=GetRecordsFilterValue(AFilter,FieldName,Exists);
    if Assigned(Fields) then
      Exists:=Exists and (Fields.IndexOf(AFilter.FieldName)<>-1);
    if Exists then begin
      if not FlagFirst then begin
        Result:=S;
        FlagFirst:=Trim(S)<>'';
      end else
        if Trim(S)<>'' then
          Result:=Result+','+S;
    end;
  end;
  if (Trim(Result)<>'') and (Trim(FieldName)<>'') then
    Result:=FieldName+' IN ('+Trim(Result)+')';
end;

function TSgtsDatabase.GetRecordsFilterGroupType(FilterGroup: TSgtsGetRecordsConfigFilterGroup): TSgtsDatabaseGetRecordsFilterGroupType;
var
  i: Integer;
  AFilter: TSgtsGetRecordsConfigFilter;
  OldFieldName: String;
  FlagFieldName: Boolean;
  FlagConditionEqual: Boolean;
  FlagOperatorOr: Boolean;
begin
  Result:=fgtDefault;

  if FilterGroup.Filters.Count>2 then begin
    FlagFieldName:=true;
    FlagConditionEqual:=true;
    FlagOperatorOr:=true;
    for i:=0 to FilterGroup.Filters.Count-1 do begin
      AFilter:=FilterGroup.Filters.Items[i];
      if (i>0) and not AnsiSameText(AFilter.FieldName,OldFieldName) then begin
        FlagFieldName:=false;
        break;
      end;
      if AFilter.Condition<>fcEqual then begin
        FlagConditionEqual:=false;
        break;
      end;
      if (i>0) and (AFilter.Operator<>foOr) then begin
        FlagOperatorOr:=false;
        break;
      end;
      OldFieldName:=AFilter.FieldName;
    end;

    Result:=iff(FlagFieldName and FlagConditionEqual and FlagOperatorOr,fgtWithin,Result);
  end;  
end;

function TSgtsDatabase.GetRecordsFilterGroup(FilterGroup: TSgtsGetRecordsConfigFilterGroup; Fields: TStringList=nil): String;
var
  FilterGroupType: TSgtsDatabaseGetRecordsFilterGroupType;
begin
  Result:='';
  FilterGroupType:=GetRecordsFilterGroupType(FilterGroup);
  case FilterGroupType of
    fgtDefault: begin
      Result:=GetRecordsFilterGroupDefault(FilterGroup,Fields);
    end;
    fgtWithin: begin
      Result:=GetRecordsFilterGroupWithIn(FilterGroup,Fields);
    end;
  end;    
  if Trim(Result)<>'' then
    Result:='('+Result+')';
end;

function TSgtsDatabase.GetRecordsFilterGroups(FilterGroups: TSgtsGetRecordsConfigFilterGroups; Fields: TStringList=nil): String;
var
  i: Integer;
  S: String;
  FlagFirst: Boolean;
  Group: TSgtsGetRecordsConfigFilterGroup;
begin
  Result:='';
  FlagFirst:=false;
  for i:=0 to FilterGroups.Count-1 do begin
    Group:=FilterGroups.Items[i];
    if Group.Enabled then begin
      S:=GetRecordsFilterGroup(Group,Fields);
      if not FlagFirst then begin
        Result:=S;
        FlagFirst:=Trim(S)<>'';
      end else
        if Trim(S)<>'' then
          Result:=Result+' '+GetRecordsFilterOperator(Group.Operator)+' '+S;
    end;          
  end;
  if Trim(Result)<>'' then
    Result:='WHERE '+Trim(Result);
end;

function TSgtsDatabase.GetRecordsGroups(Provider: TSgtsGetRecordsProvider; FieldNames: TSgtsGetRecordsConfigFieldNames): string;

  function GroupFunctionExists: Boolean;
  var
    i: Integer;
    Item: TSgtsGetRecordsConfigFieldName;
  begin
    Result:=false;
    for i:=0 to FieldNames.Count-1 do begin
      Item:=FieldNames.Items[i];
      if Item.FuncType<>fftNone then begin
        Result:=true;
        exit;
      end;
    end;  
  end;

var
  i: Integer;
  Item: TSgtsGetRecordsConfigFieldName;
  S: String;
  FlagFirst: Boolean;
begin
  Result:='';
  if GroupFunctionExists then begin
    FlagFirst:=false;
    for i:=0 to FieldNames.Count-1 do begin
      Item:=FieldNames.Items[i];
      if Item.FuncType=fftNone then begin
        S:=GetRecordsFieldName(Provider,Item);
        if Trim(S)<>'' then begin
          if not FlagFirst then begin
            Result:=S;
            FlagFirst:=true;
          end else begin
            Result:=Result+','+S;
          end;
        end;
      end;
    end;
    if Trim(Result)<>'' then
      Result:='GROUP BY '+Result;
  end;     
end;

function TSgtsDatabase.GetRecordsOrderType(OrderType: TSgtsGetRecordsConfigOrderType): string;
begin
  Result:='';
  case OrderType of
    otAsc: Result:='ASC';
    otDesc: Result:='DESC';
  end;
end;

function TSgtsDatabase.GetRecordsOrders(Orders: TSgtsGetRecordsConfigOrders): string;
var
  i: Integer;
  Flag: Boolean;
begin
  Result:='';
  Flag:=false;
  for i:=0 to Orders.Count-1 do begin
    if Orders.Items[i].OrderType in [otAsc,otDesc] then begin
      if not Flag then
        Result:=Orders.Items[i].FieldName+' '+GetRecordsOrderType(Orders.Items[i].OrderType)
      else
        Result:=Result+','+Orders.Items[i].FieldName+' '+GetRecordsOrderType(Orders.Items[i].OrderType);
      Flag:=true;  
    end;        
  end;
  if Trim(Result)<>'' then
    Result:='ORDER BY '+Result;
end;

function TSgtsDatabase.GetRecords(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig; ProgressProc: TSgtsDatabaseProgressProc=nil): OleVariant;
begin
  Result:=CreateDefaultGetRecordsData;
end;

function TSgtsDatabase.GetRecords(const Provider: String; Config: TSgtsGetRecordsConfig; ProgressProc: TSgtsDatabaseProgressProc=nil): OleVariant;
var
  AProvider: TSgtsGetRecordsProvider;
begin
  Result:=CreateDefaultGetRecordsData;
  AProvider:=FGetRecordsProviders.Find(Provider);
  if Assigned(AProvider) then begin
    if Assigned(AProvider.Proc) then
      Result:=AProvider.Proc(AProvider,Config,ProgressProc)
    else
      Result:=GetRecords(AProvider,Config,ProgressProc);
  end else begin
    if not Config.CheckProvider then begin
      AProvider:=FGetRecordsProviders.AddDefault(Provider);
      if Assigned(AProvider) then begin
        try
          Result:=GetRecords(AProvider,Config,ProgressProc);
        finally
          FGetRecordsProviders.Remove(AProvider);
        end;
      end;
    end else begin
      LogWrite(Format(SProviderNotFound,[Provider]),ltError);
      raise Exception.CreateFmt(SProviderNotFound,[Provider]);
    end;  
  end;
end;

function TSgtsDatabase.GetNewId(Provider: TSgtsExecuteProvider): Variant; 
begin
  Result:=Null;
end;

function TSgtsDatabase.GetNewId(const Provider: String): Variant; 
var
  AProvider: TSgtsExecuteProvider;
begin
  Result:=Null;
  AProvider:=FExecuteProviders.Find(Provider);
  if Assigned(AProvider) then begin
    Result:=GetNewId(AProvider);
  end else begin
    AProvider:=FExecuteProviders.AddDefault(Provider);
    if Assigned(AProvider) then begin
      try
        Result:=GetNewId(AProvider);
      finally
        FExecuteProviders.Remove(AProvider);
      end;
    end;
  end;
end;

function TSgtsDatabase.GetExecuteInsertFieldNames(Params: TSgtsExecuteConfigParams): String; 
var
  i: Integer;
begin
  Result:='';
  for i:=0 to Params.Count-1 do begin
    if i=0 then
      Result:=Params.Items[i].ParamName
    else
      Result:=Result+','+Params.Items[i].ParamName;
  end;
  if Trim(Result)<>'' then
    Result:='('+Result+')';
end;

function TSgtsDatabase.GetExecuteInsertParams(Params: TSgtsExecuteConfigParams): String;
var
  i: Integer;
  Param: TSgtsExecuteConfigParam;
begin
  Result:='';
  for i:=0 to Params.Count-1 do begin
    Param:=Params.Items[i];
    if i=0 then
      Result:=':'+Param.ParamName
    else
      Result:=Result+',:'+Param.ParamName;
  end;
  if Trim(Result)<>'' then
    Result:='('+Result+')';
end;

function TSgtsDatabase.GetExecuteUpdateFieldParams(Params: TSgtsExecuteConfigParams): String;
var
  i: Integer;
  First: Boolean;
  Param: TSgtsExecuteConfigParam;
begin
  Result:='';
  First:=true;
  for i:=0 to Params.Count-1 do begin
    Param:=Params.Items[i];
    if not Param.IsKey and not Assigned(Params.FindKey(Param.ParamName)) then begin
      if First then
        Result:=Param.ParamName+'=:'+Param.ParamName
      else
        Result:=Result+', '+Param.ParamName+'=:'+Param.ParamName;
      First:=false;  
    end;    
  end;
end;

function TSgtsDatabase.GetExecuteParamFieldName(Param: TSgtsExecuteConfigParam): String; 
begin
  Result:=Param.ParamName;
  if Param.IsKey then
    Result:='OLD_'+Result;
end;

function TSgtsDatabase.GetExecuteUpdateFieldKeys(Params: TSgtsExecuteConfigParams): String;
var
  i: Integer;
  First: Boolean;
  Param: TSgtsExecuteConfigParam;
begin
  Result:='';
  First:=true;
  for i:=0 to Params.Count-1 do begin
    Param:=Params.Items[i];
    if Param.IsKey then begin
      if First then
        Result:=Param.ParamName+'=:'+GetExecuteParamFieldName(Param)
      else
        Result:=Result+' AND '+Param.ParamName+'=:'+GetExecuteParamFieldName(Param);
      First:=false;  
    end;    
  end;
  if Trim(Result)<>'' then
    Result:='('+Result+')';
end;

function TSgtsDatabase.GetExecuteDeleteFieldKeys(Params: TSgtsExecuteConfigParams): String;
begin
  Result:=GetExecuteUpdateFieldKeys(Params);
end;

procedure TSgtsDatabase.Execute(Provider: TSgtsExecuteProvider; Config: TSgtsExecuteConfig); 
begin
end;

procedure TSgtsDatabase.Execute(const Provider: String; Config: TSgtsExecuteConfig);
var
  AProvider: TSgtsExecuteProvider;
begin
  AProvider:=FExecuteProviders.Find(Provider);
  if Assigned(AProvider) then begin
    Execute(AProvider,Config);
  end else begin
    if not Config.CheckProvider then begin
      AProvider:=FExecuteProviders.AddDefault(Provider);
      if Assigned(AProvider) then begin
        try
          Execute(AProvider,Config);
        finally
          FExecuteProviders.Remove(AProvider);
        end;
      end;
    end else begin
      LogWrite(Format(SProviderNotFound,[Provider]),ltError);
      raise Exception.CreateFmt(SProviderNotFound,[Provider]);
    end;
  end;
end;

function TSgtsDatabase.GetConnectionParams: String;
begin
  FConnectionParams.MergeChangeLog;
  Result:=FConnectionParams.XMLData;
end;

procedure TSgtsDatabase.AddConnectionParam(const AName, ADescription: String; AValue: String);
begin
  FConnectionParams.Append;
  FConnectionParams.FieldByName(SDb_Name).AsString:=AName;
  FConnectionParams.FieldByName(SDb_Description).AsString:=ADescription;
  FConnectionParams.FieldByName(SDb_Value).AsString:=AValue;
  FConnectionParams.Post;
end;

procedure TSgtsDatabase.ReplaceConnectionParam(const AName, ADescription: String; AValue: String);
var
  IsLocate: Boolean;
begin
  IsLocate:=FConnectionParams.Locate(SDb_Name,AName,[loCaseInsensitive]);
  if IsLocate then
    FConnectionParams.Edit
  else
    FConnectionParams.Append;
    
  FConnectionParams.FieldByName(SDb_Name).AsString:=AName;
  FConnectionParams.FieldByName(SDb_Description).AsString:=ADescription;
  FConnectionParams.FieldByName(SDb_Value).AsString:=AValue;
  FConnectionParams.Post;
end;

function TSgtsDatabase.LoginDefault(Params: String): Boolean;
begin
  Result:=false;
end;

procedure TSgtsDatabase.LogoutDefault;
begin
end;

function TSgtsDatabase.Install(Value: String; InstallType: TSgtsDatabaseInstallType; ProgressProc: TSgtsDatabaseProgressProc=nil): Boolean;
begin
  Result:=false;
end;

function TSgtsDatabase.LogWrite(const Message: String; LogType: TSgtsLogType=ltInformation): Boolean;
var
  S: String;
begin
  Result:=false;
  if Assigned(FCoreIntf) and
     Assigned(FCoreIntf.Log) and
     Assigned(FModuleIntf) then begin
    S:=Format(SLogNameFormat,[FModuleIntf.Name,Message]);
    Result:=FCoreIntf.Log.Write(S,LogType);
  end;
end;

function TSgtsDatabase.ProviderExists(const Provider: String): Boolean;
var
  AProvider: TSgtsProvider;
begin
  Result:=false;
  AProvider:=FGetRecordsProviders.Find(Provider);
  if Assigned(AProvider) then begin
    Result:=true;
    exit;
  end;
  AProvider:=FExecuteProviders.Find(Provider);
  if Assigned(AProvider) then begin
    Result:=true;
    exit;
  end;
end;

function TSgtsDatabase.Export(Value: String; ExportType: TSgtsDatabaseExportType; ProgressProc: TSgtsDatabaseProgressProc=nil): String;
begin
  Result:='';
end;

procedure TSgtsDatabase.RefreshPermissions;
begin
end;

procedure TSgtsDatabase.LoadConfig(Stream: TStream);
begin
end;

procedure TSgtsDatabase.SaveConfig(Stream: TStream);
begin
end;

procedure TSgtsDatabase.ProgressByProc(ProgressProc: TSgtsDatabaseProgressProc; Min,Max,Position: Integer; var Breaked: Boolean);
begin
  if Assigned(ProgressProc) then begin
    ProgressProc(Min,Max,Position,Breaked);
  end;
end;

{ TSgtsDatabases }

function TSgtsDatabases.GetItem(Index: Integer): TSgtsDatabase;
begin
  Result:=TSgtsDatabase(inherited Items[Index]);
end;

procedure TSgtsDatabases.SetItem(Index: Integer; Value: TSgtsDatabase);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsDatabases.AddByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsDatabaseModule; AClass: TSgtsDatabaseClass): TSgtsDatabase;
begin
  Result:=nil;
  if Assigned(AClass) then
    Result:=AClass.Create;
  if Assigned(Result) then begin
    Add(Result);
    Result.InitByModule(ACoreIntf,AModuleIntf);
  end;  
end;


end.
