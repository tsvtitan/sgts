unit SgtsFunPointConverterIfaces;

interface

uses Classes, DB,
     SgtsRbkConverterEditFm, SgtsFm,
     SgtsExecuteDefs, SgtsFunPointManagementIfaceIntf, SgtsCoreIntf;

type
  TSgtsFunPointConverterInsertIface=class(TSgtsRbkConverterInsertIface)
  private
    FConverterIdDef: TSgtsExecuteDefEditLink;
    FTreeParentIdDef: TSgtsExecuteDefInvisible;
    function GetIfaceIntf: ISgtsFunPointManagementIface;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    function CanShow: Boolean; override;
    procedure SetDefValues; override;

    property IfaceIntf: ISgtsFunPointManagementIface read GetIfaceIntf;
  end;

  TSgtsFunPointConverterUpdateIface=class(TSgtsRbkConverterUpdateIface)
  private
    FConverterIdDef: TSgtsExecuteDefEditLink;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

  TSgtsFunPointConverterDeleteIface=class(TSgtsRbkConverterDeleteIface)
  private
    FConverterIdDef: TSgtsExecuteDefKeyLink;
  public
    procedure Init; override;
    procedure SetDefValues; override;
  end;

implementation

uses SysUtils, Variants,
     SgtsConsts, SgtsProviderConsts, SgtsCDS, SgtsRbkPointManagementFm,
     SgtsIface, SgtsDataEditFm, SgtsDatabaseCDS,
     SgtsGetRecordsConfig, SgtsDataIfaceIntf;

function CheckPointChild(IfaceIntf: ISgtsDataIface): Boolean;
var
  DS: TSgtsCDS;
begin
  Result:=true;
  if Assigned(IfaceIntf) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      DS.Data:=IfaceIntf.DataSet.Data;
      if DS.Active and not DS.IsEmpty then begin
        DS.Filter:=Format('TREE_PARENT_ID=%s AND UNION_TYPE=%d',
                          [QuotedStr(VarToStrDef(IfaceIntf.DataSet.FieldByName('TREE_ID').Value,'')),Integer(utConverter)]);
        DS.Filtered:=true;
        Result:=DS.RecordCount=0;
      end;
    finally
      DS.Free;
    end;
  end;
end;

function CheckMeasureTypeIsVisual(CoreIntf: ISgtsCore; IfaceIntf: ISgtsDataIface): Boolean;
var
  TreeParentId: Variant;
  DS: TSgtsCDS;
  DataSet: TSgtsDatabaseCDS;
begin
  Result:=false;
  if Assigned(IfaceIntf) then begin
    DS:=TSgtsCDS.Create(nil);
    try
      TreeParentId:=IfaceIntf.DataSet.FieldByName('TREE_PARENT_ID').Value;
      DS.Data:=IfaceIntf.DataSet.Data;
      if DS.Active and not DS.IsEmpty then begin
        DS.Filter:=Format('TREE_ID=%s AND UNION_TYPE=%d',
                          [QuotedStr(VarToStrDef(TreeParentId,'')),Integer(utRoute)]);
        DS.Filtered:=true;
        if DS.RecordCount>0 then begin
          TreeParentId:=DS.FieldByName('TREE_PARENT_ID').Value;
          DS.Filter:=Format('TREE_ID=%s AND UNION_TYPE=%d',
                            [QuotedStr(VarToStrDef(TreeParentId,'')),Integer(utMeasureType)]);
          DS.Filtered:=true;
          if DS.RecordCount>0 then begin
            DataSet:=TSgtsDatabaseCDS.Create(CoreIntf);
            try
              DataSet.ProviderName:=SProviderSelectMeasureTypes;
              with DataSet do begin
                SelectDefs.AddInvisible('IS_VISUAL');
                FilterGroups.Add.Filters.Add('MEASURE_TYPE_ID',fcEqual,DS.FieldByName('UNION_ID').Value);
              end;
              DataSet.Open;
              if DataSet.Active then
                Result:=Boolean(DataSet.FieldByname('IS_VISUAL').AsInteger)
            finally
              DataSet.Free;
            end;
          end;
        end;
      end;
    finally
      DS.Free;
    end;
  end;
end;

{ TSgtsFunPointConverterInsertIface }

procedure TSgtsFunPointConverterInsertIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FConverterIdDef:=TSgtsExecuteDefEditLink(Find('CONVERTER_ID'));
      FConverterIdDef.Twins.Add('UNION_ID');
      FConverterIdDef.Twins.Add('UNION_PARENT_ID');
      FConverterIdDef.Link.Twins.Add('PARENT_NAME');
      AddInvisible('PRIORITY',ptUnknown).Value:=1;
      AddKey('TREE_ID',ptUnknown).ProviderName:=SProviderInsertPointManagement;
      FTreeParentIdDef:=AddInvisible('TREE_PARENT_ID',ptUnknown);
      AddInvisible('UNION_TYPE',ptUnknown).Value:=utConverter;
    end;
  end;
end;

function TSgtsFunPointConverterInsertIface.GetIfaceIntf: ISgtsFunPointManagementIface;
begin
  Result:=inherited IfaceIntf as ISgtsFunPointManagementIface;
end;

function TSgtsFunPointConverterInsertIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          Assigned(IfaceIntf) and
          IfaceIntf.DataSet.Active and
          not IfaceIntf.DataSet.IsEmpty;
  if Result then
    with IfaceIntf.DataSet do begin
      Result:=TSgtsRbkPointManagementIfaceUnionType(FieldByName('UNION_TYPE').AsInteger) in [utPoint];
      Result:=Result and CheckPointChild(IfaceIntf) and not CheckMeasureTypeIsVisual(CoreIntf,IfaceIntf);
    end;
end;

procedure TSgtsFunPointConverterInsertIface.AfterCreateForm(AForm: TSgtsForm); 
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkConverterEditForm(Form) do begin
      EditPoint.Enabled:=false;
      LabelPoint.Enabled:=false;
      ButtonPoint.Enabled:=false;
    end;
  end;
end;

procedure TSgtsFunPointConverterInsertIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FConverterIdDef.DefaultValue:=FieldByName('UNION_ID').Value;
      FConverterIdDef.SetDefault;
      FConverterIdDef.Link.DefaultValue:=FieldByName('NAME').Value;
      FConverterIdDef.Link.SetDefault;
      FTreeParentIdDef.DefaultValue:=FieldByName('TREE_ID').Value;
      FTreeParentIdDef.SetDefault;
    end;
  end;
end;

{ TSgtsFunPointConverterUpdateIface }

procedure TSgtsFunPointConverterUpdateIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FConverterIdDef:=TSgtsExecuteDefEditLink(Find('CONVERTER_ID'));
      FConverterIdDef.Twins.Add('UNION_ID');
      FConverterIdDef.Twins.Add('UNION_PARENT_ID');
      AddInvisible('PRIORITY',ptUnknown).Value:=1;
      AddInvisible('TREE_PARENT_ID',ptUnknown);
      AddInvisible('UNION_TYPE',ptUnknown).Value:=utConverter;
    end;
  end;
end;

procedure TSgtsFunPointConverterUpdateIface.AfterCreateForm(AForm: TSgtsForm); 
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    with TSgtsRbkConverterEditForm(Form) do begin
      EditPoint.Enabled:=false;
      LabelPoint.Enabled:=false;
      ButtonPoint.Enabled:=false;
    end;
  end;
end;

procedure TSgtsFunPointConverterUpdateIface.SetDefValues;
var
  DS: TSgtsDatabaseCDS;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
      FConverterIdDef.DefaultValue:=FieldByName('UNION_PARENT_ID').Value;
      FConverterIdDef.SetDefault;
      FConverterIdDef.Link.DefaultValue:=FieldByName('PARENT_NAME').Value;
      FConverterIdDef.Link.SetDefault;

      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderSelectConverters;
        with DS.SelectDefs do begin
          AddInvisible('DATE_ENTER');
          AddInvisible('NOT_OPERATION');
        end;
        DS.FilterGroups.Add.Filters.Add('CONVERTER_ID',fcEqual,FieldByName('UNION_ID').Value);
        DS.Open;
        DataSet.GetExecuteDefsByDataSet(DS);
      finally
        DS.Free;
      end;
    end;
  end;
end;

{ TSgtsFunPointConverterDeleteIface }

procedure TSgtsFunPointConverterDeleteIface.Init;
begin
  inherited Init;
  with DataSet do begin
    with ExecuteDefs do begin
      FConverterIdDef:=TSgtsExecuteDefKeyLink(Find('CONVERTER_ID'));
      FConverterIdDef.Twins.Add('UNION_ID');
    end;
  end;
end;

procedure TSgtsFunPointConverterDeleteIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(IfaceIntf) then begin
    with IfaceIntf.DataSet do begin
    end;
  end;
end;

end.
