unit SgtsKgesGraphs;

interface
                   
uses
  SgtsCoreIntf, SgtsInterfaceModulesIntf;

procedure InitInterface(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); stdcall;

implementation

uses SysUtils, ActiveX,
     SgtsInterface, SgtsKgesGraphsInterface;

var
  FInterfaces: TSgtsInterfaces;

procedure InitInterface(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); stdcall;
begin
  if Assigned(ACoreIntf) then begin
    if Assigned(AModuleIntf) then begin
      FInterfaces.AddByModule(ACoreIntf,AModuleIntf,TSgtsKgesGraphsInterface);
    end;
  end;
end;

initialization
  CoInitialize(nil);
  FInterfaces:=TSgtsInterfaces.Create;

finalization
  FreeAndNil(FInterfaces);

end.
