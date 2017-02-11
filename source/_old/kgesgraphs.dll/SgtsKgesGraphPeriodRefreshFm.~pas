unit SgtsKgesGraphPeriodRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, CheckLst, ComCtrls, Contnrs, ExtCtrls,
  SgtsKgesGraphRefreshFm, SgtsDateEdit, SgtsPeriodFm, SgtsCoreIntf, SgtsFm,
  SgtsGraphIfaceIntf, SgtsPeriodExFm;

type
  TSgtsKgesGraphHistoryType=TSgtsPeriodExType;

  TSgtsKgesGraphHistory=class(TObject)
  private
    FCaption: String;
    FHistoryType: TSgtsKgesGraphHistoryType;
    FDateBegin: Variant;
    FDateEnd: Variant;
    FCycleBegin: Variant;
    FCycleEnd: Variant;
  public
    property Caption: String read FCaption write FCaption;
    property HistoryType: TSgtsKgesGraphHistoryType read FHistoryType write FHistoryType;
    property DateBegin: Variant read FDateBegin write FDateBegin;
    property DateEnd: Variant read FDateEnd write FDateEnd;
    property CycleBegin: Variant read FCycleBegin write FCycleBegin;
    property CycleEnd: Variant read FCycleEnd write FCycleEnd;
  end;

  TSgtsKgesGraphHistories=class(TObjectList)
  private
    function GetItems(Index: Integer): TSgtsKgesGraphHistory;
    procedure SetItems(Index: Integer; Value: TSgtsKgesGraphHistory);
  public
    function Add(Caption: String; HistoryType: TSgtsKgesGraphHistoryType;
                 DateBegin, DateEnd, CycleBegin, CycleEnd: Variant): TSgtsKgesGraphHistory;
    procedure CopyFrom(Source: TSgtsKgesGraphHistories);

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    function GetHistoriesStr: String;
    procedure SetHistoriesStr(Value: String);

    property Items[Index: Integer]: TSgtsKgesGraphHistory read GetItems write SetItems;
  end;  

  TSgtsKgesGraphPeriodRefreshIface=class;

  TSgtsKgesGraphPeriodRefreshForm = class(TSgtsKgesGraphRefreshForm)
    PanelPeriod: TPanel;
    GroupBoxPeriod: TGroupBox;
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
    PanelHistory: TPanel;
    GroupBoxHistory: TGroupBox;
    PanelListBoxHistory: TPanel;
    PanelButtonsHistory: TPanel;
    ListBoxHistory: TListBox;
    ButtonHistoryAdd: TButton;
    ButtonHistoryClear: TButton;
    procedure RadioButtonCycleClick(Sender: TObject);
    procedure ButtonPeriodClick(Sender: TObject);
    procedure ButtonCycleBeginClick(Sender: TObject);
    procedure ButtonCycleEndClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonDefaultClick(Sender: TObject);
    procedure ButtonHistoryClearClick(Sender: TObject);
    procedure ListBoxHistoryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonHistoryAddClick(Sender: TObject);
    procedure ListBoxHistoryDblClick(Sender: TObject);
  private
    FDatePeriodBegin: TSgtsDateEdit;
    FDatePeriodEnd: TSgtsDateEdit;
    FPeriodType: TSgtsPeriodType;
    FHistories: TSgtsKgesGraphHistories;

    function GetIface: TSgtsKgesGraphPeriodRefreshIface;
    function SelectCycle(var CycleNum: Variant): Boolean;
    procedure FillHistories;
    function GetFirstHistorySelected: TSgtsKgesGraphHistory;
    
    property PeriodType: TSgtsPeriodType read FPeriodType write FPeriodType;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

    property DatePeriodBegin: TSgtsDateEdit read FDatePeriodBegin;
    property DatePeriodEnd: TSgtsDateEdit read FDatePeriodEnd;
    property Iface: TSgtsKgesGraphPeriodRefreshIface read GetIface;
  end;

  TSgtsKgesGraphPeriodRefreshIface=class(TSgtsKgesGraphRefreshIface)
  private
    FPeriodType: TSgtsPeriodType;
    FPeriodChecked: Boolean;
    FDateBegin: String;
    FDateEnd: String;
    FCycleChecked: Boolean;
    FCycleBegin: String;
    FCycleEnd: String;
    FDefaultHistories: TSgtsKgesGraphHistories;
    FHistories: TSgtsKgesGraphHistories;
    FParamHistories: String;

    function GetForm: TSgtsKgesGraphPeriodRefreshForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;

    property DefaultHistories: TSgtsKgesGraphHistories read FDefaultHistories;
  public
    constructor Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsGraphIface); override;
    destructor Destroy; override;

    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;

    procedure BeforeReadParams; override;
    procedure BeforeWriteParams; override;

    function GetHistoryCaption(HistoryType: TSgtsKgesGraphHistoryType;
                               DateBegin, DateEnd, CycleBegin, CycleEnd: Variant): String; virtual;

    property PeriodChecked: Boolean read FPeriodChecked write FPeriodChecked;
    property DateBegin: String read FDateBegin write FDateBegin;
    property DateEnd: String read FDateEnd write FDateEnd;
    property CycleChecked: Boolean read FCycleChecked write FCycleChecked;
    property CycleBegin: String read FCycleBegin write FCycleBegin;
    property CycleEnd: String read FCycleEnd write FCycleEnd;
    property Form: TSgtsKgesGraphPeriodRefreshForm read GetForm;
    property Histories: TSgtsKgesGraphHistories read FHistories;
  end;

