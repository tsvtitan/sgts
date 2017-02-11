unit SgtsAccessDatabase;

interface

uses Classes, DB, ADODB, Variants,
     SgtsDatabase, SgtsProviders, SgtsGetRecordsConfig, SgtsExecuteConfig,
     SgtsDatabaseModulesIntf;

type
  TSgtsADOConnection=class(TADOConnection)
  end;

  TSgtsADOQuery=class(TADOQuery)
  public
    procedure GetFieldDefs(AFieldDefs: TFieldDefs);
  end;

  TSgtsADOCommand=class(TADOCommand)
  end;

  TSgtsADOStoredProc=class(TADOStoredProc)
  end;

  TSgtsAccessDatabase=class(TSgtsDatabase)
  private
    FDefConnection: TSgtsADOConnection;
    FConnection: TSgtsADOConnection;

    procedure SetUserParams(Account: String);
    procedure ClearUserParams;
    procedure SetRoles;

{    procedure ConnectionWillExecute(Connection: TADOConnection;
                                    var CommandText: WideString; var CursorType: TCursorType;
                                    var LockType: TADOLockType; var CommandType: TCommandType;
                                    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
                                    const Command: _Command; const Recordset: _Recordset);}
    function GetRecordsTree(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig): OleVariant;
  protected
    function GetConnected: Boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InitByModule(AModuleIntf: ISgtsDatabaseModule); override;

    function Login(const Account, Password: String): Boolean; override;
    procedure Logout; override;
    function CheckPermission(const InterfaceName, Permission, Value: String): Boolean; override;
    function GetRecords(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig): OleVariant; override;
    function GetNewId(Provider: TSgtsExecuteProvider): Variant; override;
    procedure Execute(Provider: TSgtsExecuteProvider; Config: TSgtsExecuteConfig); override;

  end;

implementation

uses SysUtils, DBClient,
     SgtsUtils, SgtsCDS,
     SgtsAccessConsts, SgtsProviderConsts;

{ TSgtsADOQuery }
     
procedure TSgtsADOQuery.GetFieldDefs(AFieldDefs: TFieldDefs);
var
  i: Integer;
begin
  if Assigned(AFieldDefs) and
     Active then
    for i:=0 to Fields.Count-1 do begin
      with AFieldDefs.AddFieldDef do begin
        Name:=Fields[i].FieldName;
        DataType:=Fields[i].DataType;
        if DataType=ftAutoInc then
          DataType:=ftInteger;
        Size:=Fields[i].Size;
      end;
    end;
end;

{ TSgtsAccessDatabase }

