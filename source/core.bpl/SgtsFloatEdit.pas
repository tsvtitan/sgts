unit SgtsFloatEdit;

interface

uses Messages, Classes, StdCtrls, SgtsControls;

type

  TSgtsFloatEdit=class(TEdit)
  private
    FMaxValue: Extended;
    FMinValue: Extended;
    FDecimals: Integer;
    function GetValue: Extended;
    procedure SetValue(Value: Extended);
    function ChopToRange(Value: Extended): Extended;
    procedure SetDecimals(Value: Integer);
    procedure SetMaxValue(Value: Extended);
    procedure SetMinValue(Value: Extended);
    function IsInRange(Value: Extended): boolean; overload;
    function IsInRange(Value: String): boolean; overload;
  protected
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
  public
    constructor Create(AOwner: TComponent); override;
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;

    property Value: Extended read GetValue write SetValue;
    property MaxValue: Extended read FMaxValue write SetMaxValue;
    property MinValue: Extended read FMinValue write SetMinValue;
    property Decimals: Integer read FDecimals write SetDecimals;
  end;

implementation

uses Math, Controls, SysUtils, Clipbrd, Variants,
     SgtsUtils;

const
  MaxDecimals = 10;
     
{ TSgtsFloatEdit }

constructor TSgtsFloatEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width:=70;
  FMaxValue:=MaxExtended;
  FMinValue:=-MaxExtended;
  FDecimals:=MaxDecimals;
  AutoSize:=true;
  MaxLength:=MaxDecimals;
  Text:='';
end;

function TSgtsFloatEdit.GetValue: Extended;
begin
  if Text = '' then
    Result := 0.0
  else
    Result := StrToFloatDef(Text, 0.0);
end;

procedure TSgtsFloatEdit.SetValue(Value: Extended);
begin
  Text:=FloatToStr(ChopToRange(Value));
end;

function TSgtsFloatEdit.ChopToRange(Value: Extended): Extended;
begin
  Result := Value;
  if (Value > MaxValue) then
    Result := MaxValue;

  if (Value < MinValue) then
    Result := MinValue;
end;

procedure TSgtsFloatEdit.SetDecimals(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if Value > MaxDecimals then
    Value := MaxDecimals;
  FDecimals := Value;
end;

procedure TSgtsFloatEdit.SetMaxValue(Value: Extended);
begin
  FMaxValue := Value;
  if MinValue > MaxValue then
    FMinValue := MaxValue;
end;

procedure TSgtsFloatEdit.SetMinValue(Value: Extended);
begin
  FMinValue := Value;
  if MaxValue < MaxValue then
    FMaxValue := MinValue;
end;

function TSgtsFloatEdit.IsInRange(Value: Extended): boolean;
begin
  Result := True;
  if (Value > MaxValue) then
    Result := False;
  if (Value < MinValue) then
    Result := False;
end;

function TSgtsFloatEdit.IsInRange(Value: String): boolean;
var
  eValue: extended;
begin
  if Value = '' then
    eValue := 0.0
  else
    eValue := StrToFloatDef(Value, 0.0);

  Result := IsInRange(eValue);
end;

procedure TSgtsFloatEdit.KeyPress(var Key: Char);
var
  lsNewText: string;
  iDotPos:   integer;
begin
  if (Ord(Key)) < Ord(' ') then
  begin
    inherited KeyPress(Key);
    exit;
  end;

  if not CharIsNumber(Key) then
    Key := #0;

  if Key = '-' then
  begin
    if (MinValue >= 0) then
      Key := #0
    else if SelStart <> 0 then
      Key := #0;

    if StrLeft(lsNewText, 2) = '--' then
      Key := #0;
  end;

  if (SelStart = 0) and (Key = '0') and (StrLeft(lsNewText, 1) = '0') then
    Key := #0;

  if (SelStart = 1) and (Key = '0') and (StrLeft(lsNewText, 2) = '-0') then
    Key := #0;

  iDotPos := Pos(DecimalSeparator, Text);

  if Key = DecimalSeparator then
  begin
    if (iDotPos > 0) and not ((SelLength > 0) and (SelStart <= iDotPos) and ((SelStart + SelLength) >= iDotPos)) then
      Key := #0
  end;

  if (iDotPos > 0) and (SelStart > iDotPos) and
    ((Length(Text) - iDotPos) >= MaxDecimals) then
  begin
    Key := #0;
  end;

  lsNewText := GetChangedText(Text, SelStart, SelLength, Key);
  if not IsInRange(lsNewText) then
    Key := #0;

  if Key <> #0 then
    inherited;
end;

procedure TSgtsFloatEdit.WMPaste(var Msg: TMessage);
var
  PasteText: string;
  Buffer: Extended;
begin
  Clipboard.Open;
  PasteText:=Clipboard.AsText;
  Clipboard.Close;
  if TextToFloat(PChar(PasteText), Buffer , fvExtended) then
    inherited;
end;

procedure TSgtsFloatEdit.Change;
begin
  inherited Change;
end;


end.
