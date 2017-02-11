unit SgtsFieldEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SgtsDialogFm, SgtsFieldEditFmIntf, ComCtrls;

type
  TSgtsFieldEditForm = class(TSgtsDialogForm)
    PageControl: TPageControl;
    TabSheetMemo: TTabSheet;
    PanelText: TPanel;
    Memo: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsFieldEditIface=class(TSgtsDialogIface,ISgtsFieldEditForm)
  private
    FEditType: TSgtsFieldEditType;
    FOldValue: Variant;
    FNewValue: Variant;
    function GetForm: TSgtsFieldEditForm;
  public
    procedure Init; override;
    function Show(OldValue: Variant; out NewValue: Variant; EditType: TSgtsFieldEditType): Boolean; reintroduce; overload;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;

    property Form: TSgtsFieldEditForm read GetForm;
  end;

var
  SgtsFieldEditForm: TSgtsFieldEditForm;

implementation

uses SgtsFm, SgtsUtils;

{$R *.dfm}

procedure TSgtsFieldEditIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsFieldEditForm;
end;

function TSgtsFieldEditIface.GetForm: TSgtsFieldEditForm;
begin
  Result:=TSgtsFieldEditForm(inherited Form);
end;

function TSgtsFieldEditIface.Show(OldValue: Variant; out NewValue: Variant; EditType: TSgtsFieldEditType): Boolean;
begin
  FOldValue:=OldValue;
  FEditType:=EditType;
  Result:=ShowModal=mrOk;
  if Result then begin
    NewValue:=FNewValue;
  end;
end;

procedure TSgtsFieldEditIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  with Form do begin
    case FEditType of
      etDefault: begin
        case VarType(FOldValue) of
          varString: begin
            PageControl.ActivePage:=TabSheetMemo;
            Memo.Lines.Text:=VarToStrDef(FOldValue,'');
          end;
        end;
      end;
      etString: begin
        PageControl.ActivePage:=TabSheetMemo;
        Memo.Lines.Text:=VarToStrDef(FOldValue,'');
      end;
    end;
  end;  
end;

procedure TSgtsFieldEditIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    with Form do begin
      case VarType(FOldValue) of
        varString: begin
          FNewValue:=Iff(Trim(Memo.Lines.Text)<>'',Memo.Lines.Text,Null);
        end;
      end;
    end;
  end;
end;

end.
