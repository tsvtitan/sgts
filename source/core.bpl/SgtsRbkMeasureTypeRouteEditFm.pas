unit SgtsRbkMeasureTypeRouteEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkMeasureTypeRouteEditForm = class(TSgtsDataEditForm)
    LabelMeasureType: TLabel;
    EditMeasureType: TEdit;
    ButtonMeasureType: TButton;
    LabelRoute: TLabel;
    EditRoute: TEdit;
    ButtonRoute: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkMeasureTypeRouteInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkMeasureTypeRouteUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkMeasureTypeRouteDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkMeasureTypeRouteRoleEditForm: TSgtsRbkMeasureTypeRouteEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkRoutesFm, SgtsRbkMeasureTypesFm;

{$R *.dfm}

{ TSgtsRbkMeasureTypeRouteInsertIface }

procedure TSgtsRbkMeasureTypeRouteInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureTypeRouteEditForm;
  InterfaceName:=SInterfaceMeasureTypeRouteInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertMeasureTypeRoute;
    with ExecuteDefs do begin
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',true);
      AddEditLink('ROUTE_ID','EditRoute','LabelRoute','ButtonRoute',
                  TSgtsRbkRoutesIface,'ROUTE_NAME','NAME','ROUTE_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkMeasureTypeRouteUpdateIface }

procedure TSgtsRbkMeasureTypeRouteUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureTypeRouteEditForm;
  InterfaceName:=SInterfaceMeasureTypeRouteUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateMeasureTypeRoute;
    with ExecuteDefs do begin
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',true,true);
      AddEditLink('ROUTE_ID','EditRoute','LabelRoute','ButtonRoute',
                  TSgtsRbkRoutesIface,'ROUTE_NAME','NAME','ROUTE_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkMeasureTypeRouteDeleteIface }

procedure TSgtsRbkMeasureTypeRouteDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceMeasureTypeRouteDelete;
  DeleteQuestion:='Удалить маршрут: %ROUTE_NAME у вида измерения %MEASURE_TYPE_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteMeasureTypeRoute;
    with ExecuteDefs do begin
      AddKeyLink('MEASURE_TYPE_ID');
      AddKeyLink('ROUTE_ID');
      AddInvisible('MEASURE_TYPE_NAME');
      AddInvisible('ROUTE_NAME');
    end;
  end;
end;

end.
