unit SgtsBaseReportControls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, Variants,
  ExtCtrls, Forms, Menus, Dialogs, Comctrls, Buttons, Mask, CheckLst, DB, DBClient,
  frxClass, frxDsgnIntf,
  rxToolEdit,
  SgtsControls;

type
  TSgtsLabelControl = class(TfrxDialogControl)
  private
    FLabel: TLabel;
    FFocusControl: TfrxDialogControl;
    function GetAlignment: TAlignment;
    function GetAutoSize: Boolean;
    function GetWordWrap: Boolean;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetFocusControl(Value: TfrxDialogControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    property LabelCtl: TLabel read FLabel;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment default taLeftJustify;
    property AutoSize: Boolean read GetAutoSize write SetAutoSize default True;
    property Caption;
    property Color;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property FocusControl: TfrxDialogControl read FFocusControl write SetFocusControl;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TSgtsEdit=class(TEdit)
  private
    FReport: TfrxReport;
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    property Report: TfrxReport read FReport write FReport;
  end;

  TSgtsEditControl = class(TfrxDialogControl)
  private
    FEdit: TSgtsEdit;
    FOnChange: TfrxNotifyEvent;
    function GetMaxLength: Integer;
    function GetPasswordChar: Char;
    function GetReadOnly: Boolean;
    function GetText: String;
    procedure DoOnChange(Sender: TObject);
    procedure SetMaxLength(const Value: Integer);
    procedure SetPasswordChar(const Value: Char);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetText(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Edit: TSgtsEdit read FEdit;
  published
    property Color;
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property PasswordChar: Char read GetPasswordChar write SetPasswordChar;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Text: String read GetText write SetText;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property TabStop;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TSgtsMemo=class(TMemo)
  private
    FReport: TfrxReport;
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    property Report: TfrxReport read FReport write FReport;
  end;

  TSgtsMemoControl = class(TfrxDialogControl)
  private
    FMemo: TSgtsMemo;
    FOnChange: TfrxNotifyEvent;
    function GetMaxLength: Integer;
    function GetPasswordChar: Char;
    function GetReadOnly: Boolean;
    function GetText: String;
    procedure DoOnChange(Sender: TObject);
    procedure SetMaxLength(const Value: Integer);
    procedure SetPasswordChar(const Value: Char);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetText(const Value: String);
    function GetLines: TStrings;
    procedure SetLines(const Value: TStrings);
    function GetScrollStyle: TScrollStyle;
    function GetWordWrap: Boolean;
    procedure SetScrollStyle(const Value: TScrollStyle);
    procedure SetWordWrap(const Value: Boolean);
    function GetAlignment: TAlignment;
    procedure SetAlignment(const Value: TAlignment);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property Memo: TSgtsMemo read FMemo;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment default taLeftJustify;
    property Color;
    property Lines: TStrings read GetLines write SetLines;
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property PasswordChar: Char read GetPasswordChar write SetPasswordChar;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars: TScrollStyle read GetScrollStyle write SetScrollStyle default ssNone;
    property Text: String read GetText write SetText;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default True;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property TabStop;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TSgtsComboBox=class(TComboBox)
  private
    FReport: TfrxReport;
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    property Report: TfrxReport read FReport write FReport;
  end;

  TSgtsComboBoxControl = class(TfrxDialogControl)
  private
    FComboBox: TSgtsComboBox;
    FOnChange: TfrxNotifyEvent;
    function GetItemIndex: Integer;
    function GetItems: TStrings;
    function GetStyle: TComboBoxStyle;
    function GetText: String;
    procedure DoOnChange(Sender: TObject);
    procedure SetItemIndex(const Value: Integer);
    procedure SetItems(const Value: TStrings);
    procedure SetStyle(const Value: TComboBoxStyle);
    procedure SetText(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property ComboBox: TSgtsComboBox read FComboBox;
  published
    property Color;
    property Items: TStrings read GetItems write SetItems;
    property Style: TComboBoxStyle read GetStyle write SetStyle default csDropDown;
    property TabStop;
    property Text: String read GetText write SetText;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TSgtsDateEdit=class(TDateEdit)
  private
    FReport: TfrxReport;
    FOldColor: TColor;
    FOldLabelColor: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    property Report: TfrxReport read FReport write FReport;
  end;

  TSgtsDateEditControl = class(TfrxDialogControl)
  private
    FDateEdit: TSgtsDateEdit;
    FOnChange: TfrxNotifyEvent;
    function GetDate: Variant;
    procedure DoOnChange(Sender: TObject);
    procedure SetDate(const Value: Variant);
    function GetText: String;
    procedure SetText(Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property DateEdit: TSgtsDateEdit read FDateEdit;
  published
    property Color;
    property Date: Variant read GetDate write SetDate;
    property Text: String read GetText write SetText;
    property TabStop;
    property OnChange: TfrxNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TSgtsRadioButton=class(TRadioButton)
  private
    FReport: TfrxReport;
  protected
    property Report: TfrxReport read FReport write FReport;
  end;

  TSgtsRadioButtonControl = class(TfrxDialogControl)
  private
    FRadioButton: TSgtsRadioButton;
    function GetAlignment: TAlignment;
    function GetChecked: Boolean;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetChecked(const Value: Boolean);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property RadioButton: TSgtsRadioButton read FRadioButton;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment
      default taRightJustify;
    property Caption;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property TabStop;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property Color;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TSgtsWinControlProperty=class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

implementation

uses StrUtils,
     frxRes, fs_iinterpreter,
     SgtsUtils, SgtsConsts, SgtsDataFm, SgtsCDS, SgtsCoreIntf;

function GetLabelByReport(WinControl: TControl; FReport: TfrxReport): TLabel;
var
  i: Integer;
  c: TfrxComponent;
  Control: TControl;
begin
  Result:=nil;
  if Assigned(FReport) then begin
    for i:=0 to FReport.AllObjects.Count-1 do begin
      c:=TfrxComponent(FReport.AllObjects.Items[i]);
      if Assigned(c) and (c is TfrxDialogControl) then begin
        Control:=TfrxDialogControl(c).Control;
        if Assigned(Control) and (Control is TLabel) then begin
          if TLabel(Control).FocusControl=WinControl then begin
            Result:=TLabel(Control);
            break;
          end;
        end;
      end;
    end;
  end;
end;

type
  TFunctions=class(TfsRTTIModule)
  public
    constructor Create(AScript: TfsScript); override;
  end;

{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do begin
    AddClass(TSgtsLabelControl,'TfrxDialogControl');
    AddClass(TSgtsEditControl,'TfrxDialogControl');
    AddClass(TSgtsMemoControl,'TfrxDialogControl');
    AddClass(TSgtsComboBoxControl,'TfrxDialogControl');
    AddClass(TSgtsDateEditControl,'TfrxDialogControl');
    AddClass(TSgtsRadioButtonControl,'TfrxDialogControl');
  end;
end;

{ TSgtsLabelControl }

constructor TSgtsLabelControl.Create(AOwner: TComponent);
begin
  inherited;
  BaseName:=SLabel;
  FLabel := TLabel.Create(nil);
  InitControl(FLabel);
end;

class function TSgtsLabelControl.GetDescription: String;
begin
  Result := SLabelDecs;
end;

procedure TSgtsLabelControl.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  if FLabel.AutoSize then
  begin
    Width := FLabel.Width;
    Height := FLabel.Height;
  end
  else
  begin
    FLabel.Width := Round(Width);
    FLabel.Height := Round(Height);
  end;
  inherited;
end;

function TSgtsLabelControl.GetAlignment: TAlignment;
begin
  Result := FLabel.Alignment;
end;

function TSgtsLabelControl.GetAutoSize: Boolean;
begin
  Result := FLabel.AutoSize;
end;

function TSgtsLabelControl.GetWordWrap: Boolean;
begin
  Result := FLabel.WordWrap;
end;

procedure TSgtsLabelControl.SetAlignment(const Value: TAlignment);
begin
  FLabel.Alignment := Value;
end;

procedure TSgtsLabelControl.SetAutoSize(const Value: Boolean);
begin
  FLabel.AutoSize := Value;
end;

procedure TSgtsLabelControl.SetWordWrap(const Value: Boolean);
begin
  FLabel.WordWrap := Value;
end;

procedure TSgtsLabelControl.BeforeStartReport;
begin
  if not FLabel.AutoSize then
  begin
    FLabel.Width := Round(Width);
    FLabel.Height := Round(Height);
  end;
end;

procedure TSgtsLabelControl.SetFocusControl(Value: TfrxDialogControl);
var
  i: Integer;
  c: TfrxComponent;
  Control: TControl;
begin
  if FFocusControl<>Value then
    if Assigned(FLabel) and Assigned(Report) then begin
      for i:=0 to Report.AllObjects.Count-1 do begin
        c:=TfrxComponent(Report.AllObjects.Items[i]);
        if Assigned(c) and (c is TfrxDialogControl) then begin
          if TfrxDialogControl(c)=Value then begin
            Control:=TfrxDialogControl(c).Control;
            if Assigned(Control) and (Control is TWinControl) then begin
              FLabel.FocusControl:=TWinControl(Control);
              FLabel.FocusControl.FreeNotification(Self);
              FFocusControl:=Value;
            end;
            break;
          end;
        end;
      end;
    end;
end;

procedure TSgtsLabelControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if Assigned(FLabel) and (AComponent=FFocusControl) and (Operation=opRemove) then begin
    FFocusControl:=nil;
    FLabel.FocusControl:=nil;
  end;
end;

{ TSgtsEdit }

procedure TSgtsEdit.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TSgtsEdit.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TSgtsEditControl }

constructor TSgtsEditControl.Create(AOwner: TComponent);
begin
  inherited;
  BaseName:=SEdit;
  FEdit := TSgtsEdit.Create(nil);
  FEdit.Report:=Report;
  FEdit.OnChange := DoOnChange;
  InitControl(FEdit);
  Width := 121;
  Height := 21;
end;

class function TSgtsEditControl.GetDescription: String;
begin
  Result := SEditDesc;
end;

function TSgtsEditControl.GetMaxLength: Integer;
begin
  Result := FEdit.MaxLength;
end;

function TSgtsEditControl.GetPasswordChar: Char;
begin
  Result := FEdit.PasswordChar;
end;

function TSgtsEditControl.GetReadOnly: Boolean;
begin
  Result := FEdit.ReadOnly;
end;

function TSgtsEditControl.GetText: String;
begin
  Result := FEdit.Text;
end;

procedure TSgtsEditControl.SetMaxLength(const Value: Integer);
begin
  FEdit.MaxLength := Value;
end;

procedure TSgtsEditControl.SetPasswordChar(const Value: Char);
begin
  FEdit.PasswordChar := Value;
end;

procedure TSgtsEditControl.SetReadOnly(const Value: Boolean);
begin
  FEdit.ReadOnly := Value;
end;

procedure TSgtsEditControl.SetText(const Value: String);
begin
  FEdit.Text := Value;
end;

procedure TSgtsEditControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange);
end;

{ TSgtsMemo }

procedure TSgtsMemo.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TSgtsMemo.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TSgtsMemoControl }

constructor TSgtsMemoControl.Create(AOwner: TComponent);
begin
  inherited;
  BaseName:=SMemo;
  FMemo := TSgtsMemo.Create(nil);
  FMemo.Report:=Report;
  FMemo.OnChange := DoOnChange;
  InitControl(FMemo);
  Width := 185;
  Height := 89;
end;

function TSgtsMemoControl.GetAlignment: TAlignment;
begin
  Result := FMemo.Alignment;
end;

class function TSgtsMemoControl.GetDescription: String;
begin
  Result := SMemoDesc;
end;

function TSgtsMemoControl.GetMaxLength: Integer;
begin
  Result := FMemo.MaxLength;
end;

function TSgtsMemoControl.GetPasswordChar: Char;
begin
  Result := FMemo.PasswordChar;
end;

function TSgtsMemoControl.GetReadOnly: Boolean;
begin
  Result := FMemo.ReadOnly;
end;

function TSgtsMemoControl.GetText: String;
begin
  Result := FMemo.Text;
end;

procedure TSgtsMemoControl.SetMaxLength(const Value: Integer);
begin
  FMemo.MaxLength := Value;
end;

procedure TSgtsMemoControl.SetPasswordChar(const Value: Char);
begin
  FMemo.PasswordChar := Value;
end;

procedure TSgtsMemoControl.SetReadOnly(const Value: Boolean);
begin
  FMemo.ReadOnly := Value;
end;

procedure TSgtsMemoControl.SetText(const Value: String);
begin
  FMemo.Text := Value;
end;

procedure TSgtsMemoControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange);
end;

function TSgtsMemoControl.GetLines: TStrings;
begin
  Result := FMemo.Lines;
end;

function TSgtsMemoControl.GetScrollStyle: TScrollStyle;
begin
  Result := FMemo.ScrollBars;
end;

function TSgtsMemoControl.GetWordWrap: Boolean;
begin
  Result := FMemo.WordWrap;
end;

procedure TSgtsMemoControl.SetAlignment(const Value: TAlignment);
begin
  FMemo.Alignment := Value;
end;

procedure TSgtsMemoControl.SetLines(const Value: TStrings);
begin
  FMemo.Lines := Value;
end;

procedure TSgtsMemoControl.SetScrollStyle(const Value: TScrollStyle);
begin
  FMemo.ScrollBars := Value;
end;

procedure TSgtsMemoControl.SetWordWrap(const Value: Boolean);
begin
  FMemo.WordWrap := Value;
end;

{ TSgtsComboBox }

procedure TSgtsComboBox.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TSgtsComboBox.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TSgtsComboBoxControl }

