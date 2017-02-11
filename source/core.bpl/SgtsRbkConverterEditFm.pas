unit SgtsRbkConverterEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkConverterEditForm = class(TSgtsDataEditForm)
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
    LabelName: TLabel;
    LabelDescription: TLabel;
    EditName: TEdit;
    MemoDescription: TMemo;
    LabelDateEnter: TLabel;
    DateTimePicker: TDateTimePicker;
    CheckBoxNotOperation: TCheckBox;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkConverterInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkConverterUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkConverterDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkConverterRoleEditForm: TSgtsRbkConverterEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkPointsFm;

{$R *.dfm}

{ TSgtsRbkConverterInsertIface }

procedure TSgtsRbkConverterInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkConverterEditForm;
  InterfaceName:=SInterfaceConverterInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertConverter;
    with ExecuteDefs do begin
      AddEditLink('CONVERTER_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddDate('DATE_ENTER','DateTimePicker','LabelDateEnter',true);
      AddCheck('NOT_OPERATION','CheckBoxNotOperation');
    end;
  end;
end;

{ TSgtsRbkConverterUpdateIface }

procedure TSgtsRbkConverterUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkConverterEditForm;
  InterfaceName:=SInterfaceConverterUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateConverter;
    with ExecuteDefs do begin
      AddEditLink('CONVERTER_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true,true);
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddDate('DATE_ENTER','DateTimePicker','LabelDateEnter',true);
      AddCheck('NOT_OPERATION','CheckBoxNotOperation');
    end;
  end;
end;

{ TSgtsRbkConverterDeleteIface }

procedure TSgtsRbkConverterDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceConverterDelete;
  DeleteQuestion:='Удалить преобразователь %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteConverter;
    with ExecuteDefs do begin
      AddKeyLink('CONVERTER_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkConverterEditForm }

constructor TSgtsRbkConverterEditForm.Create(ACoreIntf: ISgtsCore); 
begin
  inherited Create(ACoreIntf);
  DateTimePicker.Date:=DateOf(Date);
end;

end.
