unit SgtsFunMeasureTypeIfaces;

interface

uses DB,
     SgtsRbkMeasureTypeEditFm, SgtsExecuteDefs;

type

  TSgtsFunMeasureTypeInsertIface=class(TSgtsRbkMeasureTypeInsertIface)
  private
    FTreeParentIdDef: TSgtsExecuteDefCalc;
    FPriority: TSgtsExecuteDefEditInteger;
    FTreeId: TSgtsExecuteDefKey;
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    function CanShow: Boolean; override;
    procedure SetDefValues; override;
    procedure Insert; override;
  end;

  TSgtsFunMeasureTypeInsertChildIface=class(TSgtsRbkMeasureTypeInsertChildIface)
  private
    FTreeParentIdDef: TSgtsExecuteDefCalc;
    FPriority: TSgtsExecuteDefEditInteger;
    FTreeId: TSgtsExecuteDefKey;
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    function CanShow: Boolean; override;
    procedure SetDefValues; override;
    procedure Insert; override;
  end;

  TSgtsFunMeasureTypeUpdateIface=class(TSgtsRbkMeasureTypeUpdateIface)
  private
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunMeasureTypeDeleteIface=class(TSgtsRbkMeasureTypeDeleteIface)
  private
    FMeasureTypeIdDef: TSgtsExecuteDefKeyLink;
  protected
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;


implementation

uses Variants, SysUtils,
     SgtsDataFmIntf, SgtsCDS, SgtsDatabaseCDS, SgtsGetRecordsConfig,
     SgtsConsts, SgtsProviderConsts, SgtsRbkPointManagementFm, SgtsDataIfaceIntf;

function InternalGetParentId(IfaceIntf: ISgtsDataIface; Def: TSgtsExecuteDefCalc; ParentIdDef: TSgtsExecuteDefEditLink): Variant;
var
  DS: TSgtsCDS;
begin
  Result:=Def.DefaultValue;
  if VarIsNull(ParentIdDef.Value) then
    Result:=Null;
  if Assigned(IfaceIntf) and not VarIsNull(ParentIdDef.Value) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.Data:=IfaceIntf.DataSet.Data;
      DS.Filter:=Format('%s=%s AND %s=%d',['UNION_ID',VarToStrDef(ParentIdDef.Value,'NULL'),'UNION_TYPE',Integer(utMeasureType)]);
      DS.Filtered:=true;
      if DS.Active and not DS.IsEmpty then
        Result:=DS.FieldByName('TREE_ID').Value;
    finally
      DS.Free;
    end;
  end;
end;

procedure ChangeRoutesParent(IfaceIntf: ISgtsDataIface; IdDef,TreeId,TreeParentId: TSgtsExecuteDef);
begin
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      BeginUpdate(true);
      try
        Filter:=Format('TREE_PARENT_ID=%s AND UNION_TYPE=%d',[QuotedStr(VarToStrDef(TreeParentId.Value,'0')),Integer(utRoute)]);
        Filtered:=true;
        Last;
        while not Bof do begin
          Edit;
          FieldByName('UNION_PARENT_ID').Value:=IdDef.Value;
          FieldByName('TREE_PARENT_ID').Value:=TreeId.Value;
          Post;
        end;
      finally
        EndUpdate(true);
      end;
    end;
  end;
end;
 
{ TSgtsFunMeasureTypeInsertIface }

procedure TSgtsFunMeasureTypeInsertIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    IdDef.Twins.Add('UNION_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utMeasureType;
    ParentIdDef.Twins.Add('UNION_PARENT_ID');
    FTreeId:=AddKey('TREE_ID',ptUnknown);
    FTreeId.ProviderName:=SProviderInsertPointManagement;
    FTreeParentIdDef:=AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
    FPriority:=TSgtsExecuteDefEditInteger(Find('PRIORITY'));
  end;
end;

procedure TSgtsFunMeasureTypeInsertIface.SetDefValues;
var
  DS: TSgtsDatabaseCDS; 
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FPriority.DefaultValue:=FieldByName('PRIORITY').AsInteger+1;
      FPriority.SetDefault;

      ParentIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
      ParentIdDef.SetDefault;

      FTreeParentIdDef.DefaultValue:=FieldByName('TREE_PARENT_ID').Value;
      FTreeParentIdDef.SetDefault;

      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderSelectMeasureTypes;
        with DS.SelectDefs do begin
          if not DisableSet then begin
            AddInvisible('DATE_BEGIN');
            AddInvisible('IS_ACTIVE');
            AddInvisible('IS_BASE');
          end;
          AddInvisible('IS_VISUAL');
        end;
        if not DisableSet then begin
          DS.FilterGroups.Add.Filters.Add('MEASURE_TYPE_ID',fcEqual,FieldByName('UNION_ID').Value);
        end else begin
          DS.FilterGroups.Add.Filters.Add('MEASURE_TYPE_ID',fcEqual,FieldByName('UNION_PARENT_ID').Value);
        end;
        DS.Open;
        DataSet.GetExecuteDefsByDataSet(DS);
      finally
        DS.Free;
      end;
    end;
  end;
end;

function TSgtsFunMeasureTypeInsertIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,ParentIdDef);
end;

function TSgtsFunMeasureTypeInsertIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          IfaceIntf.DataSet.Active;
  if Result then
    if not IfaceIntf.DataSet.IsEmpty then begin
      with IfaceIntf.DataSet do
        Result:=TSgtsRbkPointManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger) in [utMeasureType];
    end;
end;

procedure TSgtsFunMeasureTypeInsertIface.Insert; 
begin
  inherited Insert;
  ChangeRoutesParent(IfaceIntf,IdDef,FTreeId,FTreeParentIdDef);
end;

{ TSgtsFunMeasureTypeInsertChildIface }

procedure TSgtsFunMeasureTypeInsertChildIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    IdDef.Twins.Add('UNION_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utMeasureType;
    ParentIdDef.Twins.Add('UNION_PARENT_ID');
    FTreeId:=AddKey('TREE_ID',ptUnknown);
    FTreeId.ProviderName:=SProviderInsertPointManagement;
    FTreeParentIdDef:=AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
    FPriority:=TSgtsExecuteDefEditInteger(Find('PRIORITY'));
  end;
end;

function TSgtsFunMeasureTypeInsertChildIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          IfaceIntf.DataSet.Active and
          not IfaceIntf.DataSet.IsEmpty;
  if Result then
    with IfaceIntf.DataSet do
      Result:=TSgtsRbkPointManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger) in [utMeasureType];
end;

procedure TSgtsFunMeasureTypeInsertChildIface.SetDefValues;
var
  DS: TSgtsDatabaseCDS;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      ParentIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      ParentIdDef.SetDefault;

      FTreeParentIdDef.DefaultValue:=FieldByName('TREE_ID').Value;
      FTreeParentIdDef.SetDefault;

      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderSelectMeasureTypes;
        with DS.SelectDefs do begin
          if not DisableSet then begin
            AddInvisible('DATE_BEGIN');
            AddInvisible('IS_ACTIVE');
            AddInvisible('IS_BASE');
          end;
          AddInvisible('IS_VISUAL');
        end;
        DS.FilterGroups.Add.Filters.Add('MEASURE_TYPE_ID',fcEqual,FieldByName('UNION_ID').Value);
        DS.Open;
        DataSet.GetExecuteDefsByDataSet(DS);
      finally
        DS.Free;
      end;
    end;
  end;
end;

function TSgtsFunMeasureTypeInsertChildIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,ParentIdDef);
end;

procedure TSgtsFunMeasureTypeInsertChildIface.Insert;
begin
  inherited Insert;
  ChangeRoutesParent(IfaceIntf,IdDef,FTreeId,FTreeParentIdDef);
end;

{ TSgtsFunMeasureTypeUpdateIface }

procedure TSgtsFunMeasureTypeUpdateIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    IdDef.Twins.Add('UNION_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utMeasureType;
    ParentIdDef.Twins.Add('UNION_PARENT_ID');
    AddKeyLink('TREE_ID',ptUnknown);
    AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
  end;
end;

procedure TSgtsFunMeasureTypeUpdateIface.SetDefValues;
var
  DS: TSgtsDatabaseCDS;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      ParentIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
      ParentIdDef.SetDefault;

      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderSelectMeasureTypes;
        with DS.SelectDefs do begin
          AddInvisible('DATE_BEGIN');
          AddInvisible('IS_ACTIVE');
          AddInvisible('IS_BASE');
          AddInvisible('IS_VISUAL');
        end;
        DS.FilterGroups.Add.Filters.Add('MEASURE_TYPE_ID',fcEqual,FieldByName('UNION_ID').Value);
        DS.Open;
        DataSet.GetExecuteDefsByDataSet(DS);
      finally
        DS.Free;
      end;
    end;
  end;  
end;

function TSgtsFunMeasureTypeUpdateIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,ParentIdDef);
end;

{ TSgtsFunMeasureTypeDeleteIface }

procedure TSgtsFunMeasureTypeDeleteIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FMeasureTypeIdDef:=TSgtsExecuteDefKeyLink(Find('MEASURE_TYPE_ID'));
    AddKeyLink('TREE_ID',ptUnknown);
  end;
end;

procedure TSgtsFunMeasureTypeDeleteIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FMeasureTypeIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FMeasureTypeIdDef.SetDefault;
    end;
  end;
end;


end.
