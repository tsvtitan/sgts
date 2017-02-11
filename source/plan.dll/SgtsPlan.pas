unit SgtsPlan;

interface
                   
uses
  SgtsCoreIntf, SgtsInterfaceModulesIntf;

procedure InitInterface(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); stdcall;

implementation

uses SysUtils,
     SgtsInterface, SgtsPlanInterface;

var
  FInterfaces: TSgtsInterfaces;

procedure InitInterface(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); stdcall;
begin
  if Assigned(ACoreIntf) then begin
    if Assigned(AModuleIntf) then begin
      FInterfaces.AddByModule(ACoreIntf,AModuleIntf,TSgtsPlanInterface);
    end;
  end;
end;

initialization
  Randomize;
  FInterfaces:=TSgtsInterfaces.Create;

finalization
  FreeAndNil(FInterfaces);

end.
