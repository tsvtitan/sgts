unit SgtsPeriodFm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, Spin,
  SgtsFm, SgtsDialogFm, SgtsControls;

type
  TSgtsPeriodType=(ptYear,ptQuarter,ptMonth,ptDay,ptInterval);

  TSgtsPeriodForm = class(TSgtsDialogForm)
    dtpBegin: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    lbBegin: TLabel;
    lbEnd: TLabel;
    rbKvartal: TRadioButton;
    rbMonth: TRadioButton;
    rbDay: TRadioButton;
    rbInterval: TRadioButton;
    edKvartal: TEdit;
    udKvartal: TUpDown;
    edMonth: TEdit;
    udMonth: TUpDown;
    dtpDay: TDateTimePicker;
    rbYear: TRadioButton;
    edYear: TEdit;
    udYear: TUpDown;
    procedure bibOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure udKvartalChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
    procedure udKvartalChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edKvartalChange(Sender: TObject);
    procedure rbKvartalClick(Sender: TObject);
    procedure udMonthChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure edMonthChange(Sender: TObject);
    procedure udYearChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
  private
    CurKvartal: Word;
    CurKvartalYear: Word;
    CurMonth: Word;
    CurMonthYear: Word;
    isChangeKvartal: Boolean;
    isChangeMonth: Boolean;
    procedure SetKvartalInc(IncDec: Integer);
    procedure SetMonthInc(IncDec: Integer);
    procedure SetPeriod(PeriodType: TSgtsPeriodType; var DateBegin, DateEnd: TDate);
    procedure GetPeriod(var PeriodType: TSgtsPeriodType; var DateBegin, DateEnd: TDate);
  public
  end;

  TSgtsPeriodIface=class(TSgtsDialogIface)
  private
    FPeriodType: TSgtsPeriodType;
    FDateBegin: TDate;
    FDateEnd: TDate;
    function GetForm: TSgtsPeriodForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;
  public
    function Select(var PeriodType: TSgtsPeriodType; var DateBegin, DateEnd: TDate): Boolean;

    property Form: TSgtsPeriodForm read GetForm;
  end;

var
  SgtsPeriodForm: TSgtsPeriodForm;

implementation

uses SgtsConsts;

{$R *.DFM}

{ TSgtsPeriodIface }

function TSgtsPeriodIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsPeriodForm;
end;

function TSgtsPeriodIface.GetForm: TSgtsPeriodForm;
begin
  Result:=TSgtsPeriodForm(inherited Form);
end;

procedure TSgtsPeriodIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  Form.SetPeriod(FPeriodType,FDateBegin,FDateEnd);
end;

procedure TSgtsPeriodIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    Form.GetPeriod(FPeriodType,FDateBegin,FDateEnd);
  end;
end;

function TSgtsPeriodIface.Select(var PeriodType: TSgtsPeriodType; var DateBegin, DateEnd: TDate): Boolean;
begin
  Result:=false;
  Init;
  FPeriodType:=PeriodType;
  FDateBegin:=DateBegin;
  FDateEnd:=DateEnd;
  if ShowModal=mrOk then begin
    Result:=true;
    PeriodType:=FPeriodType;
    DateBegin:=FDateBegin;
    DateEnd:=FDateEnd;
  end;  
end;

{ TSgtsPeriodForm }

procedure TSgtsPeriodForm.SetPeriod(PeriodType: TSgtsPeriodType; var DateBegin, DateEnd: TDate);
var
  Year,Month,Day: Word;
begin
  if DateBegin=0 then
    DateBegin:=Date;
  DecodeDate(DateBegin,Year,Month,Day);
  case PeriodType of
    ptQuarter: begin
      CurKvartalYear:=Year;
      if (Month mod 3)<>0 then
        CurKvartal:=(Month div 3)+1
      else CurKvartal:=(Month div 3);
      SetKvartalInc(0);
      rbKvartal.Checked:=true;
    end;
    ptMonth: begin
      CurMonthYear:=Year;
      CurMonth:=Month;
      SetMonthInc(0);
      rbMonth.Checked:=true;
    end;
    ptDay: begin
      dtpDay.DateTime:=DateBegin;
      rbDay.Checked:=true;
    end;
    ptInterval: begin
      dtpBegin.DateTime:=DateBegin;
      dtpEnd.DateTime:=DateEnd;
      rbInterval.Checked:=true;
    end;
    ptYear: begin
      udYear.Position:=Year;
      rbYear.Checked:=true;
    end;
  end;
  isChangeKvartal:=false;
  isChangeMonth:=false;