var
  SgtsKgesGraphPeriodRefreshForm: TSgtsKgesGraphPeriodRefreshForm;

implementation

uses SgtsUtils, SgtsRbkCyclesFm, SgtsCDS, SgtsConsts, SgtsDialogs,
     SgtsKgesGraphsConsts, SgtsConfigIntf;

{$R *.dfm}

{ TSgtsKgesGraphHistories }

function TSgtsKgesGraphHistories.GetItems(Index: Integer): TSgtsKgesGraphHistory;
begin
  Result:=TSgtsKgesGraphHistory(inherited Items[Index]);
end;

procedure TSgtsKgesGraphHistories.SetItems(Index: Integer; Value: TSgtsKgesGraphHistory);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsKgesGraphHistories.Add(Caption: String; HistoryType: TSgtsKgesGraphHistoryType;
                                     DateBegin, DateEnd, CycleBegin, CycleEnd: Variant): TSgtsKgesGraphHistory;
begin
  Result:=TSgtsKgesGraphHistory.Create;
  Result.Caption:=Caption;
  Result.HistoryType:=HistoryType;
  Result.DateBegin:=DateBegin;
  Result.DateEnd:=DateEnd;
  Result.CycleBegin:=CycleBegin;
  Result.CycleEnd:=CycleEnd;
  inherited Add(Result);
end;

procedure TSgtsKgesGraphHistories.CopyFrom(Source: TSgtsKgesGraphHistories);
var
  i: Integer;
  History1, History2: TSgtsKgesGraphHistory;
begin
  if Assigned(Source) then begin
    Clear;
    for i:=0 to Source.Count-1 do begin
      History1:=Source.Items[i];
      History2:=Add(History1.Caption,History1.HistoryType,
                    History1.DateBegin,History1.DateEnd,History1.CycleBegin,History1.CycleEnd);
      if Assigned(History2) then begin
      end;                    
    end;
  end;
end;

procedure TSgtsKgesGraphHistories.LoadFromStream(Stream: TStream);
var
  Reader: TReader;
  Item: TSgtsKgesGraphHistory;
  Caption: String;
  HistoryType: TSgtsKgesGraphHistoryType;
  DateBegin, DateEnd, CycleBegin, CycleEnd: Variant;
begin
  Reader:=TReader.Create(Stream,FilerPageSize);
  try
    Reader.ReadListBegin;
    Clear;
    while not Reader.EndOfList do begin
      Caption:=Reader.ReadString;
      HistoryType:=TSgtsKgesGraphHistoryType(Reader.ReadInteger);
      DateBegin:=Reader.ReadVariant;
      DateEnd:=Reader.ReadVariant;
      CycleBegin:=Reader.ReadVariant;
      CycleEnd:=Reader.ReadVariant;
      Item:=Add(Caption,HistoryType,DateBegin,DateEnd,CycleBegin,CycleEnd);
      if Assigned(Item) then begin

      end;
    end;
    Reader.ReadListEnd;
  finally
    Reader.Free;
  end;  
end;

procedure TSgtsKgesGraphHistories.SaveToStream(Stream: TStream);
var
  i: Integer;
  Writer: TWriter;
  Item: TSgtsKgesGraphHistory;
begin
  Writer:=TWriter.Create(Stream,FilerPageSize);
  try
    Writer.WriteListBegin;
    for i:=0 to Count-1 do begin
      Item:=Items[i];
      Writer.WriteString(Item.Caption);
      Writer.WriteInteger(Integer(Item.HistoryType));
      Writer.WriteVariant(Item.DateBegin);
      Writer.WriteVariant(Item.DateEnd);
      Writer.WriteVariant(Item.CycleBegin);
      Writer.WriteVariant(Item.CycleEnd);
    end;
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;
end;

