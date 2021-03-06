unit SgtsFunMeasureTypeRouteIfaces;

interface

uses Classes, DB,
     SgtsRbkRouteEditFm, SgtsExecuteDefs;

type

  TSgtsFunMeasureTypeRouteInsertIface=class(TSgtsRbkRouteInsertIface)
  private
    FRouteIdDef: TSgtsExecuteDefKey;
    FUnionParentIdDef: TSgtsExecuteDefInvisible;
    FTreeParentIdDef: TSgtsExecuteDefCalc;
    function GetParentId(Def: TSgtsExecuteDefCalc): Variant;
  public
    procedure Init; override;
    function CanShow: Boolean; override;
    procedure SetDefValues; override;
    procedure Insert; override;
  end;

  TSgtsFunMeasureTypeRouteUpdateIface=class(TSgtsRbkRouteUpdateIface)
  private
    FRouteIdDef: TSgtsExecuteDefKey;
    FUnionParentIdDef: TSgtsExecuteDefInvisible;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunMeasureTypeRouteDeleteIface=class(TSgtsRbkRouteDeleteIface)
  private
    FRouteIdDef: TSgtsExecuteDefKey;
    FTreeIdDef: TSgtsExecuteDefKeyLink;
    procedure DeleteAllRoutes(RouteId: Variant; TreeId: Variant);
  public
    procedure Init; override;
    procedure SetDefValues; override;
    procedure Delete; override;
  end;

implementation

uses Variants, SysUtils,
     SgtsDataFmIntf, SgtsCDS, SgtsDatabaseCDS, SgtsUtils, 
     SgtsConsts, SgtsProviderConsts, SgtsRbkPointManagementFm,
     SgtsDataEditFm, SgtsGetRecordsConfig, SgtsDataIfaceIntf;

function InternalGetParentId(IfaceIntf: ISgtsDataIface; Def: TSgtsExecuteDefCalc; ParentIdDef: TSgtsExecuteDef): Variant;
var
  DS: TSgtsCDS;
begin
  Result:=Def.DefaultValue;
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

function CheckMeasureChild(IfaceIntf: ISgtsDataIface; UnionType: TSgtsRbkPointManagementIfaceUnionType): Boolean;
var
  DS: TSgtsCDS;
begin
  Result:=true;
  if Assigned(IfaceIntf) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.Data:=IfaceIntf.DataSet.Data;
      if DS.Active and not DS.IsEmpty then begin
        case UnionType of
          utMeasureType: DS.Filter:=Format('TREE_PARENT_ID=%s AND UNION_TYPE=%d',
                                           [QuotedStr(VarToStrDef(IfaceIntf.DataSet.FieldByName('TREE_ID').Value,'')),Integer(utMeasureType)]);
          utRoute: DS.Filter:=Format('TREE_PARENT_ID=%s AND UNION_TYPE=%d',
                                     [QuotedStr(VarToStrDef(IfaceIntf.DataSet.FieldByName('TREE_PARENT_ID').Value,'')),Integer(utMeasureType)]);
        end;
        DS.Filtered:=true;
        Result:=DS.RecordCount=0;
      end;
    finally
      DS.Free;
    end;
  end;
end;

{ TSgtsFunMeasureTypeRouteInsertIface }

procedure TSgtsFunMeasureTypeRouteInsertIface.Init;
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FRouteIdDef:=TSgtsExecuteDefKey(Find('ROUTE_ID'));
    FRouteIdDef.Twins.Add('UNION_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utRoute;
    FUnionParentIdDef:=AddInvisible('UNION_PARENT_ID',ptUnknown);
    AddKey('TREE_ID',ptUnknown).ProviderName:=SProviderInsertPointManagement;
    FTreeParentIdDef:=AddCalc('TREE_PARENT_ID',GetParentId,ptUnknown);
  end;
end;

function TSgtsFunMeasureTypeRouteInsertIface.CanShow: Boolean;
var
  UnionType: TSgtsRbkPointManagementIfaceUnionType;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          IfaceIntf.DataSet.Active and
          not IfaceIntf.DataSet.IsEmpty;
  if Result then
    with IfaceIntf.DataSet do begin
      UnionType:=TSgtsRbkPointManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger);
      Result:=UnionType in [utMeasureType,utRoute];
      Result:=Result and CheckMeasureChild(IfaceIntf,UnionType);
    end;  
end;

procedure TSgtsFunMeasureTypeRouteInsertIface.SetDefValues;
var
  DS: TSgtsDatabaseCDS;
  UnionType: TSgtsRbkPointManagementIfaceUnionType;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      UnionType:=TSgtsRbkPointManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger);
      case UnionType of
        utMeasureType: begin
          FUnionParentIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
          FUnionParentIdDef.SetDefault;

          FTreeParentIdDef.DefaultValue:=FieldByName('TREE_ID').Value;
          FTreeParentIdDef.SetDefault;
        end;
        utRoute: begin
          FUnionParentIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
          FUnionParentIdDef.SetDefault;

          FTreeParentIdDef.DefaultValue:=FieldByName('TREE_PARENT_ID').Value;
          FTreeParentIdDef.SetDefault;
        end;
      end;

      if not DisableSet then begin
        DS:=TSgtsDatabaseCDS.Create(CoreIntf);
        try
          DS.ProviderName:=SProviderSelectRoutes;
          DS.SelectDefs.AddInvisible('DATE_ROUTE');
          DS.SelectDefs.AddInvisible('IS_ACTIVE');
          DS.FilterGroups.Add.Filters.Add('ROUTE_ID',fcEqual,FieldByName('UNION_ID').Value);
          DS.Open;
          if DS.Active and not DS.IsEmpty then begin
            with DataSet.ExecuteDefs.Find('DATE_ROUTE') do begin
              DefaultValue:=DS.FieldByName('DATE_ROUTE').Value;
              SetDefault;
            end;
            with DataSet.ExecuteDefs.Find('IS_ACTIVE') do begin
              DefaultValue:=DS.FieldByName('IS_ACTIVE').Value;
              SetDefault;
            end;
          end;
        finally
          DS.Free;
        end;
      end;
    end;
  end;  