constructor TSgtsComboBoxControl.Create(AOwner: TComponent);
begin
  inherited;
  FComboBox := TSgtsComboBox.Create(nil);
  FComboBox.OnChange := DoOnChange;
  FComboBox.Report:=Report;
  InitControl(FComboBox);

  Width := 145;
  Height := 21;
end;

class function TSgtsComboBoxControl.GetDescription: String;
begin
  Result := frxResources.Get('obCBox');
end;

function TSgtsComboBoxControl.GetItems: TStrings;
begin
  Result := FComboBox.Items;
end;

function TSgtsComboBoxControl.GetItemIndex: Integer;
begin
  Result := FComboBox.ItemIndex;
end;

function TSgtsComboBoxControl.GetStyle: TComboBoxStyle;
begin
  Result := FComboBox.Style;
end;

function TSgtsComboBoxControl.GetText: String;
begin
  Result := FComboBox.Text;
end;

procedure TSgtsComboBoxControl.SetItems(const Value: TStrings);
begin
  FComboBox.Items := Value;
end;

procedure TSgtsComboBoxControl.SetItemIndex(const Value: Integer);
begin
  FComboBox.ItemIndex := Value;
end;

procedure TSgtsComboBoxControl.SetStyle(const Value: TComboBoxStyle);
begin
  FComboBox.Style := Value;
