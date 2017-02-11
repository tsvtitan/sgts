unit SgtsFunPersonnelIfaces;

interface

uses DB,
     SgtsRbkPersonnelEditFm, SgtsExecuteDefs;

type

  TSgtsFunPersonnelInsertIface=class(TSgtsRbkPersonnelInsertIface)
  private
    FDivisionIdDef: TSgtsExecuteDefEditLink;
    FParentIdDef: TSgtsExecuteDefCalc;
    FUnionParentIdDef: TSgtsExecuteDefInvisible;
    FParentNameDef: TSgtsExecuteDefInvisible;
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  protected
  public
    procedure Init; override;
    function CanShow: Boolean; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPersonnelUpdateIface=class(TSgtsRbkPersonnelUpdateIface)
  private
    FPersonnelIdDef: TSgtsExecuteDefKeyLink;
    FDivisionIdDef: TSgtsExecuteDefEditLink;
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPersonnelDeleteIface=class(TSgtsRbkPersonnelDeleteIface)
  private
    FPersonnelIdDef: TSgtsExecuteDefKeyLink;
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;


implementation

uses Variants, DBClient, SysUtils, SgtsCDS, SgtsDatabaseCDS, SgtsDataFmIntf, SgtsDataIfaceIntf,
     SgtsConsts, SgtsProviderConsts, SgtsFunPersonnelManagementFm;

function InternalGetParentId(IfaceIntf: ISgtsDataIface; Def: TSgtsExecuteDefCalc; DivisionIdDef: TSgtsExecuteDefEditLink): Variant;
var
  DS: TSgtsCDS;
begin
  Result:=Def.DefaultValue;
  if Assigned(IfaceIntf) and not VarIsNull(DivisionIdDef.Value) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.Data:=TSgtsDatabaseCDS(IfaceIntf.DataSet).Data;
      DS.Filter:=Format('%s=%s AND %s=%d',['UNION_ID',VarToStrDef(DivisionIdDef.Value,'NULL'),'UNION_TYPE',Integer(utDivision)]);
      DS.Filtered:=true;
      if DS.Active and not DS.IsEmpty then
        Result:=DS.FieldByName('TREE_ID').Value;
    finally
      DS.Free;
    end;
  end;
end;

{ TSgtsFunPersonnelInsertIface }

procedure TSgtsFunPersonnelInsertIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    Find('PERSONNEL_ID').Twins.Add('UNION_ID');
    Find('DIVISION_NAME').Twins.Add('PARENT_NAME');
    FDivisionIdDef:=TSgtsExecuteDefEditLink(Find('DIVISION_ID'));
    FDivisionIdDef.Twins.Add('UNION_PARENT_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utPersonnel;
    FUnionParentIdDef:=AddInvisible('UNION_PARENT_ID',ptUnknown);
    AddKey('TREE_ID',ptUnknown).ProviderName:=SProviderInsertPersonnelManagement;
    FParentIdDef:=AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
    FParentNameDef:=AddInvisible('PARENT_NAME',ptUnknown);
  end;
end;

function TSgtsFunPersonnelInsertIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,FDivisionIdDef);
end;

procedure TSgtsFunPersonnelInsertIface.SetDefValues;
var
  UnionType: TSgtsFunPersonnelManagementIfaceUnionType;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      UnionType:=TSgtsFunPersonnelManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger);
      case UnionType of
        utDivision: begin
          FDivisionIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
          FDivisionIdDef.SetDefault;

          FDivisionIdDef.Link.DefaultValue:=FieldByName('NAME_EX').Value;
          FDivisionIdDef.Link.SetDefault;

          FUnionParentIdDef.DefaultValue:=FDivisionIdDef.DefaultValue;
          FUnionParentIdDef.SetDefault;

          FParentNameDef.DefaultValue:=FDivisionIdDef.Link.DefaultValue;
          FParentNameDef.SetDefault;

          FParentIdDef.DefaultValue:=FieldByName('TREE_ID').Value;
          FParentIdDef.SetDefault;
        end;
        utPersonnel: begin
          FDivisionIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
          FDivisionIdDef.SetDefault;

          FUnionParentIdDef.DefaultValue:=FDivisionIdDef.DefaultValue;
          FUnionParentIdDef.SetDefault;

          FDivisionIdDef.Link.DefaultValue:=FieldByName('PARENT_NAME').Value;
          FDivisionIdDef.Link.SetDefault;

          FParentIdDef.DefaultValue:=FieldByName('TREE_PARENT_ID').Value;
          FParentIdDef.SetDefault;

          FParentNameDef.DefaultValue:=FDivisionIdDef.Link.DefaultValue;
          FParentNameDef.SetDefault;
        end;
      end;
    end;
  end;
end;

function TSgtsFunPersonnelInsertIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          IfaceIntf.DataSet.Active and
          not IfaceIntf.DataSet.IsEmpty;
  if Result then
    with IfaceIntf.DataSet do
      Result:=TSgtsFunPersonnelManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger) in [utDivision,utPersonnel];
end;

{ TSgtsFunPersonnelUpdateIface }

procedure TSgtsFunPersonnelUpdateIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FPersonnelIdDef:=TSgtsExecuteDefKeyLink(Find('PERSONNEL_ID'));
    FPersonnelIdDef.Twins.Add('UNION_ID');
    FDivisionIdDef:=TSgtsExecuteDefEditLink(Find('DIVISION_ID'));
    FDivisionIdDef.Twins.Add('UNION_PARENT_ID');
    FDivisionIdDef.Link.Twins.Add('PARENT_NAME');

    AddKeyLink('TREE_ID',ptUnknown);
    AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
    AddInvisible('PARENT_NAME',ptUnknown);
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utPersonnel;
    AddInvisible('UNION_PARENT_ID',ptUnknown).Value:=Null;
  end;
end;

procedure TSgtsFunPersonnelUpdateIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FPersonnelIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FPersonnelIdDef.SetDefault;

      FDivisionIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
      FDivisionIdDef.SetDefault;

      FDivisionIdDef.Link.DefaultValue:=FieldByName('PARENT_NAME').Value;
      FDivisionIdDef.Link.SetDefault;
    end;
  end;  
end;

function TSgtsFunPersonnelUpdateIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,FDivisionIdDef);
end;

{ TSgtsFunPersonnelDeleteIface }

procedure TSgtsFunPersonnelDeleteIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FPersonnelIdDef:=TSgtsExecuteDefKeyLink(Find('PERSONNEL_ID'));
    AddKeyLink('TREE_ID',ptUnknown);
  end;
end;

procedure TSgtsFunPersonnelDeleteIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FPersonnelIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FPersonnelIdDef.SetDefault;
    end;
  end;
end;


end.
