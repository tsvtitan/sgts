unit SgtsVariants;

interface

uses Classes, Contnrs;

type
  TSgtsVariant=class(TObject)
  private
    FValue: Variant;
  public
    property Value: Variant read FValue write FValue;
  end;

  TSgtsVariantList=class(TObjectList)
  private
    function GetItems(Index: Integer): TSgtsVariant;
    procedure SetItems(Index: Integer; Value: TSgtsVariant);
  public
    function Find(Value: Variant): TSgtsVariant;
    function Add(Value: Variant): TSgtsVariant;
    function AddUnique(Value: Variant): TSgtsVariant;

    property Items[Index: Integer]: TSgtsVariant read GetItems write SetItems;
  end;
  
implementation

{ TSgtsVariantList }

function TSgtsVariantList.GetItems(Index: Integer): TSgtsVariant;
begin
  Result:=TSgtsVariant(inherited Items[Index]);
end;

procedure TSgtsVariantList.SetItems(Index: Integer; Value: TSgtsVariant);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsVariantList.Find(Value: Variant): TSgtsVariant;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if Items[i].Value=Value then begin
      Result:=Items[i];
      exit;
    end;
  end;
end;

function TSgtsVariantList.Add(Value: Variant): TSgtsVariant;
begin
  Result:=TSgtsVariant.Create;
  Result.Value:=Value;
  inherited Add(Result);
end;

function TSgtsVariantList.AddUnique(Value: Variant): TSgtsVariant;
begin
  Result:=nil;
  if not Assigned(Find(Value)) then begin
    Result:=Add(Value);
  end;
end;

end.
