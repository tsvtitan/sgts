unit SgtsDatabaseConfig;

interface

uses Classes,
     SgtsConfig, SgtsDatabaseIntf,
     SgtsDatabaseConfigIntf;

type

  TSgtsDatabaseConfig=class(TSgtsConfig,ISgtsDatabaseConfig)
  private
    function GetDatabase: ISgtsDatabase;
  public
    procedure LoadFromDatabase;
    procedure SaveToDatabase;
  end;

implementation

uses SgtsDatabaseModulesIntf;

{ TSgtsDatabaseConfig }

function TSgtsDatabaseConfig.GetDatabase: ISgtsDatabase;
begin
  Result:=nil;
  if Assigned(CoreIntf) then
    if Assigned(CoreIntf.DatabaseModules.Current) then
      Result:=CoreIntf.DatabaseModules.Current.Database;
end;

procedure TSgtsDatabaseConfig.LoadFromDatabase;
var
  Database: ISgtsDatabase;
  Stream: TMemoryStream;
begin
  Database:=GetDatabase;
  if Assigned(Database) then begin
    Stream:=TMemoryStream.Create;
    try
      Database.LoadConfig(Stream);
      Stream.Position:=0;
      LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TSgtsDatabaseConfig.SaveToDatabase;
var
  Database: ISgtsDatabase;
  Stream: TMemoryStream;
begin
  Database:=GetDatabase;
  if Assigned(Database) then begin
    Stream:=TMemoryStream.Create;
    try
      SaveToStream(Stream);
      Stream.Position:=0;
      Database.SaveConfig(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

end.
