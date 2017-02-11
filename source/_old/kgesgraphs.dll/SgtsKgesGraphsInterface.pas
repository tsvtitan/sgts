unit SgtsKgesGraphsInterface;

interface

uses Classes,
     SgtsCoreIntf, SgtsInterfaceModulesIntf,
     SgtsInterface, SgtsMenus,
     SgtsKgesGraphGmoIface, SgtsKgesGraphPzmGmoIface, SgtsKgesGraphFltGmoIface,
     SgtsKgesGraphHmzGmoIface, SgtsKgesGraphTvlGmoIface, SgtsKgesGraphHmzIntensityIface;

type

  TSgtsKgesGraphsInterface=class(TSgtsInterface)
  private
    FGraphGmoIface: TSgtsKgesGraphGmoIface;
    FGraphPzmGmoIface: TSgtsKgesGraphPzmGmoIface; 
    FGraphFltGmoIface: TSgtsKgesGraphFltGmoIface; 
    FGraphHmzGmoIface: TSgtsKgesGraphHmzGmoIface; 
    FGraphTvlGmoIface: TSgtsKgesGraphTvlGmoIface;
    FGraphHmzIntensity: TSgtsKgesGraphHmzIntensityIface;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); override;
    procedure Start; override;
  end;


implementation

uses Menus,
     SgtsDialogs, SgtsCoreObj;

{ TSgtsKgesGraphsInterface }

constructor TSgtsKgesGraphsInterface.Create;
begin
  inherited Create;
  FGraphGmoIface:=TSgtsKgesGraphGmoIface.Create(nil);
  FGraphPzmGmoIface:=TSgtsKgesGraphPzmGmoIface.Create(nil);
  FGraphFltGmoIface:=TSgtsKgesGraphFltGmoIface.Create(nil);
  FGraphHmzGmoIface:=TSgtsKgesGraphHmzGmoIface.Create(nil);
  FGraphTvlGmoIface:=TSgtsKgesGraphTvlGmoIface.Create(nil);
  FGraphHmzIntensity:=TSgtsKgesGraphHmzIntensityIface.Create(nil);
end;

destructor TSgtsKgesGraphsInterface.Destroy;
begin
  FGraphHmzIntensity.Free;
  FGraphTvlGmoIface.Free;
  FGraphHmzGmoIface.Free;
  FGraphFltGmoIface.Free;
  FGraphPzmGmoIface.Free;
  FGraphGmoIface.Free;
  inherited Destroy;
end;

procedure TSgtsKgesGraphsInterface.InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule);

  procedure InitByModuleLocal(Obj: TSgtsCoreObj);
  begin
    Obj.CoreIntf:=ACoreIntf;
    ACoreIntf.RegisterObj(Obj);
  end;

begin
  inherited InitByModule(ACoreIntf,AModuleIntf);
  if Assigned(ACoreIntf) then begin
    InitByModuleLocal(FGraphGmoIface);
    InitByModuleLocal(FGraphPzmGmoIface);
    InitByModuleLocal(FGraphFltGmoIface);
    InitByModuleLocal(FGraphHmzGmoIface);
    InitByModuleLocal(FGraphTvlGmoIface);
    
    InitByModuleLocal(FGraphHmzIntensity);
  end;
end;

procedure TSgtsKgesGraphsInterface.Start;
begin
  if Assigned(CoreIntf) then begin
  end;
end;

end.