constructor TSgtsAccessDatabase.Create;
begin
  inherited Create;
  FDefConnection:=TSgtsADOConnection.Create(nil);
  FDefConnection.Mode:=cmRead;
  FConnection:=TSgtsADOConnection.Create(nil);
  FConnection.LoginPrompt:=false;
  FConnection.Mode:=cmReadWrite;
  FConnection.OnWillExecute:=nil;
  FConnection.ConnectOptions:=coAsyncConnect;

  with GetRecordsProviders do begin
    Add(SProviderSelectAccounts,SProviderAliasSelectAccounts);
    Add(SProviderInsertAccount,SProviderAliasSelectAccounts);
    Add(SProviderUpdateAccount,SProviderAliasSelectAccounts);
    Add(SProviderDeleteAccount,SProviderAliasSelectAccounts);

    Add(SProviderSelectRoles,SProviderAliasSelectRoles);
    Add(SProviderInsertRole,SProviderAliasSelectRoles);
    Add(SProviderUpdateRole,SProviderAliasSelectRoles);
    Add(SProviderDeleteRole,SProviderAliasSelectRoles);

    Add(SProviderSelectPersonnel,SProviderAliasSelectPersonnel);
    Add(SProviderInsertPersonnel,SProviderAliasSelectPersonnel);
    Add(SProviderUpdatePersonnel,SProviderAliasSelectPersonnel);
    Add(SProviderDeletePersonnel,SProviderAliasSelectPersonnel);

    Add(SProviderSelectPermission,SProviderAliasSelectPermission);
    Add(SProviderInsertPermission,SProviderAliasSelectPermission);
    Add(SProviderUpdatePermission,SProviderAliasSelectPermission);
    Add(SProviderDeletePermission,SProviderAliasSelectPermission);

    Add(SProviderSelectRolesAndAccounts,SProviderAliasSelectRolesAndAccounts);

    Add(SProviderSelectAccountsRoles,SProviderAliasSelectAccountsRoles);
    Add(SProviderInsertAccountRole,SProviderAliasSelectAccountsRoles);
    Add(SProviderUpdateAccountRole,SProviderAliasSelectAccountsRoles);
    Add(SProviderDeleteAccountRole,SProviderAliasSelectAccountsRoles);

    Add(SProviderSelectDivisions,SProviderAliasSelectDivisions);
    Add(SProviderInsertDivision,SProviderAliasSelectDivisions);
    Add(SProviderUpdateDivision,SProviderAliasSelectDivisions);
    Add(SProviderDeleteDivision,SProviderAliasSelectDivisions);

    Add(SProviderSelectObjects,SProviderAliasSelectObjects);
    Add(SProviderInsertObject,SProviderAliasSelectObjects);
    Add(SProviderUpdateObject,SProviderAliasSelectObjects);
    Add(SProviderDeleteObject,SProviderAliasSelectObjects);

    Add(SProviderSelectPersonnelManagement,SProviderAliasSelectPersonnelManagement,GetRecordsTree);
    Add(SProviderInsertPersonnelManagement,SProviderAliasSelectPersonnelManagement);
  end;

  with ExecuteProviders do begin
    AddInsert(SProviderInsertAccount,SProviderAliasInsertAccount,SProviderKeyQueryInsertAccount,SFieldAccountId);
    AddUpdate(SProviderUpdateAccount,SProviderAliasInsertAccount);
    AddDelete(SProviderDeleteAccount,SProviderAliasInsertAccount);

    AddInsert(SProviderInsertRole,SProviderAliasInsertRole,SProviderKeyQueryInsertRole,SFieldAccountId);
    AddUpdate(SProviderUpdateRole,SProviderAliasInsertRole);
    AddDelete(SProviderDeleteRole,SProviderAliasInsertRole);

    AddInsert(SProviderInsertPersonnel,SProviderAliasInsertPersonnel,SProviderKeyQueryInsertPersonnel,SFieldPersonnelId);
    AddUpdate(SProviderUpdatePersonnel,SProviderAliasInsertPersonnel);
    AddDelete(SProviderDeletePersonnel,SProviderAliasInsertPersonnel);

    AddInsert(SProviderInsertPermission,SProviderAliasInsertPermission,SProviderKeyQueryInsertPermission,SFieldPermissionId);
    AddUpdate(SProviderUpdatePermission,SProviderAliasInsertPermission);
    AddDelete(SProviderDeletePermission,SProviderAliasInsertPermission);

    AddInsert(SProviderInsertAccountRole,SProviderAliasInsertAccountRole,'','');
    AddUpdate(SProviderUpdateAccountRole,SProviderAliasInsertAccountRole);
    AddDelete(SProviderDeleteAccountRole,SProviderAliasInsertAccountRole);

    AddInsert(SProviderInsertDivision,SProviderAliasInsertDivision,SProviderKeyQueryInsertDivision,SFieldDivisionId);
    AddUpdate(SProviderUpdateDivision,SProviderAliasInsertDivision);
    AddDelete(SProviderDeleteDivision,SProviderAliasInsertDivision);

    AddInsert(SProviderInsertObject,SProviderAliasInsertObject,SProviderKeyQueryInsertObject,SFieldObjectId);
    AddUpdate(SProviderUpdateObject,SProviderAliasInsertObject);
    AddDelete(SProviderDeleteObject,SProviderAliasInsertObject);

    AddInsert(SProviderInsertPersonnelManagement,SProviderAliasInsertPersonnelManagement,SProviderKeyQueryInsertPersonnelManagement,SFieldTreeId);

  end;
end;

destructor TSgtsAccessDatabase.Destroy;
begin
  FConnection:=nil;
  FDefConnection:=nil;
  inherited Destroy;
end;

{procedure TSgtsAccessDatabase.ConnectionWillExecute(Connection: TADOConnection;
                                                    var CommandText: WideString; var CursorType: TCursorType;
                                                    var LockType: TADOLockType; var CommandType: TCommandType;
                                                    var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
                                                    const Command: _Command; const Recordset: _Recordset);
var
  Str: TStringList;
begin
  Str:=TStringList.Create;
  try
    Str.Add(CommandText);
    Str.SaveToFile('c:\2.txt');
  finally
    Str.Free;
  end;
end;}                                                    

