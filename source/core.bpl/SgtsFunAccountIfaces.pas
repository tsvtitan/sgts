unit SgtsFunAccountIfaces;

interface

uses DB,
     SgtsRbkAccountEditFm, SgtsExecuteDefs;

type

  TSgtsFunAccountInsertIface=class(TSgtsRbkAccountInsertIface)
  private
    FPersonnelIdDef: TSgtsExecuteDefEditLink;
    FParentIdDef: TSgtsExecuteDefCalc;
    FUnionParentIdDef: TSgtsExecuteDefInvisible;
    FParentNameDef: TSgtsExecuteDefInvisible;
    
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
    function CanShow: Boolean; override;
  end;

  TSgtsFunAccountUpdateIface=class(TSgtsRbkAccountUpdateIface)
  private
    FAccountIdDef: TSgtsExecuteDefKeyLink;
    FPersonnelIdDef: TSgtsExecuteDefEditLink;
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunAccountDeleteIface=class(TSgtsRbkAccountDeleteIface)
  private
    FAccountIdDef: TSgtsExecuteDefEditLink;
    FNameDef: TSgtsExecuteDefInvisible; 
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;


implementation

uses Variants, SysUtils, SgtsCDS, SgtsDatabaseCDS, SgtsDataFmIntf, SgtsDataIfaceIntf,
     SgtsConsts, SgtsProviderConsts, SgtsFunPersonnelManagementFm;

function InternalGetParentId(IfaceIntf: ISgtsDataIface; Def: TSgtsExecuteDefCalc; PersonnelIdDef: TSgtsExecuteDefEditLink): Variant;
var
  DS: TSgtsCDS;
begin
  Result:=Def.DefaultValue;
  if Assigned(IfaceIntf) and not VarIsNull(PersonnelIdDef.Value) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.Data:=TSgtsDatabaseCDS(IfaceIntf.DataSet).Data;
      DS.Filter:=Format('%s=%s AND %s=%d',['UNION_ID',VarToStrDef(PersonnelIdDef.Value,'NULL'),'UNION_TYPE',Integer(utPersonnel)]);
      DS.Filtered:=true;
      if DS.Active and not DS.IsEmpty then
        Result:=DS.FieldByName('TREE_ID').Value;
    finally
      DS.Free;
    end;
  end;
end;

{ TSgtsFunAccountInsertIface }

procedure TSgtsFunAccountInsertIface.Init; 
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    Find('ACCOUNT_ID').Twins.Add('UNION_ID');
    Find('PERSONNEL_NAME').Twins.Add('PARENT_NAME');
    FPersonnelIdDef:=TSgtsExecuteDefEditLink(Find('PERSONNEL_ID'));
    FPersonnelIdDef.Twins.Add('UNION_PARENT_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utAccount;
    FUnionParentIdDef:=AddInvisible('UNION_PARENT_ID',ptUnknown);
    AddKey('TREE_ID',ptUnknown).ProviderName:=SProviderInsertPersonnelManagement;
    FParentIdDef:=AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
    FParentNameDef:=AddInvisible('PARENT_NAME',ptUnknown);
  end;
end;

function TSgtsFunAccountInsertIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,FPersonnelIdDef);
end;

procedure TSgtsFunAccountInsertIface.SetDefValues;
var
  UnionType: TSgtsFunPersonnelManagementIfaceUnionType;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      UnionType:=TSgtsFunPersonnelManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger);
      case UnionType of
        utPersonnel: begin
          FPersonnelIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
          FPersonnelIdDef.SetDefault;

          FPersonnelIdDef.Link.DefaultValue:=FieldByName('NAME_EX').Value;
          FPersonnelIdDef.Link.SetDefault;

          FUnionParentIdDef.DefaultValue:=FPersonnelIdDef.DefaultValue;
          FUnionParentIdDef.SetDefault;

          FParentNameDef.DefaultValue:=FPersonnelIdDef.Link.DefaultValue;
          FParentNameDef.SetDefault;

          FParentIdDef.DefaultValue:=FieldByName('TREE_ID').Value;
          FParentIdDef.SetDefault;
        end;
        utAccount: begin
          FPersonnelIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
          FPersonnelIdDef.SetDefault;

          FUnionParentIdDef.DefaultValue:=FPersonnelIdDef.DefaultValue;
          FUnionParentIdDef.SetDefault;

          FPersonnelIdDef.Link.DefaultValue:=FieldByName('PARENT_NAME').Value;
          FPersonnelIdDef.Link.SetDefault;

          FParentIdDef.DefaultValue:=FieldByName('TREE_PARENT_ID').Value;
          FParentIdDef.SetDefault;

          FParentNameDef.DefaultValue:=FPersonnelIdDef.Link.DefaultValue;
          FParentNameDef.SetDefault;
        end;
      end;
    end;
  end;
end;

function TSgtsFunAccountInsertIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          IfaceIntf.DataSet.Active and
          not IfaceIntf.DataSet.IsEmpty;
  if Result then
    with IfaceIntf.DataSet do
      Result:=TSgtsFunPersonnelManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger) in [utPersonnel,utAccount];
end;

{ TSgtsFunAccountUpdateIface }

procedure TSgtsFunAccountUpdateIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FAccountIdDef:=TSgtsExecuteDefKeyLink(Find('ACCOUNT_ID'));
    FAccountIdDef.Twins.Add('UNION_ID');
    FPersonnelIdDef:=TSgtsExecuteDefEditLink(Find('PERSONNEL_ID'));
    FPersonnelIdDef.Twins.Add('UNION_PARENT_ID');
    FPersonnelIdDef.Link.Twins.Add('PARENT_NAME');

    AddKeyLink('TREE_ID',ptUnknown);
    AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
    AddInvisible('PARENT_NAME',ptUnknown);
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utAccount;
    AddInvisible('UNION_PARENT_ID',ptUnknown).Value:=Null;
  end;
end;

procedure TSgtsFunAccountUpdateIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FAccountIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FAccountIdDef.SetDefault;

      FPersonnelIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
      FPersonnelIdDef.SetDefault;

      FPersonnelIdDef.Link.DefaultValue:=FieldByName('PARENT_NAME').Value;
      FPersonnelIdDef.Link.SetDefault;
    end;
  end;
end;

function TSgtsFunAccountUpdateIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,FPersonnelIdDef);
end;

{ TSgtsFunAccountDeleteIface }

procedure TSgtsFunAccountDeleteIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FAccountIdDef:=TSgtsExecuteDefEditLink(Find('ACCOUNT_ID'));
    FNameDef:=TSgtsExecuteDefInvisible(Find('NAME'));
    AddKeyLink('TREE_ID',ptUnknown);
  end;
end;

procedure TSgtsFunAccountDeleteIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FAccountIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FAccountIdDef.SetDefault;

      FNameDef.DefaultValue:=FieldByName('NAME_EX').Value;
      FNameDef.SetDefault;
    end;
  end;
end;


end.
