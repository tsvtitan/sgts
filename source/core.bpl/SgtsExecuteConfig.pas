unit SgtsExecuteConfig;

interface

uses Classes, DB, Contnrs;

type

  TSgtsExecuteConfigParam=class(TObject)
  private
    FParamName: string;
    FValue: Variant;
    FDataType: TFieldType;
    FIsNull: Boolean;
    FIsKey: Boolean;
    FParamType: TParamType;
    FSize: Integer;
  public
    property ParamName: string read FParamName write FParamName;
    property DataType: TFieldType read FDataType write FDataType;
    property Value: Variant read FValue write FValue;
    property IsNull: Boolean read FIsNull write FIsNull;
    property IsKey: Boolean read FIsKey write FIsKey;
    property ParamType: TParamType read FParamType write FParamType;
    property Size: Integer read FSize write FSize;
  end;

  TSgtsExecuteConfigParamClass=class of TSgtsExecuteConfigParam;

  TSgtsExecuteConfigParams=class(TObjectList)
  private
    function GetItems(Index: Integer): TSgtsExecuteConfigParam;
    procedure SetItems(Index: Integer; Value: TSgtsExecuteConfigParam);
  protected
    function GetParamClass: TSgtsExecuteConfigParamClass; virtual;
  public
    function Find(const ParamName: string): TSgtsExecuteConfigParam;
    function FindKey(const ParamName: string): TSgtsExecuteConfigParam;
    function Add(const ParamName: string; Value: Variant; IsNull: Boolean; Unique: Boolean): TSgtsExecuteConfigParam;
    procedure CopyFrom(Source: TSgtsExecuteConfigParams; IsClear: Boolean=true);

    property Items[Index: Integer]: TSgtsExecuteConfigParam read GetItems write SetItems;
  end;

  TSgtsExecuteConfig=class(TObject)
  private
    FParams: TSgtsExecuteConfigParams;
    FCheckProvider: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    property Params: TSgtsExecuteConfigParams read FParams;
    property CheckProvider: Boolean read FCheckProvider write FCheckProvider; 
  end;

implementation

uses SysUtils;

{ TSgtsExecuteConfigParams }

function TSgtsExecuteConfigParams.GetItems(Index: Integer): TSgtsExecuteConfigParam;
begin
  Result:=TSgtsExecuteConfigParam(inherited Items[Index]);
end;

function TSgtsExecuteConfigParams.GetParamClass: TSgtsExecuteConfigParamClass;
begin
  Result:=TSgtsExecuteConfigParam;
end;

procedure TSgtsExecuteConfigParams.SetItems(Index: Integer; Value: TSgtsExecuteConfigParam);
begin
  inherited Items[Index]:=Value;
end;

procedure TSgtsExecuteConfigParams.CopyFrom(Source: TSgtsExecuteConfigParams; IsClear: Boolean);
var
  i: Integer;
  Item,ItemNew: TSgtsExecuteConfigParam;
begin
  if IsClear then
    Clear;
  if Assigned(Source) then begin
    for i:=0 to Source.Count-1 do begin
      Item:=Source.Items[i];
      ItemNew:=Add(Item.ParamName,Item.Value,Item.IsNull,false);
      if Assigned(ItemNew) then begin
        ItemNew.DataType:=Item.DataType;
        ItemNew.IsKey:=Item.IsKey;
        ItemNew.ParamType:=Item.ParamType;
        ItemNew.Size:=Item.Size;
      end;
    end;
  end;
end;

function TSgtsExecuteConfigParams.Find(const ParamName: string): TSgtsExecuteConfigParam;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do
    if AnsiSameText(Items[i].ParamName,ParamName) then begin
      Result:=Items[i];
      exit;
    end;
end;

function TSgtsExecuteConfigParams.FindKey(const ParamName: string): TSgtsExecuteConfigParam;
var
  i: Integer;
  Param: TSgtsExecuteConfigParam;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    Param:=Items[i];
    if AnsiSameText(Param.ParamName,ParamName) and Param.IsKey then begin
      Result:=Param;
      exit;
    end;
  end;  
end;

function TSgtsExecuteConfigParams.Add(const ParamName: string; Value: Variant;
                                      IsNull: Boolean; Unique: Boolean): TSgtsExecuteConfigParam;
var
  FlagAdd: Boolean;                                      
begin
  Result:=nil;
  FlagAdd:=false;
  if Unique then begin
    if not Assigned(Find(ParamName)) then
      FlagAdd:=true;
  end else
    FlagAdd:=true;    

  if FlagAdd then begin
    Result:=GetParamClass.Create;
    Result.ParamName:=ParamName;
    Result.Value:=Value;
    Result.IsNull:=IsNull;
    inherited Add(Result);
  end;
end;

{ TSgtsExecuteConfig }

constructor TSgtsExecuteConfig.Create;
begin
  inherited Create;
  FParams:=TSgtsExecuteConfigParams.Create;
end;

destructor TSgtsExecuteConfig.Destroy;
begin
  FParams.Free;
  inherited Destroy;
end;

end.
