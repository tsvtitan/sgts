unit SgtsRbkDevicePointsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkDevicePointsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkDevicePointsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkDevicePointsForm: TSgtsRbkDevicePointsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkDevicePointEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkDevicePointsIface }

procedure TSgtsRbkDevicePointsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDevicePointsForm;
  InterfaceName:=SInterfaceDevicePoints;
  InsertClass:=TSgtsRbkDevicePointInsertIface;
  UpdateClass:=TSgtsRbkDevicePointUpdateIface;
  DeleteClass:=TSgtsRbkDevicePointDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectDevicePoints;
    with SelectDefs do begin
      AddInvisible('DEVICE_ID');
      AddInvisible('POINT_ID');
      Add('DEVICE_NAME','Устройство',150);
      Add('POINT_NAME','Точка',150);
      Add('PRIORITY','Порядок',30);
    end;
  end;
end;

{ TSgtsRbkDevicePointsForm }

constructor TSgtsRbkDevicePointsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