end;

function TSgtsFunMeasureTypeRouteInsertIface.GetParentId(Def: TSgtsExecuteDefCalc): Variant;
begin
  Result:=InternalGetParentId(IfaceIntf,Def,FUnionParentIdDef);
end;

procedure TSgtsFunMeasureTypeRouteInsertIface.Insert;
var
  UnionType: TSgtsRbkPointManagementIfaceUnionType;
  DS: TSgtsDatabaseCDS;
  Priority: Integer;
begin
  inherited Insert;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      Priority:=1; 
      UnionType:=TSgtsRbkPointManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger);
      if UnionType=utRoute then
        Priority:=FieldByName('PRIORITY').AsInteger+1;
      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderInsertMeasureTypeRoute;
        DS.ExecuteDefs.AddInvisible('ROUTE_ID').Value:=FRouteIdDef.Value;
        DS.ExecuteDefs.AddInvisible('MEASURE_TYPE_ID').Value:=FUnionParentIdDef.Value;
        DS.ExecuteDefs.AddInvisible('PRIORITY').Value:=Priority;
        DS.Execute;
      finally
        DS.Free;
      end;
    end;
  end;    
end;

{ TSgtsFunMeasureTypeRouteUpdateIface }

procedure TSgtsFunMeasureTypeRouteUpdateIface.Init; 
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FRouteIdDef:=TSgtsExecuteDefKey(Find('ROUTE_ID'));
    FRouteIdDef.Twins.Add('UNION_ID');
    AddInvisible('UNION_TYPE',ptUnknown).Value:=utRoute;
    FUnionParentIdDef:=AddInvisible('UNION_PARENT_ID',ptUnknown);
    AddKeyLink('TREE_ID',ptUnknown);
  end;
end;

procedure TSgtsFunMeasureTypeRouteUpdateIface.SetDefValues;
var
  DS: TSgtsDatabaseCDS;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderSelectRoutes;
        DS.SelectDefs.AddInvisible('DATE_ROUTE');
        DS.SelectDefs.AddInvisible('IS_ACTIVE');
        DS.FilterGroups.Add.Filters.Add('ROUTE_ID',fcEqual,FieldByName('UNION_ID').Value);
        DS.Open;
        if DS.Active and not DS.IsEmpty then begin
          with DataSet.ExecuteDefs.Find('DATE_ROUTE') do begin
            DefaultValue:=DS.FieldByName('DATE_ROUTE').Value;
            SetDefault;
          end;
          with DataSet.ExecuteDefs.Find('IS_ACTIVE') do begin
            DefaultValue:=DS.FieldByName('IS_ACTIVE').Value;
            SetDefault;
          end;  
        end;
      finally
        DS.Free;
      end;
    end;
  end;  
end;

{ TSgtsFunMeasureTypeRouteDeleteIface }

procedure TSgtsFunMeasureTypeRouteDeleteIface.Init; 
begin
  inherited Init;
  with DataSet.ExecuteDefs do begin
    FRouteIdDef:=TSgtsExecuteDefKey(Find('ROUTE_ID'));
    FTreeIdDef:=AddKeyLink('TREE_ID',ptUnknown);
  end;
end;

procedure TSgtsFunMeasureTypeRouteDeleteIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FRouteIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FRouteIdDef.SetDefault;
    end;
  end;
end;

procedure TSgtsFunMeasureTypeRouteDeleteIface.DeleteAllRoutes(RouteId: Variant; TreeId: Variant);
var
  Str: TStringList;
begin
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      BeginUpdate(false);
      Str:=TStringList.Create;
      try
        Filter:=Format('UNION_PARENT_ID=%s',[QuotedStr(VarToStrDef(RouteId,''))]);
        Filtered:=true;
        Last;
        while not Bof do begin
          Delete;
        end;

        Str.Add(Format('UNION_ID=%s',[QuotedStr(VarToStrDef(RouteId,''))]));
        Str.Add(Format('TREE_ID<>%s',[QuotedStr(VarToStrDef(TreeId,''))]));
        Filter:=GetFilterString(Str,'AND');
        Filtered:=true;
        Last;
        while not Bof do begin
          Delete;
        end;
        
      finally
        Str.Free;
        EndUpdate(true);
      end;
    end;
  end;  
end;

procedure TSgtsFunMeasureTypeRouteDeleteIface.Delete;
begin
  inherited Delete;
  DeleteAllRoutes(FRouteIdDef.Value,FTreeIdDef.Value);
end;

end.