procedure TSgtsAccessDatabase.InitByModule(AModuleIntf: ISgtsDatabaseModule);
begin
  inherited InitByModule(AModuleIntf);
  with FDefConnection do begin
    ConnectionString:=AModuleIntf.Config.Read(AModuleIntf.Name,SParamConnectionString,ConnectionString);
    LoginPrompt:=False;
  end;
end;

procedure TSgtsAccessDatabase.ClearUserParams;
begin
  Account:='';
  Password:='';
  AccountId:='';
  DbUserName:='';
  DbPassword:='';
end;

function TSgtsAccessDatabase.Login(const Account, Password: String): Boolean;
begin
  Result:=false;
  ClearUserParams;
  with FConnection do begin
    if Connected then
      Connected:=false;
    if not Connected then begin
      FConnection.ConnectionString:=FDefConnection.ConnectionString;

      FDefConnection.Connected:=true;
      try
        SetUserParams(Account);
      finally
        FDefConnection.Connected:=false;
      end;
      
      if Trim(AccountId)<>'' then
        if not AnsiSameText(Self.Password,Password) then
          raise Exception.Create(SInvalidUserNameOrPassword);
      try
        Open(DbUserName,DbPassword);
        FDefConnection.Connected:=true;
        Result:=Connected;
      finally
        if Result then begin
          if Trim(AccountId)='' then begin
            Connected:=false;
            ClearUserParams;
            Result:=false;
          end;
          if not Result then
            raise Exception.Create(SInvalidUserNameOrPassword);
          SetRoles;
        end else begin
          ClearUserParams;
        end;
      end;
    end;
  end;
end;

procedure TSgtsAccessDatabase.Logout;
begin
  with FConnection do
    if Connected then
      Connected:=false;
end;

procedure TSgtsAccessDatabase.SetUserParams(Account: String);
var
  Query: TSgtsADOQuery;
begin
  if FDefConnection.Connected then begin
    Query:=TSgtsADOQuery.Create(nil);
    try
      Query.Connection:=FDefConnection;
      Query.SQL.Text:=Format(SSQLGetUserParams,[QuotedStr(Account)]);
      Query.Open;
      Query.First;
      if Query.Active and not Query.IsEmpty then begin
        Self.Account:=Account;
        Self.AccountId:=Query.FieldByName(SFieldAccountId).AsString;
        Self.Password:=Query.FieldByName(SFieldPassword).AsString;
        Self.DbUserName:=Query.FieldByName(SFieldDbUser).AsString;
        Self.DbPassword:=Query.FieldByName(SFieldDbPass).AsString;
      end;
    finally
      Query.Free;
    end;
  end;   
end;

function TSgtsAccessDatabase.GetConnected: Boolean;
begin
  Result:=FConnection.Connected;
end;

procedure TSgtsAccessDatabase.SetRoles;
var
  Query: TSgtsADOQuery;
begin
  if FDefConnection.Connected then begin
    Query:=TSgtsADOQuery.Create(nil);
    try
      Query.Connection:=FDefConnection;
      Query.SQL.Text:=Format(SSQLGetRoles,[AccountId]);
      Query.Open;
      Query.First;
      if Query.Active then begin
        Roles.Clear;
        while not Query.Eof do begin
          Roles.Add(Query.FieldByName(SFieldName).AsString,Query.FieldByName(SFieldRoleId).AsString);
          Query.Next;
        end;
      end;
    finally
      Query.Free;
    end;
  end;  
end;

function TSgtsAccessDatabase.CheckPermission(const InterfaceName, Permission, Value: String): Boolean; 
var
  Query: TSgtsADOQuery;
  RolesIds: String;
begin
  Result:=false;
  if FDefConnection.Connected then begin
    Query:=TSgtsADOQuery.Create(nil);
    try
      RolesIds:=Roles.GetIds;
      if Trim(RolesIds)='' then
        RolesIds:=AccountId;
      Query.Connection:=FDefConnection;
      Query.SQL.Text:=Format(SSQLGetPermission,[AccountId,RolesIds,
                                                QuotedStr(InterfaceName),
                                                QuotedStr(Permission),
                                                QuotedStr(Value)]);
      Query.Open;
      if Query.Active and not Query.IsEmpty then begin
        Result:=True;
      end;
    finally
      Query.Free;
    end;
  end;