end;

procedure TSgtsComboBoxControl.SetText(const Value: String);
begin
  FComboBox.Text := Value;
end;

procedure TSgtsComboBoxControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange);
end;

{ TSgtsDateEdit }

procedure TSgtsDateEdit.CMEnter(var Message: TCMEnter);
var
  lb: TLabel;
begin
  FOldColor:=Color;
  Color:=iff(Color<>clBtnFace,ElementFocusColor,Color);
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    FOldLabelColor:=lb.Font.Color;
    lb.Font.Color:=ElementLabelFocusColor;
  end;
  inherited;
end;

procedure TSgtsDateEdit.CMExit(var Message: TCMExit);
var
  lb: TLabel;
begin
  inherited;
  lb:=GetLabelByReport(Self,FReport);
  if lb<>nil then begin
    lb.Font.Color:=FOldLabelColor;
  end;
  Color:=FOldColor;
end;

{ TSgtsDateEditControl }

constructor TSgtsDateEditControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BaseName:=SDateEdit;
  FDateEdit := TSgtsDateEdit.Create(nil);
  FDateEdit.OnChange := DoOnChange;
  FDateEdit.Report:=Report;
  InitControl(FDateEdit);

  Width := 145;
  Height := 21;
end;

class function TSgtsDateEditControl.GetDescription: String;
begin
  Result:=SDateEditDesc;
