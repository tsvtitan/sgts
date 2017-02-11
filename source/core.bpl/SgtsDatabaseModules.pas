unit SgtsDatabaseModules;

interface

uses Classes, Contnrs,
     SgtsModules, 
     SgtsCoreIntf, SgtsDatabaseModulesIntf, SgtsDatabaseIntf;

type

  TSgtsDatabaseModule=class(TSgtsModule,ISgtsDatabaseModule)
  private
    FDatabaseIntf: ISgtsDatabase;
    function _GetDatabase: ISgtsDatabase;
    procedure InitByDatabase(ADatabaseIntf: ISgtsDatabase);
  protected
    procedure DoInitProc(AProc: TSgtsInitProc); override;  
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Unload; override;
  end;

  TSgtsDatabaseModuleList=class(TSgtsModuleList)
  private
    function GetItems(Index: Integer): TSgtsDatabaseModule;
    procedure SetItems(Index: Integer; ADatabaseModule: TSgtsDatabaseModule);
  public
    property Items[Index: Integer]: TSgtsDatabaseModule read GetItems write SetItems;
  end;

  TSgtsDatabaseModules=class(TSgtsModules,ISgtsDatabaseModules)
  private
    FCurrent: ISgtsDatabaseModule;
    function GetModuleList: TSgtsDatabaseModuleList;
  protected
    function _GetItems(Index: Integer): ISgtsDatabaseModule;
    function _GetCurrent: ISgtsDatabaseModule;
    procedure _SetCurrent(Value: ISgtsDatabaseModule);
    function GetModuleListClass: TSgtsModuleListClass; override;
    function GetModuleClass: TSgtsModuleClass; override;

    property ModuleList: TSgtsDatabaseModuleList read GetModuleList;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Unload; override;

    property Current: ISgtsDatabaseModule read _GetCurrent;
  end;

implementation

uses Windows, SysUtils,
     SgtsObj, SgtsConsts, SgtsDialogs;

{ TSgtsDatabaseModule }

constructor TSgtsDatabaseModule.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDatabaseIntf:=nil;
  InitProcName:=SInitDatabaseProcName;
end;

destructor TSgtsDatabaseModule.Destroy; 
begin
  FDatabaseIntf:=nil;
  inherited Destroy;
end;

function TSgtsDatabaseModule._GetDatabase: ISgtsDatabase;
begin
  Result:=FDatabaseIntf;
end;

procedure TSgtsDatabaseModule.InitByDatabase(ADatabaseIntf: ISgtsDatabase);
begin
  FDatabaseIntf:=ADatabaseIntf;
end;

procedure TSgtsDatabaseModule.DoInitProc(AProc: TSgtsInitProc);
begin
  AProc(CoreIntf,Self as ISgtsDatabaseModule);
end;

procedure TSgtsDatabaseModule.Unload;
begin
  inherited Unload;
end;

{ TSgtsDatabaseModuleList }

function TSgtsDatabaseModuleList.GetItems(Index: Integer): TSgtsDatabaseModule;
begin
  Result:=TSgtsDatabaseModule(inherited Items[Index]);
end;

procedure TSgtsDatabaseModuleList.SetItems(Index: Integer; ADatabaseModule: TSgtsDatabaseModule);
begin
  inherited Items[Index]:=ADatabaseModule;
end;

{ TSgtsDatabaseModules }

constructor TSgtsDatabaseModules.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FCurrent:=nil;
end;

destructor TSgtsDatabaseModules.Destroy;
begin
  inherited Destroy;
end;

function TSgtsDatabaseModules.GetModuleList: TSgtsDatabaseModuleList;
begin
  Result:=TSgtsDatabaseModuleList(inherited ModuleList);
end;

function TSgtsDatabaseModules.GetModuleListClass: TSgtsModuleListClass;
begin
  Result:=TSgtsDatabaseModuleList;
end;

function TSgtsDatabaseModules.GetModuleClass: TSgtsModuleClass;
begin
  Result:=TSgtsDatabaseModule;
end;

function TSgtsDatabaseModules._GetItems(Index: Integer): ISgtsDatabaseModule;
begin
  Result:=ModuleList.Items[Index] as ISgtsDatabaseModule;
end;

function TSgtsDatabaseModules._GetCurrent: ISgtsDatabaseModule;
begin
  Result:=FCurrent;
end;

procedure TSgtsDatabaseModules._SetCurrent(Value: ISgtsDatabaseModule);
begin
  FCurrent:=Value;
end;

procedure TSgtsDatabaseModules.Unload; 
begin
  inherited UnLoad;
  FCurrent:=nil;
end;

end.
