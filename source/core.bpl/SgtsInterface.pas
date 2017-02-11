unit SgtsInterface;

interface

uses Classes, Contnrs,
     SgtsCoreIntf,
     SgtsInterfaceModulesIntf, SgtsInterfaceIntf;

type

  TSgtsInterface=class(TComponent,ISgtsInterface)
  private
    FModuleIntf: ISgtsInterfaceModule;
    FCoreIntf: ISgtsCore;
    FInited: Boolean;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); virtual;
    procedure Start; virtual;

    property ModuleIntf: ISgtsInterfaceModule read FModuleIntf;
    property CoreIntf: ISgtsCore read FCoreIntf;
    property Inited: Boolean read FInited;
  end;

  TSgtsInterfaceClass=class of TSgtsInterface;

  TSgtsInterfaces=class(TObjectList)
  private
    function GetItem(Index: Integer): TSgtsInterface;
    procedure SetItem(Index: Integer; Value: TSgtsInterface);
  public
    function AddByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule; AClass: TSgtsInterfaceClass): TSgtsInterface;
    property Items[Index: Integer]: TSgtsInterface read GetItem write SetItem;
  end;

implementation

uses SysUtils, Variants, 
     SgtsUtils, SgtsConsts;

{ TSgtsInterface }

constructor TSgtsInterface.Create;
begin
  inherited Create(nil);
end;

destructor TSgtsInterface.Destroy;
begin
  FModuleIntf:=nil;
  FCoreIntf:=nil;
  inherited Destroy;
end;

procedure TSgtsInterface.InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule);
begin
  FCoreIntf:=ACoreIntf;
  FModuleIntf:=AModuleIntf;
  FModuleIntf.InitByInterface(Self as ISgtsInterface);
  if not FInited then begin
    FInited:=true;
  end else
    raise Exception.Create(SOnlyOneInit);
end;

procedure TSgtsInterface.Start; 
begin
end;

{ TSgtsInterfaces }

function TSgtsInterfaces.GetItem(Index: Integer): TSgtsInterface;
begin
  Result:=TSgtsInterface(inherited Items[Index]);
end;

procedure TSgtsInterfaces.SetItem(Index: Integer; Value: TSgtsInterface);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsInterfaces.AddByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule; AClass: TSgtsInterfaceClass): TSgtsInterface;
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