end;

function TSgtsAccessDatabase.GetRecords(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig): OleVariant;
var
  Query: TSgtsADOQuery;
  DSOut: TSgtsCDS;
  Params: String;
  Filters: String;
  FieldNames: String;
  Orders: String;
  RealCount: Integer;
  RecCount: Integer;
  StartPos: Integer;
begin
  Result:=inherited GetRecords(Provider,Config);
  if FConnection.Connected then begin
    Query:=TSgtsADOQuery.Create(nil);
    DSOut:=TSgtsCDS.Create(nil);
    try
      Query.Connection:=FConnection;

      Params:=GetRecordsParams(Config.Params);
      Filters:=GetRecordsFilterGroups(Config.FilterGroups);

      Query.Sql.Text:=Trim(Format(SSqlGetRecordsCount,[Provider.Alias,Params,Filters]));
      Query.Open;

      Config.AllCount:=0;
      if not Query.IsEmpty then
        Config.AllCount:=Query.Fields[0].AsInteger;

      StartPos:=Config.StartPos;

      RealCount:=Config.FetchCount;
      if RealCount<0 then begin
        RealCount:=Config.AllCount-StartPos
      end else begin
        if (StartPos+RealCount)>Config.AllCount then
          RealCount:=Config.AllCount-StartPos;
      end;

      FieldNames:=GetRecordsFieldNames(Config.FieldNames);
      Orders:=GetRecordsOrders(Config.Orders);

      Query.Close;
      Query.SQL.Text:=Trim(Format(SSqlGetRecords,[FieldNames,Provider.Alias,Params,Filters,Orders]));
      Query.Open;

      if Query.Active then  begin

        RecCount:=0;
        Query.GetFieldDefs(DSOut.FieldDefs);
        DSOut.CreateDataSet;
        while not Query.Eof do begin
          if (RecCount>=StartPos) then begin
            if (RecCount<(StartPos+RealCount)) then begin
              DSOut.FieldValuesBySource(Query,true);
            end else
              break;
          end;
          inc(RecCount);
          Query.Next;
        end;

        if DSOut.Active then begin
          DSOut.MergeChangeLog;
          DSOut.First;
          Result:=DSOut.Data;
          Config.RecsOut:=DSOut.RecordCount;
        end;
      end;

    finally
      DSOut.Free;
      Query.Free;
    end;
  end;
end;

function TSgtsAccessDatabase.GetNewId(Provider: TSgtsExecuteProvider): Variant;
var
  Query: TSgtsADOQuery;
begin
  Result:=inherited GetNewId(Provider);
  if FConnection.Connected then begin
    Query:=TSgtsADOQuery.Create(nil);
    try
      Query.Connection:=FConnection;
      Query.Sql.Text:=Format(SSqlGetNewId,[Provider.KeyField,Provider.KeyQuery]);
      Query.Open;
      if Query.Active and not Query.IsEmpty then begin
        Result:=Query.FieldByName(SFieldMaxId).Value;
        if VarIsNull(Result) then
          Result:=1;
      end;
    finally
      Query.Free;
    end;
  end;
end;

procedure TSgtsAccessDatabase.Execute(Provider: TSgtsExecuteProvider; Config: TSgtsExecuteConfig);
var
  Query: TSgtsADOQuery;
  S1,S2: String;
  i: Integer;
  Param: TParameter;
  Item: TSgtsExecuteConfigParam;
