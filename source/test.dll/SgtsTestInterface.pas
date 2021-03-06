unit SgtsTestInterface;

interface

uses Classes,
     SgtsCoreIntf, SgtsInterfaceModulesIntf,
     SgtsInterface, SgtsMenus;

type

  TSgtsTestInterface=class(TSgtsInterface)
  private
  //  FSgtsPlanGraphIface:TSgtsPlanGraphIface;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); override;
    procedure Start; override;
  end;


implementation

uses SgtsDialogs, SgtsCoreObj;

{ TSgtsTestInterface }

constructor TSgtsTestInterface.Create;
begin
  inherited Create;
 // FSgtsPlanGraphIface:=TSgtsPlanGraphIface.Create(nil);
end;

destructor TSgtsTestInterface.Destroy;
begin
 /// FSgtsPlanGraphIface.Free;
  inherited Destroy;
end;

procedure TSgtsTestInterface.InitByModule(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule);

  procedure InitByModuleLocal(Obj: TSgtsCoreObj);
  begin
    Obj.CoreIntf:=ACoreIntf; 
    ACoreIntf.RegisterObj(Obj);
  end;

begin
  inherited InitByModule(ACoreIntf,AModuleIntf);
  if Assigned(ACoreIntf) then begin
   // InitByModuleLocal(FSgtsPlanGraphIface);
  end;
end;

procedure TSgtsTestInterface.Start;
begin
  if Assigned(CoreIntf) then begin
  end;
end;

end.
