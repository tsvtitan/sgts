unit SgtsRbkMeasureTypeRoutesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkMeasureTypeRoutesForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkMeasureTypeRoutesIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkMeasureTypeRoutesForm: TSgtsRbkMeasureTypeRoutesForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkMeasureTypeRouteEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkMeasureTypeRoutesIface }

procedure TSgtsRbkMeasureTypeRoutesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureTypeRoutesForm;
  InterfaceName:=SInterfaceMeasureTypeRoutes;
  InsertClass:=TSgtsRbkMeasureTypeRouteInsertIface;
  UpdateClass:=TSgtsRbkMeasureTypeRouteUpdateIface;
  DeleteClass:=TSgtsRbkMeasureTypeRouteDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectMeasureTypeRoutes;
    with SelectDefs do begin
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('ROUTE_ID');
      Add('MEASURE_TYPE_NAME','Вид измерения',150);
      Add('ROUTE_NAME','Маршрут',100);
      Add('PRIORITY','Порядок',40);
    end;
  end;
end;

{ TSgtsRbkMeasureTypeRoutesForm }

constructor TSgtsRbkMeasureTypeRoutesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