begin
  if FConnection.Connected then begin
    Query:=TSgtsADOQuery.Create(nil);
    try
      Query.Connection:=FConnection;
      Query.ParamCheck:=true;
      Query.Prepared:=true;

      case Provider.ProviderType of
        eptInsert: begin
          S1:=GetExecuteInsertFieldNames(Config.Params);
          S2:=GetExecuteInsertParams(Config.Params);
          Query.SQL.Text:=Format(SSqlExecuteInsert,[Provider.Alias,S1,S2]);
        end;
        eptUpdate: begin
          S1:=GetExecuteUpdateFieldParams(Config.Params);
          S2:=GetExecuteUpdateFieldKeys(Config.Params);
          Query.SQL.Text:=Format(SSqlExecuteUpdate,[Provider.Alias,S1,S2]);
        end;
        eptDelete: begin
          S1:=GetExecuteDeleteFieldKeys(Config.Params);
          Query.SQL.Text:=Format(SSqlExecuteDelete,[Provider.Alias,S1]);
        end;
      end;

      with Config.Params do begin
        for i:=0 to Count-1 do begin
          Item:=Items[i];
          Param:=Query.Parameters.FindParam(GetExecuteParamFieldName(Item));
          if Assigned(Param) then begin
            Param.Value:=Item.Value;
            Param.DataType:=Item.DataType;
            if Item.IsNull then
              Param.Attributes:=Param.Attributes+[paNullable];
            case Param.DataType of
              ftString,ftFixedChar,ftWideString: begin
                Param.Size:=Item.Size;
              end;
            end;
          end;
        end;
      end;

      Query.ExecSQL;

      with Query.Parameters do begin
        for i:=0 to Count-1 do begin
          Param:=Items[i];
          Item:=Config.Params.Find(Param.Name);
          if Assigned(Item) then begin
            Item.Value:=Param.Value;
          end;
        end;
      end;

    finally
      Query.Free;
    end;
  end;
end;

function TSgtsAccessDatabase.GetRecordsTree(Provider: TSgtsGetRecordsProvider; Config: TSgtsGetRecordsConfig): OleVariant;
var
  DSOut: TSgtsCDS;
  DSFind: TSgtsCDS;
  Counter: Integer;
  FieldUnionType: TField;
  FieldUnionId: TField;
  FIeldUnionParentId: TField;
  OldUnionType: Integer;
  TempUnionType: Integer;
  ParentId: Variant;
  ChangeCount: Integer;

  function GetParentId: Variant;
  var
    B: TBookmark;
  begin
    Result:=Null;
    B:=DSOut.GetBookmark;
    try
      DSOut.Filtered:=false;
      DSOut.Filter:=Format('%s=%d',[SFieldUnionType,OldUnionType]);
      DSOut.Filtered:=true;
      DSOut.First;
      if DSOut.Locate(FieldUnionId.FieldName,FieldUnionParentId.Value,[loCaseInsensitive]) then begin
        Result:=DSOut.FieldByName(SFieldTreeId).Value;
      end;
    finally
      DSOut.Filtered:=false;
      if Assigned(B) and DSOut.BookmarkValid(B) then
        DSOut.GotoBookmark(B);
    end;  
  end;
  
begin
  Result:=CreateDefaultGetRecordsData;
  if FConnection.Connected then begin
    DSOut:=TSgtsCDS.Create(nil);
    DSFind:=TSgtsCDS.Create(nil);
    try
      DSFind.Data:=GetRecords(Provider,Config);
      if DSFind.Active then begin
        Counter:=1;
        DSFind.First;

        FieldUnionType:=DSFind.FindField(SFieldUnionType);
        FieldUnionId:=DSFind.FindField(SFieldUnionId);
        FIeldUnionParentId:=DSFind.FindField(SFieldUnionParentId);

        if Assigned(FieldUnionType) and
           Assigned(FieldUnionId) and
           Assigned(FIeldUnionParentId) then begin

          with DSOut do begin
            CreateDataSetBySource(DSFind,true);
          end;

          OldUnionType:=FieldUnionType.AsInteger;
          TempUnionType:=OldUnionType;
          ChangeCount:=0;

          while not DSFind.Eof do begin

            if TempUnionType<>FieldUnionType.AsInteger then
              inc(ChangeCount);

            if ChangeCount>1 then begin
              OldUnionType:=TempUnionType;
              ChangeCount:=0;
            end;

            TempUnionType:=FieldUnionType.AsInteger;

            DSOut.Append;
            DSOut.FieldValuesBySource(DSFind,false,false);
            DSOut.FieldByName(SFieldTreeId).Value:=Counter;
            DSOut.FieldByName(SFieldParentId).Value:=Null;
            DSOut.Post;

            if not VarIsNull(FieldUnionParentId.Value) then begin
              ParentId:=GetParentId;
              DSOut.Edit;
              DSOut.FieldByName(SFieldParentId).Value:=ParentId;
              DSOut.Post;
            end;

            Inc(Counter);
            DSFind.Next;
          end;

           DSOut.MergeChangeLog;
           DSOut.First;
           Result:=DSOut.Data;
        end;
      end;
    finally
      DSFind.Free;
      DSOut.Free;
    end;
  end;
end;

end.
