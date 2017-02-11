unit SgtsGraphChartInfoFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  SgtsDialogFm, SgtsFm, SgtsControls;

type
  TSgtsGraphChartInfoForm = class(TSgtsDialogForm)
    LabelLeftAxis: TLabel;
    Label1: TLabel;
    LabelValue: TLabel;
    EditYValue: TEdit;
    EditXValue: TEdit;
    GroupBoxStatistics: TGroupBox;
    LabelAverage: TLabel;
    EditYAverage: TEdit;
    LabelMax: TLabel;
    EditYMax: TEdit;
    EditXMax: TEdit;
    LabelMin: TLabel;
    EditYMin: TEdit;
    EditXMin: TEdit;
    LabelRange: TLabel;
    EditYRange: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsGraphChartInfoIface=class(TSgtsDialogIface)
  private
    FYValue: String;
    FYAverage: String;
    FYMax: String;
    FYMin: String;
    FYRange: String;

    FXValue: String;
    FXMax: String;
    FXMin: String;

    function GetForm: TSgtsGraphChartInfoForm;

  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;
  public
    property YValue: String read FYValue write FYValue;
    property YAverage: String read FYAverage write FYAverage;
    property YMax: String read FYMax write FYMax;
    property YMin: String read FYMin write FYMin;
    property YRange: String read FYRange write FYRange;

    property XValue: String read FXValue write FXValue;
    property XMax: String read FXMax write FXMax;
    property XMin: String read FXMin write FXMin;

    property Form: TSgtsGraphChartInfoForm read GetForm;
  end;

var
  SgtsGraphChartInfoForm: TSgtsGraphChartInfoForm;

implementation

{$R *.dfm}

{ TSgtsGraphChartInfoIface }

function TSgtsGraphChartInfoIface.GetForm: TSgtsGraphChartInfoForm;
begin
  Result:=TSgtsGraphChartInfoForm(inherited Form);
end;

function TSgtsGraphChartInfoIface.GetFormClass: TSgtsFormClass; 
begin
  Result:=TSgtsGraphChartInfoForm;
end;

procedure TSgtsGraphChartInfoIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  if Assigned(Form) then begin
    with Form do begin
      EditYValue.Text:=FYValue;
      EditYAverage.Text:=FYAverage;
      EditYMax.Text:=FYMax;
      EditYMin.Text:=FYMin;
      EditYRange.Text:=FYRange;
      EditXValue.Text:=FXValue;
      EditXMax.Text:=FXMax;
      EditXMin.Text:=FXMin;
    end;
  end;
end;

procedure TSgtsGraphChartInfoIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
end;

end.
