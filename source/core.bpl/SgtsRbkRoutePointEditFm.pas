unit SgtsRbkRoutePointEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkRoutePointEditForm = class(TSgtsDataEditForm)
    LabelRoute: TLabel;
    EditRoute: TEdit;
    ButtonRoute: TButton;
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkRoutePointInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkRoutePointUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkRoutePointDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkRoutePointRoleEditForm: TSgtsRbkRoutePointEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkRoutesFm, SgtsRbkPointsFm;

{$R *.dfm}

{ TSgtsRbkRoutePointInsertIface }

procedure TSgtsRbkRoutePointInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRoutePointEditForm;
  InterfaceName:=SInterfaceRoutePointInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertRoutePoint;
    with ExecuteDefs do begin
      AddEditLink('ROUTE_ID','EditRoute','LabelRoute','ButtonRoute',
                  TSgtsRbkRoutesIface,'ROUTE_NAME','NAME','ROUTE_ID',true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkRoutePointUpdateIface }

procedure TSgtsRbkRoutePointUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkRoutePointEditForm;
  InterfaceName:=SInterfaceRoutePointUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateRoutePoint;
    with ExecuteDefs do begin
      AddEditLink('ROUTE_ID','EditRoute','LabelRoute','ButtonRoute',
                  TSgtsRbkRoutesIface,'ROUTE_NAME','NAME','ROUTE_ID',true,true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkRoutePointDeleteIface }

procedure TSgtsRbkRoutePointDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceRoutePointDelete;
  DeleteQuestion:='Удалить измерительную точку: %POINT_NAME у маршрута %ROUTE_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteRoutePoint;
    with ExecuteDefs do begin
      AddKeyLink('ROUTE_ID');
      AddKeyLink('POINT_ID');
      AddInvisible('POINT_NAME');
      AddInvisible('ROUTE_NAME');
    end;
  end;
end;

end.
