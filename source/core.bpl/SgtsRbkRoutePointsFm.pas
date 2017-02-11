unit SgtsRbkRoutePointsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkRoutePointsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkRoutePointsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkRoutePointsForm: TSgtsRbkRoutePointsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkRoutePointEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkRoutePointsIface }

procedure TSgtsRbkRoutePointsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRoutePointsForm;
  InterfaceName:=SInterfaceRoutePoints;
  InsertClass:=TSgtsRbkRoutePointInsertIface;
  UpdateClass:=TSgtsRbkRoutePointUpdateIface;
  DeleteClass:=TSgtsRbkRoutePointDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectRoutePoints;
    with SelectDefs do begin
      AddInvisible('ROUTE_ID');
      AddInvisible('POINT_ID');
      Add('ROUTE_NAME','Маршрут',150);
      Add('POINT_NAME','Измерительная точка',100);
      Add('PRIORITY','Порядок обхода',40);
    end;
  end;
end;

{ TSgtsRbkRoutePointsForm }

constructor TSgtsRbkRoutePointsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