end;

function TSgtsDateEditControl.GetDate: Variant;
var
  S: String;
  V: Variant;
  D: TDate;
const
  NullDate: TDate=0.0;  
begin
  S:=DateToStr(FDateEdit.Date);
  V:=StrToDate(S);
  D:=V;
  if D=NullDate then
    Result:=Null
  else
    Result := V;
end;

procedure TSgtsDateEditControl.SetDate(const Value: Variant);
var
  V: Variant;
  S: String;
begin
  V:=Value;
  if VarType(V)=varString then begin
    S:=VarToStrDef(V,'');
    V:=StrToDateDef(S,FDateEdit.Date);
  end;
  FDateEdit.Date:= VarToDateDef(V,FDateEdit.Date);
end;

function TSgtsDateEditControl.GetText: String;
begin
  Result:=FDateEdit.Text;
end;

procedure TSgtsDateEditControl.SetText(Value: String);
begin
  FDateEdit.Text:=Value;
end;

procedure TSgtsDateEditControl.DoOnChange(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnChange);
end;

{ TSgtsRadioButton }

{ TSgtsRadioButtonControl }

constructor TSgtsRadioButtonControl.Create(AOwner: TComponent);
begin
  inherited;
  BaseName:=SRadioButton;
  FRadioButton := TSgtsRadioButton.Create(nil);
  InitControl(FRadioButton);

  Width := 113;
  Height := 17;
  Alignment := taRightJustify;