function TSgtsKgesGraphHistories.GetHistoriesStr: String;
var
  S: String;
  Stream: TMemoryStream;
begin
  Stream:=TMemoryStream.Create;
  try
    Result:='';
    SaveToStream(Stream);
    SetLength(S,Stream.Size);
    System.Move(Stream.Memory^,Pointer(S)^,Stream.Size);
    Result:=S;
  finally
    Stream.Free;
  end;
end;

procedure TSgtsKgesGraphHistories.SetHistoriesStr(Value: String);
var
  Stream: TMemoryStream;
  DefStream: TMemoryStream;
begin
  Stream:=TMemoryStream.Create;
  DefStream:=TMemoryStream.Create;
  try
    SaveToStream(DefStream);
    DefStream.Position:=0;
    Stream.SetSize(Length(Value));
    System.Move(Pointer(Value)^,Stream.Memory^,Length(Value));
    try
      LoadFromStream(Stream);
    except
      LoadFromStream(DefStream);
    end;
  finally
    DefStream.Free;
    Stream.Free;
  end;
end;

{ TSgtsKgesGraphPeriodRefreshIface }

constructor TSgtsKgesGraphPeriodRefreshIface.Create(ACoreIntf: ISgtsCore; AIfaceIntf: ISgtsGraphIface);
begin
  inherited Create(ACoreIntf,AIfaceIntf);
  FHistories:=TSgtsKgesGraphHistories.Create;
  FDefaultHistories:=TSgtsKgesGraphHistories.Create;
  FPeriodChecked:=true;
end;

destructor TSgtsKgesGraphPeriodRefreshIface.Destroy;
begin
  FDefaultHistories.Free;
  FHistories.Free;
  inherited Destroy;
end;

function TSgtsKgesGraphPeriodRefreshIface.GetForm: TSgtsKgesGraphPeriodRefreshForm;
begin
  Result:=TSgtsKgesGraphPeriodRefreshForm(inherited Form);
end;

function TSgtsKgesGraphPeriodRefreshIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsKgesGraphPeriodRefreshForm;
end;

procedure TSgtsKgesGraphPeriodRefreshIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  if Assigned(Form) then begin
    Form.PeriodType:=FPeriodType;
    with Form do begin
      RadioButtonPeriod.Checked:=FPeriodChecked;
      RadioButtonCycle.Checked:=not FPeriodChecked;
      DatePeriodBegin.Text:=FDateBegin;
      DatePeriodEnd.Text:=FDateEnd;
      EditCycleBegin.Text:=FCycleBegin;
      EditCycleEnd.Text:=FCycleEnd;
    end;
    Form.FHistories.CopyFrom(FHistories);
    Form.FillHistories;
  end;
end;

procedure TSgtsKgesGraphPeriodRefreshIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    if Assigned(Form) then begin
      FPeriodType:=Form.PeriodType;
      with Form do begin
        FPeriodChecked:=RadioButtonPeriod.Checked;
        FCycleChecked:=not FPeriodChecked;
        FDateBegin:=DatePeriodBegin.Text;
        FDateEnd:=DatePeriodEnd.Text;
        FCycleBegin:=EditCycleBegin.Text;
        FCycleEnd:=EditCycleEnd.Text;
      end;
      FHistories.CopyFrom(Form.FHistories);
    end;
  end;
end;

procedure TSgtsKgesGraphPeriodRefreshIface.BeforeReadParams;
begin
  inherited BeforeReadParams;
  FDefaultHistories.CopyFrom(FHistories);
  FParamHistories:=FHistories.GetHistoriesStr;
end;

procedure TSgtsKgesGraphPeriodRefreshIface.BeforeWriteParams;
begin
  inherited BeforeWriteParams;
  FParamHistories:=FHistories.GetHistoriesStr;
end;

procedure TSgtsKgesGraphPeriodRefreshIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  inherited ReadParams(DatabaseConfig);
  FPeriodType:=ReadParam(SConfigParamPeriodType,FPeriodType);
  FPeriodChecked:=ReadParam(SConfigParamPeriodChecked,FPeriodChecked);
  FDateBegin:=ReadParam(SConfigParamDateBegin,FDateBegin);
  FDateEnd:=ReadParam(SConfigParamDateEnd,FDateEnd);
  FCycleChecked:=not FPeriodChecked;
  FCycleBegin:=ReadParam(SConfigParamCycleBegin,FCycleBegin);
  FCycleEnd:=ReadParam(SConfigParamCycleEnd,FCycleEnd);
  FParamHistories:=ReadParam(SConfigParamHistories,FParamHistories,cmBase64);
  FHistories.SetHistoriesStr(FParamHistories);
