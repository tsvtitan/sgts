unit SgtsTimedMsgFm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TSgtsTimedMsgForm = class(TForm)
    iIcon: TImage;
    lMessage: TLabel;
    bTimer: TSpeedButton;
    Timer: TTimer;
    procedure FormShow(Sender: TObject);
    procedure bHelpClick(Sender: TObject);
    procedure bTimerClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    FDlgType: TMsgDlgType;
    FButtons: TMsgDlgButtons;
    FSeconds: Integer;
    FDefaultButton: TMsgDlgBtn;
    DefButton: TBitBtn;
  public
    { Public declarations }
    property DlgType: TMsgDlgType read FDlgType write FDlgType;
    property Buttons: TMsgDlgButtons read FButtons write FButtons;
    property DefaultButton: TMsgDlgBtn read FDefaultButton write FDefaultButton;
    property Seconds: Integer read FSeconds write FSeconds;
  end;

var
  SgtsTimedMsgForm: TSgtsTimedMsgForm;

function TimedMessageBox(const Msg, Title: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn;
  var Seconds: Integer; HelpCtx: Longint = 0; UseTimer: Boolean=true): Integer;

const
  mbDefaultTimeOut: Integer = 30;

implementation

{$R *.DFM}
{$R *.res}

uses SgtsConsts;

const
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  ButtonNames: array[TMsgDlgBtn] of String = (
    SButtonNameYes, SButtonNameNo, SButtonNameOK, SButtonNameCancel, SButtonNameAbort, SButtonNameRetry,
    SButtonNameIgnore, SButtonNameAll, SButtonNameNoToAll, SButtonNameYesToAll, SButtonNameHelp);
  ButtonCaptions: array[TMsgDlgBtn] of String = (
    SButtonCaptionYes, SButtonCaptionNo, SButtonCaptionOK, SButtonCaptionCancel, SButtonCaptionAbort,
    SButtonCaptionRetry, SButtonCaptionIgnore, SButtonCaptionAll, SButtonCaptionNoToAll,
    SButtonCaptionYesToAll,SButtonCaptionHelp);
  ButtonGlyphs: array[TMsgDlgBtn] of String = (
    'OK', 'NO', 'OK', 'CANCEL', 'ABORT', 'RETRY', 'IGNORE', 'YESTOALL', 'NOTOALL',
    'YESTOALL', 'HELP');
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0);
  Captions: array[TMsgDlgType] of String = (STitleCaptionWarning, STitleCaptionError,
    STitleCaptionInformation, STitleCaptionConfirmation, '');

function TimedMessageBox(const Msg, Title: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn;
  var Seconds: Integer; HelpCtx: Longint = 0; UseTimer: Boolean=true): Integer;
var
  MsgForm: TSgtsTimedMsgForm;
begin
  MsgForm := TSgtsTimedMsgForm.Create(Application);
  MsgForm.Font.Assign(Screen.HintFont);
  MsgForm.lMessage.Caption := Msg;
  MsgForm.Caption := Title;
  MsgForm.DlgType := DlgType;
  MsgForm.Buttons := Buttons;
  MsgForm.DefaultButton := DefaultButton;
  MsgForm.Seconds := Seconds;
  MsgForm.HelpContext := HelpCtx;
  MsgForm.HelpFile := Application.HelpFile;
  if UseTimer then
    MsgForm.bTimer.Hint := SSuspendTimer
  else
    MsgForm.bTimer.Hint := SResumeTimer;
  MsgForm.bTimer.Down:=UseTimer;
  MsgForm.bTimer.Visible:=UseTimer;
  Result := MsgForm.ShowModal;
  Seconds := MsgForm.Seconds;
  MsgForm.Free
end;

function Max(I, J: Integer): Integer;
begin
  if I > J then Result := I else Result := J;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

procedure TSgtsTimedMsgForm.FormShow(Sender: TObject);
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, ALeft: Integer;
  B, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  TextRect: TRect;
  ButtonWidths: array[TMsgDlgBtn] of Integer;
  S: String;
  Button: TBitBtn;
