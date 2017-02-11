unit SgtsRoles;

interface

uses Contnrs;

type

  TSgtsRole=class(TObject)
  private
    FName: String;
    FId: String;
  public
    property Name: String read FName write FName;
    property Id: String read FId write FId;
  end;

  TSgtsRoles=class(TObjectList)
  private
    function GetItem(Index: Integer): TSgtsRole;
    procedure SetItem(Index: Integer; Value: TSgtsRole);
  public
    function Add(const AName, AId: String): TSgtsRole;
    function GetIds: String;
    property Items[Index: Integer]: TSgtsRole read GetItem write SetItem;
  end;

implementation

{ TSgtsRoles }

function TSgtsRoles.GetItem(Index: Integer): TSgtsRole;
begin
  Result:=TSgtsRole(inherited Items[Index]);
end;

procedure TSgtsRoles.SetItem(Index: Integer; Value: TSgtsRole);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsRoles.Add(const AName, AId: String): TSgtsRole;
begin
  Result:=TSgtsRole.Create;
  Result.Name:=AName;
  Result.Id:=AId;
  inherited Add(Result); 
end;

function TSgtsRoles.GetIds: String;
var
  i: Integer;
begin
  Result:='';
  for i:=0 to Count-1 do begin
    if i=0 then
      Result:=Items[i].Id
    else Result:=Result+','+Items[i].Id;
  end;
end;

end.