end;

procedure TSgtsKgesGraphPeriodRefreshIface.WriteParams(DatabaseConfig: Boolean=true);
begin
  WriteParam(SConfigParamHistories,FParamHistories,cmBase64);
  WriteParam(SConfigParamPeriodType,FPeriodType);
  WriteParam(SConfigParamPeriodChecked,FPeriodChecked);
  WriteParam(SConfigParamDateBegin,FDateBegin);
  WriteParam(SConfigParamDateEnd,FDateEnd);
  WriteParam(SConfigParamCycleBegin,FCycleBegin);
  WriteParam(SConfigParamCycleEnd,FCycleEnd);
  inherited WriteParams(DatabaseConfig);
end;

function TSgtsKgesGraphPeriodRefreshIface.GetHistoryCaption(HistoryType: TSgtsKgesGraphHistoryType;
                                                            DateBegin, DateEnd, CycleBegin, CycleEnd: Variant): String;
begin
  Result:=SHistoryAllPeriod;
  case HistoryType of
    petDate: begin
      if not VarIsNull(DateBegin) then
        Result:=Format(SHistoryFromDate,[VarToStrDef(DateBegin,'')]);
      if not VarIsNull(DateEnd) then
        Result:=Format(SHistoryToDate,[VarToStrDef(DateEnd,'')]);
      if not VarIsNull(DateBegin) and
         not VarIsNull(DateEnd) then
        Result:=Format(SHistoryFromToDate,[VarToStrDef(DateBegin,''),VarToStrDef(DateEnd,'')]);
    end;
    petCycle: begin
      if not VarIsNull(CycleBegin) then
        Result:=Format(SHistoryFromCycle,[VarToStrDef(CycleBegin,'')]);
      if not VarIsNull(CycleEnd) then
        Result:=Format(SHistoryToCycle,[VarToStrDef(CycleEnd,'')]);
      if not VarIsNull(CycleBegin) and
         not VarIsNull(CycleEnd) then
        Result:=Format(SHistoryFromToCycle,[VarToStrDef(CycleBegin,''),VarToStrDef(CycleEnd,'')]);
    end;
  end;
end;

{ TSgtsKgesGraphPeriodRefreshForm }

constructor TSgtsKgesGraphPeriodRefreshForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FHistories:=TSgtsKgesGraphHistories.Create;

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

destructor TSgtsKgesGraphPeriodRefreshForm.Destroy;
begin
  FDatePeriodEnd.Free;
  FDatePeriodBegin.Free;
  FHistories.Free;
  inherited Destroy;
end;

function TSgtsKgesGraphPeriodRefreshForm.GetIface: TSgtsKgesGraphPeriodRefreshIface;
begin
  Result:=TSgtsKgesGraphPeriodRefreshIface(inherited Iface);
end;

function TSgtsKgesGraphPeriodRefreshForm.SelectCycle(var CycleNum: Variant): Boolean;
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


procedure TSgtsKgesGraphPeriodRefreshForm.RadioButtonCycleClick(
  Sender: TObject);
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

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonPeriodClick(
  Sender: TObject);
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

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonCycleBeginClick(
  Sender: TObject);
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

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonCycleEndClick(
  Sender: TObject);
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

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonOkClick(Sender: TObject);
var
  V1, V2: Integer;
begin
  ModalResult:=mrNone;
  if RadioButtonPeriod.Checked then
    if (DatePeriodEnd.Date<>NullDate) and
       (DatePeriodBegin.Date<>NullDate) then begin
      if DatePeriodEnd.Date<DatePeriodBegin.Date then begin
        ShowError(Format(SValueElementMustNotLess,[DatePeriodEnd.Hint,DatePeriodBegin.Hint]));
        DatePeriodEnd.SetFocus;
        exit;
      end;
    end;
  if RadioButtonCycle.Checked then
    if (Trim(EditCycleBegin.Text)<>'') and
       (Trim(EditCycleEnd.Text)<>'') then begin
      if TryStrToInt(EditCycleBegin.Text,V1) and
         TryStrToInt(EditCycleEnd.Text,V2) then begin
        if V2<V1 then begin
          ShowError(Format(SValueElementMustNotLess,[EditCycleEnd.Hint,EditCycleBegin.Hint]));
          EditCycleEnd.SetFocus;
          exit;
        end;
      end;
    end;
  inherited ButtonOkClick(Sender);
end;

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonDefaultClick(
  Sender: TObject);
