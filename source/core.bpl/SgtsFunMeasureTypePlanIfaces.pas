unit SgtsFunMeasureTypePlanIfaces;

interface

uses Classes, DB,
     SgtsRbkPlanEditFm, SgtsFm,
     SgtsExecuteDefs;

type

  TSgtsFunMeasureTypeCycleInsertIface=class(TSgtsRbkPlanInsertIface)
  private
    FSelected: Boolean;
    FCycleIdDef: TSgtsExecuteDefEditLink; 
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function NeedShow: Boolean; override;
  public
    procedure Init; override;
  end;

  TSgtsFunMeasureTypeCycleUpdateIface=class(TSgtsRbkPlanUpdateIface)
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;

  public
    procedure Init; override;
  end;

  TSgtsFunMeasureTypeCycleDeleteIface=class(TSgtsRbkPlanDeleteIface)
  public
    procedure Init; override;
  end;

implementation

uses SgtsDatabaseCDS;

{ TSgtsFunMeasureTypeCycleInsertIface }

procedure TSgtsFunMeasureTypeCycleInsertIface.Init;
begin
  inherited Init;
  Caption:='Назначить цикл виду измерения';
  with DataSet do begin
    with ExecuteDefs do begin
      FCycleIdDef:=TSgtsExecuteDefEditLink(Find('CYCLE_ID')); 
    end;
  end;
end;

procedure TSgtsFunMeasureTypeCycleInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPlanEditForm(Form) do begin
      EditMeasureType.Enabled:=false;
      LabelMeasureType.Enabled:=false;
      ButtonMeasureType.Enabled:=false;
      FSelected:=FCycleIdDef.Select;
    end;
  end;
end;

function TSgtsFunMeasureTypeCycleInsertIface.NeedShow: Boolean;
begin
  Result:=inherited NeedShow and FSelected;
end;

{ TSgtsFunMeasureTypeCycleUpdateIface }

procedure TSgtsFunMeasureTypeCycleUpdateIface.Init;
begin
  inherited Init;
  Caption:='Изменить цикл у вида измерения';
end;

procedure TSgtsFunMeasureTypeCycleUpdateIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPlanEditForm(Form) do begin
      EditMeasureType.Enabled:=false;
      LabelMeasureType.Enabled:=false;
      ButtonMeasureType.Enabled:=false;
    end;
  end;  
end;

{ TSgtsFunMeasureTypeCycleDeleteIface }

procedure TSgtsFunMeasureTypeCycleDeleteIface.Init;
begin
  inherited Init;
  Caption:='Удалить цикл: %CYCLE_NUM у вида измерения: %MEASURE_TYPE_NAME?';
end;

end.