end;

procedure TSgtsPeriodForm.GetPeriod(var PeriodType: TSgtsPeriodType; var DateBegin, DateEnd: TDate);
var
  Year,Month,Day: Word;
  DBegin,DEnd: TDateTime;
begin
  if rbKvartal.Checked then begin
    Year:=CurKvartalYear;
    Month:=CurKvartal+2*(CurKvartal-1);
    Day:=1;
    DBegin:=EncodeDate(Year,Month,Day)+EncodeTime(0,0,0,0);
    DEnd:=IncMonth(DBegin,3)-1+EncodeTime(23,59,59,0);
    DateBegin:=DBegin;
    DateEnd:=DEnd;
    PeriodType:=ptQuarter;
    exit;
  end;
  if rbMonth.Checked then begin
    Year:=CurMonthYear;
    Month:=CurMonth;
    Day:=1;
    DBegin:=EncodeDate(Year,Month,Day)+EncodeTime(0,0,0,0);
    DEnd:=IncMonth(DBegin,1)-1+EncodeTime(23,59,59,0);
    DateBegin:=DBegin;
    DateEnd:=DEnd;
    PeriodType:=ptMonth;
    exit;
  end;
  if rbDay.Checked then begin
    DBegin:=dtpDay.date+EncodeTime(0,0,0,0);
    DEnd:=dtpDay.date+EncodeTime(23,59,59,0);
    DateBegin:=DBegin;
    DateEnd:=DEnd;
    PeriodType:=ptDay;
    exit;
  end;
  if rbInterval.Checked then begin
    DBegin:=dtpBegin.date+EncodeTime(0,0,0,0);
    DEnd:=dtpEnd.date+EncodeTime(23,59,59,0);
    DateBegin:=DBegin;
    DateEnd:=DEnd;
    PeriodType:=ptInterval;
    exit;
  end;
  if rbYear.Checked then begin
    DBegin:=EncodeDate(udYear.Position,1,1)+EncodeTime(0,0,0,0);
    DEnd:=IncMonth(DBegin,12)-1+EncodeTime(23,59,59,0);
    DateBegin:=DBegin;
    DateEnd:=DEnd;
    PeriodType:=ptYear;
    exit;
  end;
end;

procedure TSgtsPeriodForm.bibOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TSgtsPeriodForm.FormCreate(Sender: TObject);
var
  Year,Month,Day: Word;
begin
  isChangeKvartal:=true;
  isChangeMonth:=true;
  DecodeDate(Now,Year,Month,Day);

  udYear.Position:=Year;

  CurKvartalYear:=Year;
  if (Month mod 3)<>0 then
    CurKvartal:=(Month div 3)+1
  else CurKvartal:=(Month div 3);

  CurMonthYear:=Year;
  CurMonth:=Month;

  dtpDay.Time:=StrToTime('0:00:00');
  dtpDay.date:=Date;

  dtpBegin.Time:=StrToTime('0:00:00');
  dtpBegin.date:=Date;

  dtpEnd.Time:=StrToTime('0:00:00');
  dtpEnd.date:=Date;

  rbInterval.Checked:=true;
end;

procedure TSgtsPeriodForm.udKvartalChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  AllowChange:=false;
  case Direction of
    updUp: begin
     SetKvartalInc(1);
    end;
    updDown: begin
     SetKvartalInc(-1);
    end;
  end;
end;

procedure TSgtsPeriodForm.SetKvartalInc(IncDec: Integer);
var
  tmps: string;
begin
  if ((CurKvartal+IncDec)<=4)and((CurKvartal+IncDec)>0) then begin
    CurKvartal:=CurKvartal+IncDec;
  end else begin
    if ((CurKvartal+IncDec)>4) then begin
      CurKvartal:=1;
      CurKvartalYear:=CurKvartalYear+1;
    end;
    if ((CurKvartal+IncDec)<=0)then begin
      CurKvartal:=4;
      CurKvartalYear:=CurKvartalYear-1;
    end;
  end;
  tmps:=inttostr(CurKvartal)+' '+SKvartal+' '+inttostr(CurKvartalYear)+' �.';
  edKvartal.Text:=tmps;
  if self.Visible then
    edKvartal.SetFocus;
  edKvartal.SelectAll;
