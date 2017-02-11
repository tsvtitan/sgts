unit SgtsRbkDevicePointEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkDevicePointEditForm = class(TSgtsDataEditForm)
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
    LabelDevice: TLabel;
    EditDevice: TEdit;
    ButtonDevice: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkDevicePointInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkDevicePointUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkDevicePointDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkDevicePointRoleEditForm: TSgtsRbkDevicePointEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkDevicesFm, SgtsRbkPointsFm;

{$R *.dfm}

{ TSgtsRbkDevicePointInsertIface }

procedure TSgtsRbkDevicePointInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDevicePointEditForm;
  InterfaceName:=SInterfaceDevicePointInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertDevicePoint;
    with ExecuteDefs do begin
      AddEditLink('DEVICE_ID','EditDevice','LabelDevice','ButtonDevice',
                  TSgtsRbkDevicesIface,'DEVICE_NAME','NAME','DEVICE_ID',true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkDevicePointUpdateIface }

procedure TSgtsRbkDevicePointUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDevicePointEditForm;
  InterfaceName:=SInterfaceDevicePointUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateDevicePoint;
    with ExecuteDefs do begin
      AddEditLink('DEVICE_ID','EditDevice','LabelDevice','ButtonDevice',
                  TSgtsRbkDevicesIface,'DEVICE_NAME','NAME','DEVICE_ID',true,true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkDevicePointDeleteIface }

procedure TSgtsRbkDevicePointDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceDevicePointDelete;
  DeleteQuestion:='Удалить точку: %POINT_NAME у устройства: %DEVICE_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteDevicePoint;
    with ExecuteDefs do begin
      AddKeyLink('DEVICE_ID');
      AddKeyLink('POINT_ID');
      AddInvisible('DEVICE_NAME');
      AddInvisible('POINT_NAME');
    end;
  end;
end;

end.
