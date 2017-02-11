unit SgtsDialogFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  SgtsFm, 
  SgtsDialogFmIntf, SgtsCoreIntf;

type
  TSgtsDialogForm = class(TSgtsForm)
    PanelDialog: TPanel;
    PanelButton: TPanel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsDialogIface=class(TSgtsFormIface,ISgtsDialogForm)
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure BeforeShowModal; virtual;
    procedure AfterShowModal(ModalResult: TModalResult); virtual;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    procedure Init; override;
    procedure Show; override;
    procedure Hide; override;
    function ShowModal: TModalResult; virtual;
  end;

var
  SgtsDialogForm: TSgtsDialogForm;

implementation

uses SgtsIface, SgtsConsts;

{$R *.dfm}

{ TSgtsDialogIface }

constructor TSgtsDialogIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  StoredInConfig:=false;
end;

procedure TSgtsDialogIface.Init;
begin
  inherited Init;
end;

function TSgtsDialogIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsDialogForm;
end;

function TSgtsDialogIface.ShowModal: TModalResult;
begin
  Form:=CreateForm;
  try
    Form.InitByIface(Self);
    AfterCreateForm(Form);
    BeforeShowModal;
    LogWrite(SInterfaceShow);
    Result:=Form.ShowModal;
    AfterShowModal(Result);
  finally
    Form.Free;
  end;
end;

procedure TSgtsDialogIface.BeforeShowModal;
begin
end;

procedure TSgtsDialogIface.AfterShowModal(ModalResult: TModalResult);
begin
end;

procedure TSgtsDialogIface.Show;
begin
  if CanShow then begin
    ShowModal;
  end;
end;

procedure TSgtsDialogIface.Hide;
begin
end;

{ TSgtsDialogForm }

procedure TSgtsDialogForm.ButtonOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TSgtsDialogForm.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;



end.
