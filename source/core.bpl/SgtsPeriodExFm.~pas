unit SgtsPeriodExFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  SgtsDialogFm, SgtsFm, SgtsDateEdit, SgtsCoreIntf, SgtsPeriodFm;

type
  TSgtsPeriodExType=(petDate,petCycle);

  TSgtsPeriodExForm = class(TSgtsDialogForm)
    LabelPeriodEnd: TLabel;
    LabelPeriodBegin: TLabel;
    LabelCycleBegin: TLabel;
    LabelCycleEnd: TLabel;
    RadioButtonPeriod: TRadioButton;
    DateTimePickerPeriodBegin: TDateTimePicker;
    DateTimePickerPeriodEnd: TDateTimePicker;
    RadioButtonCycle: TRadioButton;
    EditCycleBegin: TEdit;
    ButtonCycleBegin: TButton;
    EditCycleEnd: TEdit;
    ButtonCycleEnd: TButton;
    ButtonPeriod: TButton;
    procedure ButtonPeriodClick(Sender: TObject);
    procedure ButtonCycleBeginClick(Sender: TObject);
    procedure ButtonCycleEndClick(Sender: TObject);
    procedure RadioButtonPeriodClick(Sender: TObject);
  private
    FPeriodType: TSgtsPeriodType;
    FDatePeriodBegin: TSgtsDateEdit;
    FDatePeriodEnd: TSgtsDateEdit;

    function SelectCycle(var CycleNum: Variant): Boolean;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

    property DatePeriodBegin: TSgtsDateEdit read FDatePeriodBegin;
    property DatePeriodEnd: TSgtsDateEdit read FDatePeriodEnd;
  end;

  TSgtsPeriodExIface=class(TSgtsDialogIface)
  private
    FPeriodType: TSgtsPeriodExType;
    FDateBegin: Variant;
    FDateEnd: Variant;
    FCycleBegin: Variant;
    FCycleEnd: Variant;

    function GetForm: TSgtsPeriodExForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;
  public
    function Select(var PeriodType: TSgtsPeriodExType; var DateBegin, DateEnd, CycleBegin, CycleEnd: Variant): Boolean;

    property Form: TSgtsPeriodExForm read GetForm;
  end;

var
  SgtsPeriodExForm: TSgtsPeriodExForm;

implementation

uses SgtsUtils, SgtsRbkCyclesFm, SgtsCDS;

{$R *.dfm}

{ TSgtsPeriodExIface }

function TSgtsPeriodExIface.GetForm: TSgtsPeriodExForm;
begin
  Result:=TSgtsPeriodExForm(inherited Form);                             
end;

function TSgtsPeriodExIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsPeriodExForm;
end;

procedure TSgtsPeriodExIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  Form.RadioButtonPeriod.Checked:=FPeriodType=petDate;
  Form.RadioButtonCycle.Checked:=FPeriodType=petCycle;
  with Form do begin
    RadioButtonPeriodClick(nil);
    if not VarIsNull(FDateBegin) then
      DatePeriodBegin.Date:=FDateBegin
    else DatePeriodBegin.Text:='';
    if not VarIsNull(FDateEnd) then
      DatePeriodEnd.Date:=FDateEnd
    else DatePeriodEnd.Text:='';
    EditCycleBegin.Text:=VarToStrDef(FCycleBegin,'');
    EditCycleEnd.Text:=VarToStrDef(FCycleEnd,'');
  end;
end;

procedure TSgtsPeriodExIface.AfterShowModal(ModalResult: TModalResult);
var
  C1,C2: Integer;
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    FPeriodType:=iff(Form.RadioButtonPeriod.Checked,petDate,petCycle);
    with Form do begin
      FDateBegin:=FDatePeriodBegin.Date2;
      FDateEnd:=FDatePeriodEnd.Date2;
      FCycleBegin:=Null;
      if TryStrToInt(Trim(EditCycleBegin.Text),C1) then
        FCycleBegin:=C1;
      FCycleEnd:=Null;
      if TryStrToInt(Trim(EditCycleEnd.Text),C2) then
        FCycleEnd:=C2;
    end;
  end;
end;

function TSgtsPeriodExIface.Select(var PeriodType: TSgtsPeriodExType; var DateBegin, DateEnd, CycleBegin, CycleEnd: Variant): Boolean;
begin
  Result:=false;
  Init;
  FPeriodType:=PeriodType;
  FDateBegin:=DateBegin;
  FDateEnd:=DateEnd;
  FCycleBegin:=CycleBegin;
  FCycleEnd:=CycleEnd;
  if ShowModal=mrOk then begin
    Result:=true;
    PeriodType:=FPeriodType;
    DateBegin:=FDateBegin;
    DateEnd:=FDateEnd;
    CycleBegin:=FCycleBegin;
    CycleEnd:=FCycleEnd;
  end;  
end;

{ TSgtsPeriodExForm }

