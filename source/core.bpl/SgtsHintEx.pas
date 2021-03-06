unit SgtsHintEx;

interface

uses Classes, Types, SgtsHint;

type
  TSgtsHintWindowEx=class(TSgtsHintWindow)
  private
    FNewHint: TSgtsHint;
  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
  end;

implementation

uses SysUtils, Graphics, StdCtrls;

{ TSgtsHintWindowEx }

constructor TSgtsHintWindowEx.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FNewHint:=TSgtsHint.Create(Self);
  with FNewHint do begin
    FillDirection:=bdUp;
    StartColor:=clWhite;
    EndColor:=TColor($00B3F8FF);
    Brush.Style:=bsClear;
    Alignment:=taLeftJustify;
    Layout:=tlTop;
  end;
  HintComponent:=FNewHint;
end;

destructor TSgtsHintWindowEx.Destroy;
begin
  HintComponent:=nil;
  if Assigned(FNewHint) then
    FreeAndNil(FNewHint);
  inherited Destroy;
end;

procedure TSgtsHintWindowEx.ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer);
begin
  if Assigned(FNewHint) then
    FNewHint.Caption.Text:=AHint;
  inherited ActivateHintData(Rect,AHint,FNewHint);
end;

function TSgtsHintWindowEx.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  if Assigned(FNewHint) then
    FNewHint.Caption.Text:=AHint;
  Result:=inherited CalcHintRect(MaxWidth,AHint,FNewHint);
end;


end.