end;

procedure TSgtsPeriodForm.udKvartalChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=false;
end;

procedure TSgtsPeriodForm.edKvartalChange(Sender: TObject);
begin
  if not isChangeKvartal then begin
    isChangeKvartal:=true;
    edKvartal.Text:=inttostr(CurKvartal)+' '+SKvartal+' '+inttostr(CurKvartalYear)+' �.';
  end;
end;

procedure TSgtsPeriodForm.rbKvartalClick(Sender: TObject);
const
  clDisable=clBtnFace;
  clEnable=clWindow;
begin
  edYear.Enabled:=false;
  edYear.Color:=clDisable;
  udYear.Enabled:=false;
  edKvartal.Enabled:=false;
  edKvartal.Color:=clDisable;
  udKvartal.Enabled:=false;
  edMonth.Enabled:=false;
  edMonth.Color:=ClDisable;
  udMonth.Enabled:=false;
  dtpDay.Enabled:=false;
  dtpDay.Color:=clDisable;
  lbBegin.Enabled:=false;
  dtpBegin.Enabled:=false;
  dtpBegin.Color:=clDisable;
  lbEnd.Enabled:=false;
  dtpEnd.Enabled:=false;
  dtpEnd.Color:=clDisable;

  if Sender=rbYear then begin
    edYear.Enabled:=true;
    edYear.Color:=clEnable;
    udYear.Enabled:=true;
    exit;
  end;
  if Sender=rbKvartal then begin
    edKvartal.Enabled:=true;
    edKvartal.Color:=clEnable;
    udKvartal.Enabled:=true;
    exit;
  end;
  if Sender=rbMonth then begin
    edMonth.Enabled:=true;
    edMonth.Color:=clEnable;
    udMonth.Enabled:=true;
    exit;
  end;
  if Sender=rbDay then begin
    dtpDay.Enabled:=true;
    dtpDay.Color:=clEnable;
    exit;
  end;
  if Sender=rbInterval then begin
    lbBegin.Enabled:=true;
    dtpBegin.Enabled:=true;
    dtpBegin.Color:=clEnable;
    lbEnd.Enabled:=true;
    dtpEnd.Enabled:=true;
    dtpEnd.Color:=clEnable;
    exit;
  end;
end;

procedure TSgtsPeriodForm.SetMonthInc(IncDec: Integer);
var
  tmps: string;
  monthstr: string;
begin
  if ((CurMonth+IncDec)<=12)and((CurMonth+IncDec)>0) then begin
    CurMonth:=CurMonth+IncDec;
  end else begin
    if ((CurMonth+IncDec)>12) then begin
      CurMonth:=1;
      CurMonthYear:=CurMonthYear+1;
    end;
    if ((CurMonth+IncDec)<=0)then begin
      CurMonth:=12;
      CurMonthYear:=CurMonthYear-1;
    end;
  end;
  monthstr:=LongMonthNames[CurMonth];
  tmps:=monthstr+' '+inttostr(CurMonthYear)+' �.';
  edMonth.Text:=tmps;
  if self.Visible then
    edMonth.SetFocus;
  edMonth.SelectAll;
end;

procedure TSgtsPeriodForm.udMonthChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  AllowChange:=false;
  case Direction of
    updUp: begin
     SetMonthInc(1);
    end;
    updDown: begin
     SetMonthInc(-1);
    end;
  end;
end;

procedure TSgtsPeriodForm.edMonthChange(Sender: TObject);
var
  monthstr: string;
begin
  if not isChangeMonth then begin
    isChangeMonth:=true;
    monthstr:=LongMonthNames[CurMonth];
    edMonth.Text:=monthstr+' '+inttostr(CurMonthYear)+' �.';
  end;
end;

procedure TSgtsPeriodForm.udYearChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  AllowChange:=true;
  if self.Visible then
    edYear.SetFocus;
end;

end.