constructor TSgtsPeriodExForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);

  FPeriodType:=ptMonth;

  FDatePeriodBegin:=TSgtsDateEdit.Create(Self);
  FDatePeriodBegin.Parent:=DateTimePickerPeriodBegin.Parent;
  FDatePeriodBegin.SetBounds(DateTimePickerPeriodBegin.Left,DateTimePickerPeriodBegin.Top,DateTimePickerPeriodBegin.Width,DateTimePickerPeriodBegin.Height);
  FDatePeriodBegin.TabOrder:=DateTimePickerPeriodBegin.TabOrder;
  FDatePeriodBegin.Enabled:=DateTimePickerPeriodBegin.Enabled;
  FDatePeriodBegin.Color:=DateTimePickerPeriodBegin.Color;
  FDatePeriodBegin.Hint:=DateTimePickerPeriodBegin.Hint;
  LabelPeriodBegin.FocusControl:=FDatePeriodBegin;
  DateTimePickerPeriodBegin.Free;

  FDatePeriodEnd:=TSgtsDateEdit.Create(Self);
  FDatePeriodEnd.Parent:=DateTimePickerPeriodEnd.Parent;
  FDatePeriodEnd.SetBounds(DateTimePickerPeriodEnd.Left,DateTimePickerPeriodEnd.Top,DateTimePickerPeriodEnd.Width,DateTimePickerPeriodEnd.Height);
  FDatePeriodEnd.TabOrder:=DateTimePickerPeriodEnd.TabOrder;
  FDatePeriodEnd.Enabled:=DateTimePickerPeriodEnd.Enabled;
  FDatePeriodEnd.Color:=DateTimePickerPeriodEnd.Color;
  FDatePeriodEnd.Hint:=DateTimePickerPeriodEnd.Hint;
  LabelPeriodEnd.FocusControl:=FDatePeriodEnd;
  DateTimePickerPeriodEnd.Free;
end;

destructor TSgtsPeriodExForm.Destroy;
begin
  FDatePeriodEnd.Free;
  FDatePeriodBegin.Free;
  inherited Destroy;
end;

procedure TSgtsPeriodExForm.ButtonPeriodClick(Sender: TObject);
var
  AIface: TSgtsPeriodIface;
  DateBegin: TDate;
  DateEnd: TDate;
begin
  AIface:=TSgtsPeriodIface.Create(CoreIntf);
  try
    DateBegin:=DatePeriodBegin.Date;
    DateEnd:=DatePeriodEnd.Date;
    if AIface.Select(FPeriodType,DateBegin,DateEnd) then begin
      DatePeriodBegin.Date:=DateBegin;
      DatePeriodEnd.Date:=DateEnd;
    end;
  finally
    AIface.Free;
  end;
end;

function TSgtsPeriodExForm.SelectCycle(var CycleNum: Variant): Boolean;
var
  AIface: TSgtsRbkCyclesIface;
  DS: TSgtsCDS;
  Data: String;
begin
  AIface:=TSgtsRbkCyclesIface.Create(CoreIntf);
  try
    Result:=false;
    if AIface.SelectVisible('CYCLE_NUM',CycleNum,Data) then begin
      DS:=TSgtsCDS.Create(nil);
      try
        DS.XMLData:=Data;
        Result:=DS.Active and not DS.IsEmpty;
        if Result then
         CycleNum:=DS.FieldByName('CYCLE_NUM').Value;
      finally
        DS.Free;
      end;
    end;
  finally
    AIface.Free;
  end;
end;

procedure TSgtsPeriodExForm.ButtonCycleBeginClick(Sender: TObject);
var
  CycleNum: Variant;
  TryValue: Integer;
begin
  CycleNum:=Null;
  if TryStrToInt(EditCycleBegin.Text,TryValue) then
    CycleNum:=TryValue;
  if SelectCycle(CycleNum) then
    EditCycleBegin.Text:=VarToStrDef(CycleNum,'');
end;

procedure TSgtsPeriodExForm.ButtonCycleEndClick(Sender: TObject);
var
  CycleNum: Variant;
  TryValue: Integer;
begin
  CycleNum:=Null;
  if TryStrToInt(EditCycleEnd.Text,TryValue) then
    CycleNum:=TryValue;
  if SelectCycle(CycleNum) then
    EditCycleEnd.Text:=VarToStrDef(CycleNum,'');
end;

procedure TSgtsPeriodExForm.RadioButtonPeriodClick(Sender: TObject);
begin
  LabelPeriodBegin.Enabled:=RadioButtonPeriod.Checked;
  DatePeriodBegin.Enabled:=RadioButtonPeriod.Checked;
  DatePeriodBegin.Color:=iff(RadioButtonPeriod.Checked,clWindow,clBtnFace);
  LabelPeriodEnd.Enabled:=RadioButtonPeriod.Checked;
  DatePeriodEnd.Enabled:=RadioButtonPeriod.Checked;
  DatePeriodEnd.Color:=iff(RadioButtonPeriod.Checked,clWindow,clBtnFace);
  ButtonPeriod.Enabled:=RadioButtonPeriod.Checked;

  LabelCycleBegin.Enabled:=RadioButtonCycle.Checked;
  EditCycleBegin.Enabled:=RadioButtonCycle.Checked;
  EditCycleBegin.Color:=iff(RadioButtonCycle.Checked,clWindow,clBtnFace);
  ButtonCycleBegin.Enabled:=RadioButtonCycle.Checked;
  LabelCycleEnd.Enabled:=RadioButtonCycle.Checked;
  EditCycleEnd.Enabled:=RadioButtonCycle.Checked;
  EditCycleEnd.Color:=iff(RadioButtonCycle.Checked,clWindow,clBtnFace);
  ButtonCycleEnd.Enabled:=RadioButtonCycle.Checked;
end;

end.
