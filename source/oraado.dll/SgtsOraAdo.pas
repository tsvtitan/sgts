unit SgtsOraAdo;

interface

uses
  SgtsCoreIntf, SgtsDatabaseModulesIntf;

procedure InitDatabase(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsDatabaseModule); stdcall;

implementation

uses SysUtils, ActiveX, Contnrs,
     SgtsDatabase, SgtsOraAdoDatabase;

var
  FDatabases: TSgtsDatabases;

procedure InitDatabase(ACoreIntf: ISgtsCore; AModuleIntf: ISgtsDatabaseModule); stdcall;
begin
  if Assigned(ACoreIntf) then begin
    if Assigned(AModuleIntf) then begin
      FDatabases.AddByModule(ACoreIntf,AModuleIntf,TSgtsOraAdoDatabase);
    end;  
  end;
end;

initialization
  CoInitialize(nil);
  FDatabases:=TSgtsDatabases.Create;

finalization
  if Assigned(FDatabases) then
    FreeAndNil(FDatabases);

end.
