unit SgtsRbkDeviceEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf;

type
  TSgtsRbkDeviceEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    LabelDateEnter: TLabel;
    DateTimePicker: TDateTimePicker;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkDeviceInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkDeviceUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkDeviceDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkDeviceEditForm: TSgtsRbkDeviceEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs;

{$R *.dfm}

{ TSgtsRbkDeviceInsertIface }

procedure TSgtsRbkDeviceInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDeviceEditForm;
  InterfaceName:=SInterfaceDeviceInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertDevice;
    with ExecuteDefs do begin
      AddKey('DEVICE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      AddDate('DATE_ENTER','DateTimePicker','LabelDateEnter',true);
    end;
  end;
end;

{ TSgtsRbkDeviceUpdateIface }

procedure TSgtsRbkDeviceUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDeviceEditForm;
  InterfaceName:=SInterfaceDeviceUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateDevice;
    with ExecuteDefs do begin
      AddKeyLink('DEVICE_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      AddDate('DATE_ENTER','DateTimePicker','LabelDateEnter',true);
    end;
  end;
end;

{ TSgtsRbkDeviceDeleteIface }

procedure TSgtsRbkDeviceDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceDeviceDelete;
  DeleteQuestion:='Удалить устройство %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteDevice;
    with ExecuteDefs do begin
      AddKeyLink('DEVICE_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkDeviceEditForm }

constructor TSgtsRbkDeviceEditForm.Create(ACoreIntf: ISgtsCore); 
begin
  inherited Create(ACoreIntf);
  DateTimePicker.Date:=DateOf(Date);
end;

end.