begin
  if Buttons = [] then
    Buttons := [mbOk];
  bTimer.Visible := bTimer.Visible and (Seconds > 0);

  DialogUnits := GetAveCharSize(Canvas);
  HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
  VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
  HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
  VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
  ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);

  ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
  ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
  SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
  DrawText(Canvas.Handle, PChar(lMessage.Caption), Length(lMessage.Caption)+1, TextRect,
    DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
    DrawTextBiDiModeFlagsReadingOnly);
  IconID := IconIDs[DlgType];
  IconTextWidth := TextRect.Right;
  IconTextHeight := TextRect.Bottom;

  if IconID <> nil then
    iIcon.Picture.Icon.Handle := LoadIcon(0, IconID)
  else
    iIcon.Picture.Icon := Application.Icon;

  Inc(IconTextWidth, 32 + HorzSpacing);
  if IconTextHeight < 32 then IconTextHeight := 32;
  iIcon.SetBounds(HorzMargin, VertMargin, 32, 32);

  if Caption = '' then
    if DlgType <> mtCustom then
      Caption := Captions[DlgType] else
      Caption := Application.Title;

  lMessage.BoundsRect := TextRect;
  ALeft := IconTextWidth - TextRect.Right + HorzMargin;
  lMessage.SetBounds(ALeft, VertMargin,
    TextRect.Right, TextRect.Bottom);

  if not (DefaultButton in Buttons) then
    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        DefaultButton := mbRetry;
  if not (DefaultButton in Buttons) then
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
      begin
        DefaultButton := B;
        Break
      end;
  if mbCancel in Buttons then CancelButton := mbCancel else
    if mbNo in Buttons then CancelButton := mbNo else
      CancelButton := mbOk;

  ButtonGroupWidth := 0;
  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
  begin
    if B in Buttons then
    begin
      S := ButtonCaptions[B];
      if (Seconds > 0) and (B = DefaultButton) then
        S := S + ' (' + IntToStr(Seconds) + ')';
      X := Canvas.TextWidth(S) + 32;
      if X > ButtonWidth then
        ButtonWidths[B] := X
      else
        ButtonWidths[B] := ButtonWidth;
      Inc(ButtonGroupWidth, ButtonSpacing)
    end
    else
      ButtonWidths[B] := 0;
    Inc(ButtonGroupWidth, ButtonWidths[B]);
  end;
  Dec(ButtonGroupWidth, ButtonSpacing);

  ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
  if bTimer.Visible then
    ClientWidth := ClientWidth + HorzSpacing + bTimer.Width;
  ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
    VertMargin * 2;
  Left := (Screen.Width div 2) - (Width div 2);
  Top := (Screen.Height div 2) - (Height div 2);

  bTimer.Left := ClientWidth - HorzMargin - bTimer.Width;
  bTimer.Top := VertMargin;

  X := (ClientWidth - ButtonGroupWidth) div 2;
  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if B in Buttons then
    begin
      Button := TBitBtn.Create(Self);
      With Button do
      begin
        Name := ButtonNames[B];
        Parent := Self;
        if (Seconds > 0) and (B = DefaultButton) and (bTimer.Visible) then
          Caption := ButtonCaptions[B] + ' (' + IntToStr(Seconds) + ')'
        else
          Caption := ButtonCaptions[B];
        ModalResult := ModalResults[B];
        //Glyph.LoadFromResourceName(HInstance, ButtonGlyphs[B]);
        NumGlyphs := 2;
        if B = DefaultButton then
        begin
          Default := True;
          DefButton := Button
        end;
        if B = CancelButton then Cancel := True;
        SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
          ButtonWidths[B], ButtonHeight);
        Inc(X, ButtonWidths[B] + ButtonSpacing);
        if B = mbHelp then
          OnClick := bHelpClick;
      end
    end;

  Timer.Enabled := bTimer.Visible;

  if DefButton.CanFocus then
    DefButton.SetFocus
end;

procedure TSgtsTimedMsgForm.bHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSgtsTimedMsgForm.bTimerClick(Sender: TObject);
begin
  Timer.Enabled := bTimer.Down;
  if bTimer.Down then
    bTimer.Hint := SSuspendTimer
  else
    bTimer.Hint := SResumeTimer;
end;

procedure TSgtsTimedMsgForm.TimerTimer(Sender: TObject);
begin
  Dec(FSeconds);
  if bTimer.Visible then
    DefButton.Caption := ButtonCaptions[DefaultButton] + ' (' + IntToStr(FSeconds) + ')'
  else DefButton.Caption :=ButtonCaptions[DefaultButton];
  if FSeconds <= 0 then
  begin
    ModalResult := ModalResults[DefaultButton];
    bTimer.Down := False;
    Timer.Enabled := False
  end
end;

end.
