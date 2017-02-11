unit SgtsFunPointPassportIfaces;

interface

uses  SgtsRbkPointPassportEditFm, SgtsExecuteDefs, SgtsFm;

type

  TSgtsFunPointPassportInsertIface=class(TSgtsRbkPointPassportInsertIface)
  private
    FPointIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPointPassportUpdateIface=class(TSgtsRbkPointPassportUpdateIface)
  private
    FPointIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPointPassportDeleteIface=class(TSgtsRbkPointPassportDeleteIface)
  end;

implementation

uses SgtsDatabaseCDS, SgtsGetRecordsConfig;

{ TSgtsFunPointPassportInsertIface }

procedure TSgtsFunPointPassportInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FPointIdDef:=TSgtsExecuteDefEditLink(Find('POINT_ID'));
    end;
  end;
end;

procedure TSgtsFunPointPassportInsertIface.SetDefValues;
var
  FPointIdDef: TSgtsExecuteDef;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FPointIdDef:=IfaceIntf.ExecuteDefs.Find('POINT_ID');
    if Assigned(FPointIdDef) then
      with FPointIdDef do begin
        FilterGroups.Clear;
        FilterGroups.Add.Filters.Add('POINT_ID',fcEqual,FPointIdDef.Value);
      end;
  end;
end;

procedure TSgtsFunPointPassportInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPointPassportEditForm(Form) do begin
      EditPoint.Enabled:=false;
      LabelPoint.Enabled:=false;
      ButtonPoint.Enabled:=false;
    end;
  end;
end;

{ TSgtsFunPointPassportUpdateIface }

procedure TSgtsFunPointPassportUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FPointIdDef:=TSgtsExecuteDefEditLink(Find('POINT_ID'));
    end;
  end;
end;

procedure TSgtsFunPointPassportUpdateIface.SetDefValues;
var
  FPointIdDef: TSgtsExecuteDef; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    DataSet.GetExecuteDefsByDefs(IfaceIntf.ExecuteDefs);
    FPointIdDef:=IfaceIntf.ExecuteDefs.Find('POINT_ID');
    if Assigned(FPointIdDef) then
      with FPointIdDef do begin
        FilterGroups.Clear;
        FilterGroups.Add.Filters.Add('POINT_ID',fcEqual,FPointIdDef.Value);
      end;
  end;
end;

procedure TSgtsFunPointPassportUpdateIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkPointPassportEditForm(Form) do begin
      EditPoint.Enabled:=false;
      LabelPoint.Enabled:=false;
      ButtonPoint.Enabled:=false;
    end;
  end;
end;

end.