begin
  inherited;
  FPeriodType:=ptMonth;
  RadioButtonPeriod.Checked:=true;
  RadioButtonCycleClick(nil);
  DatePeriodBegin.Date:=NullDate;
  DatePeriodEnd.Date:=NullDate;
  EditCycleBegin.Text:='';
  EditCycleEnd.Text:='';
  FHistories.CopyFrom(Iface.DefaultHistories);
  FillHistories;
end;

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonHistoryClearClick(
  Sender: TObject);
var
  i: Integer;
  History: TSgtsKgesGraphHistory;
begin
  for i:=ListBoxHistory.Items.Count-1 downto 0 do begin
    if ListBoxHistory.Selected[i] then begin
      History:=TSgtsKgesGraphHistory(ListBoxHistory.Items.Objects[i]);
      FHistories.Remove(History);
    end;
  end;
  ListBoxHistory.DeleteSelected;
end;

procedure TSgtsKgesGraphPeriodRefreshForm.ListBoxHistoryKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_DELETE then begin
    ButtonHistoryClearClick(nil);
  end;
  if Key=VK_INSERT then begin
    ButtonHistoryAddClick(nil);
  end;
end;

function TSgtsKgesGraphPeriodRefreshForm.GetFirstHistorySelected: TSgtsKgesGraphHistory;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to ListBoxHistory.Items.Count-1 do begin
    if ListBoxHistory.Selected[i] then begin
      Result:=TSgtsKgesGraphHistory(ListBoxHistory.Items.Objects[i]);
      exit;
    end;
  end;
end;

procedure TSgtsKgesGraphPeriodRefreshForm.ButtonHistoryAddClick(
  Sender: TObject);
var
  AIface: TSgtsPeriodExIface;
  APeriodType: TSgtsPeriodExType;
  ADateBegin,ADateEnd,ACycleBegin,ACycleEnd: Variant;
  C1,C2: Integer;
  History: TSgtsKgesGraphHistory;
begin
  AIface:=TSgtsPeriodExIface.Create(CoreIntf);
  try
    History:=GetFirstHistorySelected;
    if not Assigned(History) then begin
      APeriodType:=iff(RadioButtonPeriod.Checked,petDate,petCycle);
      ADateBegin:=FDatePeriodBegin.Date2;
      ADateEnd:=FDatePeriodEnd.Date2;
      ACycleBegin:=Null;
      if TryStrToInt(Trim(EditCycleBegin.Text),C1) then
        ACycleBegin:=C1;
      ACycleEnd:=Null;
      if TryStrToInt(Trim(EditCycleEnd.Text),C2) then
        ACycleEnd:=C2;
    end else begin
      APeriodType:=History.HistoryType;
      ADateBegin:=History.DateBegin;
      ADateEnd:=History.DateEnd;
      ACycleBegin:=History.CycleBegin;
      ACycleEnd:=History.CycleEnd;
    end;

    if AIface.Select(APeriodType,ADateBegin,ADateEnd,ACycleBegin,ACycleEnd) then begin
      History:=FHistories.Add(Iface.GetHistoryCaption(APeriodType,ADateBegin,ADateEnd,ACycleBegin,ACycleEnd),
                               APeriodType,ADateBegin,ADateEnd,ACycleBegin,ACycleEnd);
      if Assigned(History) then begin
      end;
      FillHistories;
    end;
  finally
    AIface.Free;
  end;
end;

procedure TSgtsKgesGraphPeriodRefreshForm.FillHistories;
var
  i: Integer;
  History: TSgtsKgesGraphHistory;
begin
  ListBoxHistory.Items.BeginUpdate;
  try
    ListBoxHistory.Items.Clear;
    for i:=0 to FHistories.Count-1 do begin
      History:=FHistories.Items[i];
      ListBoxHistory.Items.AddObject(History.Caption,History);
    end;
  finally
    ListBoxHistory.Items.EndUpdate;
  end;
end;

procedure TSgtsKgesGraphPeriodRefreshForm.ListBoxHistoryDblClick(
  Sender: TObject);
var
  Index: Integer;
  History: TSgtsKgesGraphHistory;
  S: String;
begin
  Index:=ListBoxHistory.ItemIndex;
  if Index<>-1 then begin
    History:=TSgtsKgesGraphHistory(ListBoxHistory.Items.Objects[Index]);
    S:=ListBoxHistory.Items.Strings[Index];
    if InputQuery(SCaptionHistory,SInputCaptionHistory,S) then begin
      if Trim(S)='' then begin
        ShowError(SHistoryCaptionNotEmpty);
      end else begin
        ListBoxHistory.Items.Strings[Index]:=S;
        History.Caption:=S;
      end;  
    end;
  end;
end;

end.
