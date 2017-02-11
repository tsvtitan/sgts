unit SgtsRbkObjectPassportIfaces;

interface

uses SgtsRbkObjectPassportEditFm, SgtsExecuteDefs, SgtsFm;

type

  TSgtsRbkObjectPassportInsertIface=class(SgtsRbkObjectPassportEditFm.TSgtsRbkObjectPassportInsertIface)
  private
    FObjectIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsRbkObjectPassportUpdateIface=class(SgtsRbkObjectPassportEditFm.TSgtsRbkObjectPassportUpdateIface)
  private
    FObjectIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsRbkObjectPassportDeleteIface=class(SgtsRbkObjectPassportEditFm.TSgtsRbkObjectPassportDeleteIface)
  end;

implementation

uses SgtsDatabaseCDS, SgtsGetRecordsConfig;

{ TSgtsRbkObjectPassportInsertIface }

procedure TSgtsRbkObjectPassportInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FObjectIdDef:=TSgtsExecuteDefEditLink(Find('OBJECT_ID'));
    end;
  end;
end;

procedure TSgtsRbkObjectPassportInsertIface.SetDefValues;
var
  FObjectIdDef: TSgtsExecuteDef;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FObjectIdDef:=IfaceIntf.ExecuteDefs.Find('OBJECT_ID');
    if Assigned(FObjectIdDef) then
      with FObjectIdDef do begin
        FilterGroups.Clear;
        FilterGroups.Add.Filters.Add('OBJECT_ID',fcEqual,FObjectIdDef.Value);
      end;
  end;
end;

procedure TSgtsRbkObjectPassportInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkObjectPassportEditForm(Form) do begin
      EditObject.Enabled:=false;
      LabelObject.Enabled:=false;
      ButtonObject.Enabled:=false;
    end;
  end;
end;

{ TSgtsRbkObjectPassportUpdateIface }

procedure TSgtsRbkObjectPassportUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FObjectIdDef:=TSgtsExecuteDefEditLink(Find('OBJECT_ID'));
    end;
  end;
end;

procedure TSgtsRbkObjectPassportUpdateIface.SetDefValues;
var
  FObjectIdDef: TSgtsExecuteDef; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    DataSet.GetExecuteDefsByDefs(IfaceIntf.ExecuteDefs);
    FObjectIdDef:=IfaceIntf.ExecuteDefs.Find('OBJECT_ID');
    if Assigned(FObjectIdDef) then
      with FObjectIdDef do begin
        FilterGroups.Clear;
        FilterGroups.Add.Filters.Add('OBJECT_ID',fcEqual,FObjectIdDef.Value);
      end;
  end;
end;

procedure TSgtsRbkObjectPassportUpdateIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkObjectPassportEditForm(Form) do begin
      EditObject.Enabled:=false;
      LabelObject.Enabled:=false;
      ButtonObject.Enabled:=false;
    end;
  end;
end;

end.
