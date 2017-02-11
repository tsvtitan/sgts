unit SgtsFunConverterPassportIfaces;

interface

uses  SgtsRbkConverterPassportEditFm, SgtsExecuteDefs, SgtsFm;

type

  TSgtsFunConverterPassportInsertIface=class(TSgtsRbkConverterPassportInsertIface)
  private
    FComponentIdDef: TSgtsExecuteDefEditLink;
    FSelected: Boolean;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function NeedShow: Boolean; override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunConverterPassportUpdateIface=class(TSgtsRbkConverterPassportUpdateIface)
  private
    FComponentIdDef: TSgtsExecuteDefEditLink;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunConverterPassportDeleteIface=class(TSgtsRbkConverterPassportDeleteIface)
  end;

implementation

uses SgtsDatabaseCDS, SgtsGetRecordsConfig;

{ TSgtsFunConverterPassportInsertIface }

procedure TSgtsFunConverterPassportInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FComponentIdDef:=TSgtsExecuteDefEditLink(Find('COMPONENT_ID'));
    end;
  end;
end;

procedure TSgtsFunConverterPassportInsertIface.SetDefValues;
var
  FConverterIdDef: TSgtsExecuteDef; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FConverterIdDef:=IfaceIntf.ExecuteDefs.Find('CONVERTER_ID');
    if Assigned(FConverterIdDef) then
      with FComponentIdDef do begin
        FilterGroups.Clear;
        FilterGroups.Add.Filters.Add('CONVERTER_ID',fcEqual,FConverterIdDef.Value);
      end;
  end;
end;

procedure TSgtsFunConverterPassportInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkConverterPassportEditForm(Form) do begin
      FSelected:=FComponentIdDef.Select;
    end;
  end;
end;

function TSgtsFunConverterPassportInsertIface.NeedShow: Boolean; 
begin
  Result:=inherited NeedShow and FSelected;
end;

{ TSgtsFunConverterPassportUpdateIface }

procedure TSgtsFunConverterPassportUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FComponentIdDef:=TSgtsExecuteDefEditLink(Find('COMPONENT_ID'));
    end;
  end;
end;

procedure TSgtsFunConverterPassportUpdateIface.SetDefValues;
var
  FConverterIdDef: TSgtsExecuteDef; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    FConverterIdDef:=IfaceIntf.ExecuteDefs.Find('CONVERTER_ID');
    if Assigned(FConverterIdDef) then
      with FComponentIdDef do begin
        FilterGroups.Clear;
        FilterGroups.Add.Filters.Add('CONVERTER_ID',fcEqual,FConverterIdDef.Value);
      end;
  end;
end;

end.
