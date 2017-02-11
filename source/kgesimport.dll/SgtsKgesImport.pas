unit SgtsKgesImport;

interface
                   
uses
  SgtsCoreIntf, SgtsInterfaceModulesIntf;

procedure InitInterface(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); stdcall;

implementation

uses SysUtils,
     SgtsInterface, SgtsKgesImportInterface;

var
  FInterfaces: TSgtsInterfaces;

procedure InitInterface(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsInterfaceModule); stdcall;
begin
  if Assigned(ACoreIntf) then begin
    if Assigned(AModuleIntf) then begin
      FInterfaces.AddByModule(ACoreIntf,AModuleIntf,TSgtsKgesImportInterface);
    end;
  end;
end;

initialization
  FInterfaces:=TSgtsInterfaces.Create;

finalization
  FreeAndNil(FInterfaces);

end.