end;

class function TSgtsRadioButtonControl.GetDescription: String;
begin
  Result := SRadioButtonDesc;
end;

function TSgtsRadioButtonControl.GetAlignment: TAlignment;
begin
  Result := FRadioButton.Alignment;
end;

function TSgtsRadioButtonControl.GetChecked: Boolean;
begin
  Result := FRadioButton.Checked;
end;

procedure TSgtsRadioButtonControl.SetAlignment(const Value: TAlignment);
begin
  FRadioButton.Alignment := Value;
end;

procedure TSgtsRadioButtonControl.SetChecked(const Value: Boolean);
begin
  FRadioButton.Checked := Value;
end;

function TSgtsRadioButtonControl.GetWordWrap: Boolean;
begin
  Result := FRadioButton.WordWrap;
end;

procedure TSgtsRadioButtonControl.SetWordWrap(const Value: Boolean);
begin
  FRadioButton.WordWrap := Value;
end;

{ TSgtsWinControlProperty }

function TSgtsWinControlProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result:=[paMultiSelect, paValueList, paSortList];
end;

function TSgtsWinControlProperty.GetValue: String;
var
  c: TComponent;
begin
  c := TComponent(GetOrdValue);
  if c <> nil then
    Result := c.Name else
    Result := '';
end;

procedure TSgtsWinControlProperty.GetValues;
var
  i: Integer;
  c: TfrxComponent;
  Control: TControl;
begin
  inherited GetValues;
  if Component is TfrxDialogControl then begin
    if Assigned(frComponent) then begin
      for i:=0 to frComponent.Report.AllObjects.Count-1 do begin
        c:=TfrxComponent(frComponent.Report.AllObjects.Items[i]);
        if Assigned(c) and (c is TfrxDialogControl) then begin
          Control:=TfrxDialogControl(c).Control;
          if Assigned(Control) and (Control is TWinControl) then
            Values.Add(TfrxDialogControl(c).Name);
        end;
      end;
    end;
  end;
end;

procedure TSgtsWinControlProperty.SetValue(const Value: String);
var
  c: TComponent;
begin
  c := nil;
  if Value <> '' then
  begin
    c := frComponent.Report.FindObject(Value);
    if c = nil then
      raise Exception.Create(frxResources.Get('prInvProp'));
  end;

  SetOrdValue(Integer(c));
end;

initialization
  frxObjects.RegisterObject1(TSgtsLabelControl, nil, '', '', 0, 12);
  frxObjects.RegisterObject1(TSgtsEditControl, nil, '', '', 0, 13);
  frxObjects.RegisterObject1(TSgtsMemoControl, nil, '', '', 0, 14);
  frxObjects.RegisterObject1(TSgtsRadioButtonControl, nil, '', '', 0, 17);
  frxObjects.RegisterObject1(TSgtsComboBoxControl, nil, '', '', 0, 19);
  frxObjects.RegisterObject1(TSgtsDateEditControl, nil, '', '', 0, 20);
  frxPropertyEditors.Register(TypeInfo(TWinControl),TSgtsLabelControl,'FocusControl',TSgtsWinControlProperty);
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then fsRTTIModules.Remove(TFunctions);
  frxObjects.UnRegister(TSgtsDateEditControl);


end.
