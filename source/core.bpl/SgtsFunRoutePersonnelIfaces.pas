unit SgtsFunRoutePersonnelIfaces;

interface

uses Classes, DB,
     SgtsRbkPersonnelRouteEditFm, SgtsFm,
     SgtsExecuteDefs;

type

  TSgtsFunRoutePersonnelInsertIface=class(TSgtsRbkPersonnelRouteInsertIface)
  private
    FSelected: Boolean;
    FPersonnelIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function NeedShow: Boolean; override;
  public
    procedure Init; override;
  end;

  TSgtsFunRoutePersonnelUpdateIface=class(TSgtsRbkPersonnelRouteUpdateIface)
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
  end;

  TSgtsFunRoutePersonnelDeleteIface=class(TSgtsRbkPersonnelRouteDeleteIface)
  public
    procedure Init; override;
  end;
  
implementation

uses SgtsDatabaseCDS, SgtsDataEditFm;

{ TSgtsFunRoutePersonnelInsertIface }

procedure TSgtsFunRoutePersonnelInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FPersonnelIdDef:=TSgtsExecuteDefEditLink(Find('PERSONNEL_ID'));
    end;
  end;
  Caption:='Назначить персону на маршрут';
end;

procedure TSgtsFunRoutePersonnelInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPersonnelRouteEditForm(Form) do begin
      EditRoute.Enabled:=false;
      LabelRoute.Enabled:=false;
      ButtonRoute.Enabled:=false;
      FSelected:=FPersonnelIdDef.Select;
    end;
  end;
end;

function TSgtsFunRoutePersonnelInsertIface.NeedShow: Boolean; 
begin
  Result:=inherited NeedShow and FSelected;
end;

{ TSgtsFunRoutePersonnelUpdateIface }

procedure TSgtsFunRoutePersonnelUpdateIface.Init; 
begin
  inherited Init;
  Caption:='Изменить персону на маршруте';
end;

procedure TSgtsFunRoutePersonnelUpdateIface.AfterCreateForm(AForm: TSgtsForm); 
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPersonnelRouteEditForm(Form) do begin
      EditRoute.Enabled:=false;
      LabelRoute.Enabled:=false;
      ButtonRoute.Enabled:=false;
    end;
  end;  
end;

{ TSgtsFunRoutePersonnelDeleteIface }

procedure TSgtsFunRoutePersonnelDeleteIface.Init; 
begin
  inherited Init;
  DeleteQuestion:='Удалить персону: %PERSONNEL_NAME из маршрута: %ROUTE_NAME?';
end;

end.
