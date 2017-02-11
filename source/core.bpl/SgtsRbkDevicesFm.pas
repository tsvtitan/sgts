unit SgtsRbkDevicesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  StdCtrls, DBCtrls, Grids, DBGrids,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf;

type
  TSgtsRbkDevicesForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoNote: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkDevicesIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkDevicesForm: TSgtsRbkDevicesForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkDeviceEditFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkDevicesIface }

procedure TSgtsRbkDevicesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDevicesForm;
  InterfaceName:=SInterfaceDevices;
  InsertClass:=TSgtsRbkDeviceInsertIface;
  UpdateClass:=TSgtsRbkDeviceUpdateIface;
  DeleteClass:=TSgtsRbkDeviceDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectDevices;
    with SelectDefs do begin
      AddKey('DEVICE_ID');
      Add('NAME','Наименование',150);
      Add('DATE_ENTER','Дата ввода',80);
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkDevicesForm }

constructor TSgtsRbkDevicesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
