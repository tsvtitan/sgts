unit SgtsRbkPersonnelRoutesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, 
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkPersonnelRoutesForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPersonnelRoutesIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPersonnelRoutesForm: TSgtsRbkPersonnelRoutesForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkPersonnelRouteEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkPersonnelRoutesIface }

procedure TSgtsRbkPersonnelRoutesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPersonnelRoutesForm;
  InterfaceName:=SInterfacePersonnelRoutes;
  InsertClass:=TSgtsRbkPersonnelRouteInsertIface;
  UpdateClass:=TSgtsRbkPersonnelRouteUpdateIface;
  DeleteClass:=TSgtsRbkPersonnelRouteDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPersonnelRoutes;
    with SelectDefs do begin
      AddInvisible('PERSONNEL_ID');
      AddInvisible('ROUTE_ID');
      AddInvisible('DEPUTY_ID');
      Add('ROUTE_NAME','Маршрут',80);
      Add('PERSONNEL_NAME','Исполнитель',150);
      Add('DEPUTY_NAME','Заместитель',150);
      Add('DATE_PURPOSE','Дата назначения',70);
    end;
  end;
end;

{ TSgtsRbkPersonnelRoutesForm }

constructor TSgtsRbkPersonnelRoutesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
