unit SgtsRbkObjectPassportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs, SgtsCoreIntf;

type
  TSgtsRbkObjectPassportEditForm = class(TSgtsDataEditForm)
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelObject: TLabel;
    EditObject: TEdit;
    ButtonObject: TButton;
    LabelDatePassport: TLabel;
    DateTimePickerPassport: TDateTimePicker;
    LabelParamName: TLabel;
    EditParamName: TEdit;
    LabelValue: TLabel;
    EditValue: TEdit;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkObjectPassportInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkObjectPassportUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkObjectPassportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectPassportEditForm: TSgtsRbkObjectPassportEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkObjectsFm;

{$R *.dfm}

{ TSgtsRbkObjectPassportInsertIface }

procedure TSgtsRbkObjectPassportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectPassportEditForm;
  InterfaceName:=SInterfaceObjectPassportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertObjectPassport;
    with ExecuteDefs do begin
      AddKey('OBJECT_PASSPORT_ID');
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true);
      AddDate('DATE_PASSPORT','DateTimePickerPassport','LabelDatePassport',true);
      AddEdit('PARAM_NAME','EditParamName','LabelParamName');
      AddEditFloat('VALUE','EditValue','LabelValue');
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
    end;
  end;
end;

{ TSgtsRbkObjectPassportUpdateIface }

procedure TSgtsRbkObjectPassportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectPassportEditForm;
  InterfaceName:=SInterfaceObjectPassportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateObjectPassport;
    with ExecuteDefs do begin
      AddKeyLink('OBJECT_PASSPORT_ID');
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true);
      AddDate('DATE_PASSPORT','DateTimePickerPassport','LabelDatePassport',true);
      AddEdit('PARAM_NAME','EditParamName','LabelParamName');
      AddEditFloat('VALUE','EditValue','LabelValue');
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
    end;
  end;
end;

{ TSgtsRbkObjectPassportDeleteIface }

procedure TSgtsRbkObjectPassportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceObjectPassportDelete;
  DeleteQuestion:='Удалить текущую запись в паспорте?';
  with DataSet do begin
    ProviderName:=SProviderDeleteObjectPassport;
    with ExecuteDefs do begin
      AddKeyLink('OBJECT_PASSPORT_ID');
    end;
  end;
end;

{ TSgtsRbkObjectPassportEditForm }

constructor TSgtsRbkObjectPassportEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerPassport.Date:=DateOf(Date);
end;

end.
