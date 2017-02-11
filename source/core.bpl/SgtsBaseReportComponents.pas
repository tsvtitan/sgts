unit SgtsBaseReportComponents;

interface

uses Classes, DB, Controls, Contnrs,
     frxClass, frxCustomDB, frxDsgnIntf,
     SgtsDatabaseCDS, SgtsSelectDefs, SgtsCoreIntf, SgtsGetRecordsConfig;

type
  TSgtsDataSet=class;

  TSgtsFieldName=class(TSgtsGetRecordsConfigFieldName)
  end;

  TSgtsFieldNames=class(TPersistent)
  private
    FFieldNames: TSgtsGetRecordsConfigFieldNames;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    property FieldNames: TSgtsGetRecordsConfigFieldNames read FFieldNames;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TSgtsOrder=class(TSgtsGetRecordsConfigOrder)
  end;

  TSgtsOrders=class(TPersistent)
  private
    FOrders: TSgtsGetRecordsConfigOrders;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    property Orders: TSgtsGetRecordsConfigOrders read FOrders;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TSgtsFilter=class(TSgtsGetRecordsConfigFilter)
  end;

  TSgtsFilters=class(TSgtsGetRecordsConfigFilters)
  end;

  TSgtsFilterGroup=class(TSgtsGetRecordsConfigFilterGroup)
  end;

  TSgtsFilterGroups=class(TPersistent)
  private
    FFilterGroups: TSgtsGetRecordsConfigFilterGroups;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    property FilterGroups: TSgtsGetRecordsConfigFilterGroups read FFilterGroups;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TSgtsParam=class(TSgtsGetRecordsConfigParam)
  end;
  
  TSgtsParams=class(TPersistent)
  private
    FParams: TSgtsGetRecordsConfigParams;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    property Params: TSgtsGetRecordsConfigParams read FParams;
  public
    constructor Create;
    destructor Destroy; override;  
  end;

  TSgtsProvider=class(TfrxDialogComponent)
  private
    FProviderName: String;
    FCoreIntf: ISgtsCore;
    FDataSet: TSgtsDataSet;
    FFieldNames: TSgtsFieldNames;
    FFetchCount: Integer;
    FOrders: TSgtsOrders;
    FFilterGroups: TSgtsFilterGroups;
    FOpenMode: TSgtsOpenMode;
    FParams: TSgtsParams;
    procedure SetCoreIntf;
    procedure SetProviderName(Value: String);
    procedure SetFieldNames(Value: TSgtsFieldNames);
    procedure SetFetchCount(Value: Integer);
    procedure SetOrders(Value: TSgtsOrders);
    procedure SetFilterGroups(Value: TSgtsFilterGroups);
    procedure FillSelectDefs(SelectDefs: TSgtsSelectDefs; IsClear: Boolean);
    procedure SetOpenMode(const Value: TSgtsOpenMode);
    procedure SetParams(const Value: TSgtsParams);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    property CoreIntf: ISgtsCore read FCoreIntf;
    property DataSet: TSgtsDataSet read FDataSet write FDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
  published
    property ProviderName: String read FProviderName write SetProviderName;
    property FetchCount: Integer read FFetchCount write SetFetchCount;
    property FieldNames: TSgtsFieldNames read FFieldNames write SetFieldNames;
    property Orders: TSgtsOrders read FOrders write SetOrders;
    property FilterGroups: TSgtsFilterGroups read FFilterGroups write SetFilterGroups;
    property Params: TSgtsParams read FParams write SetParams;
    property OpenMode: TSgtsOpenMode read FOpenMode write SetOpenMode;
  end;

  TSgtsDataSet=class(TfrxCustomDataset)
  private
    FDataSet: TSgtsDatabaseCDS;
    FProvider: TSgtsProvider;
    procedure SetProvider(Value: TSgtsProvider);
    function GetCoreIntf: ISgtsCore;
    procedure SetCoreIntf;
    procedure SetProv;
    procedure GetProv;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetMaster(const Value: TDataSource); override;
    procedure SetMasterFields(const Value: String); override;
    property CoreIntf: ISgtsCore read GetCoreIntf;
    property Filter;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    procedure Open; override;
  published
    property Provider: TSgtsProvider read FProvider write SetProvider;
  end;

  TSgtsObjectList=class(TfrxDialogComponent)
  private
    FList: TObjectList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Add(AObject: TObject): Integer;
    procedure Clear; reintroduce;
    function Count: Integer;
  end;

  TSgtsColumn=class(TObject)
  private
    FMemoHead: TfrxMemoView;
    FMemoData: TfrxMemoView;
    FVisible: Boolean;
  public
    property MemoHead: TfrxMemoView read FMemoHead write FMemoHead;
    property MemoData: TfrxMemoView read FMemoData write FMemoData;
    property Visible: Boolean read FVisible write FVisible;
  end;

  TSgtsColumns=class(TfrxDialogComponent)
  private
    FList: TObjectList;
    function GetItems(Index: Integer): TSgtsColumn;
    procedure SetItems(Index: Integer; Value: TSgtsColumn);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Add(MemoHead: TfrxMemoView; MemoData: TfrxMemoView): TSgtsColumn;
    procedure Clear; reintroduce;
    function Count: Integer;

    property Items[Index: Integer]: TSgtsColumn read GetItems write SetItems;
  end;

  TSgtsProviderNameProperty=class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TSgtsProviderFieldNamesProperty=class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TSgtsProviderOrdersProperty=class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TSgtsProviderFilterGroupsProperty=class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

implementation

{$R *.res}

uses Graphics, SysUtils, Variants,
     frxDBSet, fs_iinterpreter, frxRes,
     SgtsUtils,
     SgtsBaseReportClasses, SgtsConsts, SgtsDatabaseIntf, SgtsProviders,
     SgtsBaseOrdersFm, SgtsBaseFilterGroupsFm, SgtsBaseFieldNamesFm;


type
  TFunctions=class(TfsRTTIModule)
  public
    constructor Create(AScript: TfsScript); override;

    function TSgtsProvider_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsDataSet_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsObjectList_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsObjectList_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsObjectList_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsObjectList_Count(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsColumn_GetMemoHead(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsColumn_SetMemoHead(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsColumn_GetMemoData(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsColumn_SetMemoData(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsColumn_GetVisible(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsColumn_SetVisible(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);

    function TSgtsColumns_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsColumns_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsColumns_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsColumns_Count(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsColumns_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsFieldName_GetName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFieldName_SetName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFieldName_GetFuncType(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFieldName_SetFuncType(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);

    function TSgtsFieldNames_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsFieldNames_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsFieldNames_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    function TSgtsFieldNames_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsFilter_GetFieldName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetFieldName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilter_GetOperator(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetOperator(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilter_GetCondition(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetCondition(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilter_GetCheckCase(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetCheckCase(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilter_GetRightSide(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetRightSide(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilter_GetLeftSide(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetLeftSide(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilter_GetValue(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilter_SetValue(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);

    function TSgtsFilters_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsFilters_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsFilterGroup_GetGroupName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilterGroup_SetGroupName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilterGroup_GetOperator(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsFilterGroup_SetOperator(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsFilterGroup_GetFilters(Instance: TObject; ClassType: TClass; const PropName: String): Variant;

    function TSgtsFilterGroups_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsFilterGroups_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsFilterGroups_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    function TSgtsFilterGroups_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsOrder_GetFieldName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsOrder_SetFieldName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsOrder_GetOrderType(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsOrder_SetOrderType(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);

    function TSgtsOrders_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsOrders_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsOrders_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    function TSgtsOrders_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

    function TSgtsParam_GetParamName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsParam_SetParamName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsParam_GetParamType(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsParam_SetParamType(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
    function TSgtsParam_GetValue(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure TSgtsParam_SetValue(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);

    function TSgtsParams_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsParams_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
    function TSgtsParams_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    function TSgtsParams_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;

  end;

{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do begin
    with AddClass(TSgtsProvider,'TfrxDialogComponent') do begin
      AddConstructor('constructor Create(AOwner: TComponent)',TSgtsProvider_Create);
    end;
    with AddClass(TSgtsDataSet,'TfrxCustomDataset') do begin
      AddConstructor('constructor Create(AOwner: TComponent)',TSgtsDataSet_Create);
    end;
    with AddClass(TSgtsColumn,'TObject') do begin
      AddProperty('MemoHead','TfrxMemoView',TSgtsColumn_GetMemoHead,TSgtsColumn_SetMemoHead);
      AddProperty('MemoData','TfrxMemoView',TSgtsColumn_GetMemoData,TSgtsColumn_SetMemoData);
      AddProperty('Visible','Boolean',TSgtsColumn_GetVisible,TSgtsColumn_SetVisible);
    end;
    with AddClass(TSgtsColumns,'TfrxDialogComponent') do begin
      AddConstructor('constructor Create(AOwner: TComponent)',TSgtsColumns_Create);
      AddMethod('function Add(MemoHead: TfrxMemoView; MemoData: TfrxMemoView): TSgtsColumn',TSgtsColumns_Add);
      AddMethod('procedure Clear',TSgtsColumns_Clear);
      AddMethod('function Count: Integer',TSgtsColumns_Count);
      AddIndexProperty('Items','Integer','TSgtsColumn',TSgtsColumns_Items);
    end;
    with AddClass(TSgtsObjectList,'TfrxDialogComponent') do begin
      AddConstructor('constructor Create(AOwner: TComponent)',TSgtsObjectList_Create);
      AddMethod('function Add(AObject: TObject): Integer',TSgtsObjectList_Add);
      AddMethod('procedure Clear',TSgtsObjectList_Clear);
      AddMethod('function Count: Integer',TSgtsObjectList_Count);
    end;
    AddType('TSgtsFieldNameFuncType',fvtInt);
    AddConst('fftNone','TSgtsFieldNameFuncType',fftNone);
    AddConst('fftSum','TSgtsFieldNameFuncType',fftSum);
    with AddClass(TSgtsFieldName,'TSgtsGetRecordsConfigFieldName') do begin
      AddProperty('Name','String',TSgtsFieldName_GetName,TSgtsFieldName_SetName);
      AddProperty('FuncType','TSgtsFieldNameFuncType',TSgtsFieldName_GetFuncType,TSgtsFieldName_SetFuncType);
    end;
    with AddClass(TSgtsFieldNames,'TPersistent') do begin
      AddMethod('function Add(const Name: string; FuncType: TSgtsFieldNameFuncType): TSgtsFieldName',TSgtsFieldNames_Add);
      AddMethod('procedure Clear',TSgtsFieldNames_Clear);
      AddIndexProperty('Items','Integer','TSgtsFieldName',TSgtsFieldNames_Items);
      AddProperty('Count','Integer',TSgtsFieldNames_GetCount,nil);
    end;
    AddType('TSgtsFilterOperator',fvtInt);
    AddConst('foAnd','TSgtsFilterOperator',foAnd);
    AddConst('foOr','TSgtsFilterOperator',foOr);
    AddType('TSgtsFilterCondition',fvtInt);
    AddConst('fcEqual','TSgtsFilterCondition',fcEqual);
    AddConst('fcGreater','TSgtsFilterCondition',fcGreater);
    AddConst('fcLess','TSgtsFilterCondition',fcLess);
    AddConst('fcNotEqual','TSgtsFilterCondition',fcNotEqual);
    AddConst('fcEqualGreater','TSgtsFilterCondition',fcEqualGreater);
    AddConst('fcEqualLess','TSgtsFilterCondition',fcEqualLess);
    AddConst('fcLike','TSgtsFilterCondition',fcLike);
    AddConst('fcNotLike','TSgtsFilterCondition',fcNotLike);
    AddConst('fcIsNull','TSgtsFilterCondition',fcIsNull);
    AddConst('fcIsNotNull','TSgtsFilterCondition',fcIsNotNull);
    with AddClass(TSgtsFilter,'TSgtsGetRecordsConfigFilter') do begin
      AddProperty('FieldName','String',TSgtsFilter_GetFieldName,TSgtsFilter_SetFieldName);
      AddProperty('Operator','TSgtsFilterOperator',TSgtsFilter_GetOperator,TSgtsFilter_SetOperator);
      AddProperty('Condition','TSgtsFilterCondition',TSgtsFilter_GetCondition,TSgtsFilter_SetCondition);
      AddProperty('CheckCase','TSgtsFilterCheckCase',TSgtsFilter_GetCheckCase,TSgtsFilter_SetCheckCase);
      AddProperty('RightSide','TSgtsFilterRightSide',TSgtsFilter_GetRightSide,TSgtsFilter_SetRightSide);
      AddProperty('LeftSide','TSgtsFilterLeftSide',TSgtsFilter_GetLeftSide,TSgtsFilter_SetLeftSide);
      AddProperty('Value','TSgtsFilterValue',TSgtsFilter_GetValue,TSgtsFilter_SetValue);
    end;
    with AddClass(TSgtsFilters,'TSgtsGetRecordsConfigFilters') do begin
      AddMethod('function Add(const FieldName: string; Condition: TSgtsFilterCondition; Value: Variant): TSgtsFilter',TSgtsFilters_Add);
      AddIndexProperty('Items','Integer','TSgtsFilter',TSgtsFilters_Items);
    end;
    with AddClass(TSgtsFilterGroup,'TSgtsGetRecordsConfigFilterGroup') do begin
      AddProperty('GroupName','String',TSgtsFilterGroup_GetGroupName,TSgtsFilterGroup_SetGroupName);
      AddProperty('Operator','TSgtsFilterOperator',TSgtsFilterGroup_GetOperator,TSgtsFilterGroup_SetOperator);
      AddProperty('Filters','TSgtsFilters',TSgtsFilterGroup_GetFilters,nil);
    end;
    with AddClass(TSgtsFilterGroups,'TPersistent') do begin
      AddMethod('function Add(Operator: TSgtsFilterOperator=foAnd): TSgtsFilterGroup',TSgtsFilterGroups_Add);
      AddMethod('procedure Clear',TSgtsFilterGroups_Clear);
      AddIndexProperty('Items','Integer','TSgtsFilterGroup',TSgtsFilterGroups_Items);
      AddProperty('Count','Integer',TSgtsFilterGroups_GetCount,nil);
    end;
    AddType('TSgtsOrderType',fvtInt);
    AddConst('otDisable','TSgtsOrderType',otDisable);
    AddConst('otAsc','TSgtsOrderType',otAsc);
    AddConst('otDesc','TSgtsOrderType',otDesc);
    with AddClass(TSgtsOrder,'TSgtsGetRecordsConfigOrder') do begin
      AddProperty('FieldName','String',TSgtsOrder_GetFieldName,TSgtsOrder_SetFieldName);
      AddProperty('OrderType','TSgtsOrderType',TSgtsOrder_GetOrderType,TSgtsOrder_SetOrderType);
    end;
    with AddClass(TSgtsOrders,'TPersistent') do begin
      AddMethod('function Add(const FieldName: string; OrderType: TSgtsOrderType): TSgtsOrder',TSgtsOrders_Add);
      AddMethod('procedure Clear',TSgtsOrders_Clear);
      AddIndexProperty('Items','Integer','TSgtsOrder',TSgtsOrders_Items);
      AddProperty('Count','Integer',TSgtsOrders_GetCount,nil);
    end;

    AddType('TParamType',fvtInt);
    AddConst('ptUnknown','TParamType',ptUnknown);
    AddConst('ptInput','TParamType',ptInput);
    AddConst('ptOutput','TParamType',ptOutput);
    AddConst('ptInputOutput','TParamType',ptInputOutput);
    AddConst('ptResult','TParamType',ptResult);
    with AddClass(TSgtsParam,'TObject') do begin
      AddProperty('ParamName','String',TSgtsParam_GetParamName,TSgtsParam_SetParamName);
      AddProperty('ParamType','TParamType',TSgtsParam_GetParamType,TSgtsParam_SetParamType);
      AddProperty('Value','Variant',TSgtsParam_GetValue,TSgtsParam_SetValue);
    end;
    with AddClass(TSgtsParams,'TPersistent') do begin
      AddMethod('function Add(const ParamName: string; ParamType: TParamType=ptInput): TSgtsParam',TSgtsParams_Add);
      AddMethod('procedure Clear',TSgtsParams_Clear);
      AddIndexProperty('Items','Integer','TSgtsParam',TSgtsParams_Items);
      AddProperty('Count','Integer',TSgtsParams_GetCount,nil);
    end;
  end;
end;

function TFunctions.TSgtsProvider_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Create') then begin
    Result:=Integer(TSgtsProvider(Instance).Create(TComponent(Integer(Caller.Params[0]))))
  end
end;

function TFunctions.TSgtsDataSet_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Create') then begin
    Result:=Integer(TSgtsDataSet(Instance).Create(TComponent(Integer(Caller.Params[0]))))
  end
end;

function TFunctions.TSgtsColumn_GetMemoHead(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result:=0;
  if AnsiSameText(PropName,'MemoHead') then begin
    Result:=Integer(TSgtsColumn(Instance).MemoHead);
  end;
end;

procedure TFunctions.TSgtsColumn_SetMemoHead(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'MemoHead') then begin
    TSgtsColumn(Instance).MemoHead:=TfrxMemoView(VarToIntDef(Value,0));
  end;
end;

function TFunctions.TSgtsColumn_GetMemoData(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result:=0;
  if AnsiSameText(PropName,'MemoData') then begin
    Result:=Integer(TSgtsColumn(Instance).MemoData);
  end;
end;

procedure TFunctions.TSgtsColumn_SetMemoData(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'MemoData') then begin
    TSgtsColumn(Instance).MemoData:=TfrxMemoView(VarToIntDef(Value,0));
  end;
end;

function TFunctions.TSgtsColumn_GetVisible(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := false;
  if AnsiSameText(PropName,'Visible') then begin
    Result:=TSgtsColumn(Instance).Visible;
  end;
end;

procedure TFunctions.TSgtsColumn_SetVisible(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Visible') then begin
    TSgtsColumn(Instance).Visible:=Value;
  end;
end;

function TFunctions.TSgtsColumns_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Create') then begin
    Result:=Integer(TSgtsColumns(Instance).Create(TComponent(Integer(Caller.Params[0]))))
  end
end;

function TFunctions.TSgtsColumns_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  MemoHead: TfrxMemoView;
  MemoData: TfrxMemoView;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Add') then begin
    MemoHead:=TfrxMemoView(VarToIntDef(Caller.Params[0],0));
    MemoData:=TfrxMemoView(VarToIntDef(Caller.Params[1],0));
    Result:=Integer(TSgtsColumns(Instance).Add(MemoHead,MemoData));
  end;
end;

function TFunctions.TSgtsColumns_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Items.Get') then begin
    Result:=Integer(TSgtsColumns(Instance).Items[Caller.Params[0]]);
  end;
  if AnsiSameText(MethodName,'Items.Set') then begin
    TSgtsColumns(Instance).Items[Caller.Params[0]]:=TSgtsColumn(Integer(Caller.Params[1]));
  end;
end;

function TFunctions.TSgtsColumns_Count(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;
  if AnsiSameText(MethodName,'Count') then begin
    Result:=TSgtsColumns(Instance).Count;
  end;
end;

function TFunctions.TSgtsColumns_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Clear') then begin
    TSgtsColumns(Instance).Clear;
  end;
end;

function TFunctions.TSgtsObjectList_Create(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Create') then begin
    Result:=Integer(TSgtsObjectList(Instance).Create(TComponent(Integer(Caller.Params[0]))))
  end
end;

function TFunctions.TSgtsObjectList_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  Obj: TObject;
begin
  Result:=-1;
  if AnsiSameText(MethodName,'Add') then begin
    Obj:=TObject(VarToIntDef(Caller.Params[0],0));
    Result:=TSgtsObjectList(Instance).Add(Obj);
  end;
end;

function TFunctions.TSgtsObjectList_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Clear') then begin
    TSgtsObjectList(Instance).Clear;
  end;
end;

function TFunctions.TSgtsObjectList_Count(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Count') then begin
    Result:=TSgtsObjectList(Instance).Count;
  end;
end;

function TFunctions.TSgtsFieldName_GetName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'Name') then begin
    Result:=TSgtsGetRecordsConfigFieldName(Instance).Name;
  end;
end;

procedure TFunctions.TSgtsFieldName_SetName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Name') then begin
    TSgtsGetRecordsConfigFieldName(Instance).Name:=VarToStrDef(Value,TSgtsGetRecordsConfigFieldName(Instance).Name);
  end;
end;

function TFunctions.TSgtsFieldName_GetFuncType(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'FuncType') then begin
    Result:=TSgtsGetRecordsConfigFieldName(Instance).FuncType;
  end;
end;

procedure TFunctions.TSgtsFieldName_SetFuncType(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'FuncType') then begin
    TSgtsGetRecordsConfigFieldName(Instance).FuncType:=TSgtsGetRecordsConfigFieldNameFuncType(VarToIntDef(Value,Integer(fftNone)));
  end;
end;

function TFunctions.TSgtsFieldNames_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  Name: String;
  FuncType: TSgtsGetRecordsConfigFieldNameFuncType;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Add') then begin
    Name:=VarToStrDef(Caller.Params[0],'');
    FuncType:=TSgtsGetRecordsConfigFieldNameFuncType(VarToIntDef(Caller.Params[1],Integer(fftNone)));
    Result:=Integer(TSgtsFieldNames(Instance).FieldNames.Add(Name,FuncType));
  end;
end;

function TFunctions.TSgtsFieldNames_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Items.Get') then begin
    Result:=Integer(TSgtsFieldNames(Instance).FieldNames.Items[Caller.Params[0]]);
  end;
  if AnsiSameText(MethodName,'Items.Set') then begin
    TSgtsFieldNames(Instance).FieldNames.Items[Caller.Params[0]]:=TSgtsGetRecordsConfigFieldName(Integer(Caller.Params[1]));
  end;
end;

function TFunctions.TSgtsFieldNames_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'Count') then begin
    Result:=TSgtsFieldNames(Instance).FieldNames.Count;
  end;
end;

function TFunctions.TSgtsFieldNames_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Clear') then begin
    TSgtsFieldNames(Instance).FieldNames.Clear;
  end;
end;

function TFunctions.TSgtsFilter_GetFieldName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'FieldName') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).FieldName;
  end;
end;

procedure TFunctions.TSgtsFilter_SetFieldName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'FieldName') then begin
    TSgtsGetRecordsConfigFilter(Instance).FieldName:=VarToStrDef(Value,TSgtsGetRecordsConfigFilter(Instance).FieldName);
  end;
end;

function TFunctions.TSgtsFilter_GetOperator(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'Operator') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).Operator;
  end;
end;

procedure TFunctions.TSgtsFilter_SetOperator(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Operator') then begin
    TSgtsGetRecordsConfigFilter(Instance).Operator:=TSgtsGetRecordsConfigFilterOperator(VarToIntDef(Value,Integer(foAnd)));
  end;
end;

function TFunctions.TSgtsFilter_GetCondition(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'Condition') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).Condition;
  end;
end;

procedure TFunctions.TSgtsFilter_SetCondition(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Condition') then begin
    TSgtsGetRecordsConfigFilter(Instance).Condition:=TSgtsGetRecordsConfigFilterCondition(VarToIntDef(Value,Integer(foAnd)));
  end;
end;

function TFunctions.TSgtsFilter_GetCheckCase(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'CheckCase') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).CheckCase;
  end;
end;

procedure TFunctions.TSgtsFilter_SetCheckCase(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'CheckCase') then begin
    TSgtsGetRecordsConfigFilter(Instance).CheckCase:=Boolean(VarToIntDef(Value,Integer(false)));
  end;
end;

function TFunctions.TSgtsFilter_GetRightSide(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'RightSide') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).RightSide;
  end;
end;

procedure TFunctions.TSgtsFilter_SetRightSide(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'RightSide') then begin
    TSgtsGetRecordsConfigFilter(Instance).RightSide:=Boolean(VarToIntDef(Value,Integer(false)));
  end;
end;

function TFunctions.TSgtsFilter_GetLeftSide(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'LeftSide') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).LeftSide;
  end;
end;

procedure TFunctions.TSgtsFilter_SetLeftSide(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'LeftSide') then begin
    TSgtsGetRecordsConfigFilter(Instance).LeftSide:=Boolean(VarToIntDef(Value,Integer(false)));
  end;
end;

function TFunctions.TSgtsFilter_GetValue(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := Null;
  if AnsiSameText(PropName,'Value') then begin
    Result:=TSgtsGetRecordsConfigFilter(Instance).Value;
  end;
end;

procedure TFunctions.TSgtsFilter_SetValue(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Value') then begin
    TSgtsGetRecordsConfigFilter(Instance).Value:=Value;
  end;
end;

function TFunctions.TSgtsFilters_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  FieldName: String;
  Condition: TSgtsGetRecordsConfigFilterCondition;
  Value: Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Add') then begin
    FieldName:=VarToStrDef(Caller.Params[0],'');
    Condition:=TSgtsGetRecordsConfigFilterCondition(VarToIntDef(Caller.Params[1],Integer(fcEqual)));
    Value:=Caller.Params[2];
    Result:=Integer(TSgtsFilters(Instance).Add(FieldName,Condition,Value));
  end;
end;

function TFunctions.TSgtsFilters_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Items.Get') then begin
    Result:=Integer(TSgtsFilters(Instance).Items[Caller.Params[0]]);
  end;
  if AnsiSameText(MethodName,'Items.Set') then begin
    TSgtsFilters(Instance).Items[Caller.Params[0]]:=TSgtsGetRecordsConfigFilter(Integer(Caller.Params[1]));
  end;
end;

function TFunctions.TSgtsFilterGroup_GetGroupName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'GroupName') then begin
    Result:=TSgtsGetRecordsConfigFilterGroup(Instance).GroupName;
  end;
end;

procedure TFunctions.TSgtsFilterGroup_SetGroupName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'GroupName') then begin
    TSgtsGetRecordsConfigFilterGroup(Instance).GroupName:=VarToStrDef(Value,TSgtsGetRecordsConfigFilterGroup(Instance).GroupName);
  end;
end;

function TFunctions.TSgtsFilterGroup_GetOperator(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'Operator') then begin
    Result:=TSgtsGetRecordsConfigFilterGroup(Instance).Operator;
  end;
end;

procedure TFunctions.TSgtsFilterGroup_SetOperator(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Operator') then begin
    TSgtsGetRecordsConfigFilterGroup(Instance).Operator:=TSgtsGetRecordsConfigFilterOperator(VarToIntDef(Value,Integer(foAnd)));
  end;
end;

function TFunctions.TSgtsFilterGroup_GetFilters(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result:=0;
  if AnsiSameText(PropName,'Filters') then begin
    Result:=Integer(TSgtsGetRecordsConfigFilterGroup(Instance).Filters);
  end;
end;

function TFunctions.TSgtsFilterGroups_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  Operator: TSgtsGetRecordsConfigFilterOperator;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Add') then begin
    Operator:=TSgtsGetRecordsConfigFilterOperator(VarToIntDef(Caller.Params[0],Integer(foAnd)));
    Result:=Integer(TSgtsFilterGroups(Instance).FilterGroups.Add(Operator));
  end;
end;

function TFunctions.TSgtsFilterGroups_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Items.Get') then begin
    Result:=Integer(TSgtsFilterGroups(Instance).FilterGroups.Items[Caller.Params[0]]);
  end;
  if AnsiSameText(MethodName,'Items.Set') then begin
    TSgtsFilterGroups(Instance).FilterGroups.Items[Caller.Params[0]]:=TSgtsGetRecordsConfigFilterGroup(Integer(Caller.Params[1]));
  end;
end;

function TFunctions.TSgtsFilterGroups_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'Count') then begin
    Result:=TSgtsFilterGroups(Instance).FilterGroups.Count;
  end;
end;

function TFunctions.TSgtsFilterGroups_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Clear') then begin
    TSgtsFilterGroups(Instance).FilterGroups.Clear;
  end;
end;

function TFunctions.TSgtsOrder_GetFieldName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'FieldName') then begin
    Result:=TSgtsGetRecordsConfigOrder(Instance).FieldName;
  end;
end;

procedure TFunctions.TSgtsOrder_SetFieldName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'FieldName') then begin
    TSgtsGetRecordsConfigOrder(Instance).FieldName:=VarToStrDef(Value,TSgtsGetRecordsConfigOrder(Instance).FieldName);
  end;
end;

function TFunctions.TSgtsOrder_GetOrderType(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'OrderType') then begin
    Result:=TSgtsGetRecordsConfigOrder(Instance).OrderType;
  end;
end;

procedure TFunctions.TSgtsOrder_SetOrderType(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'OrderType') then begin
    TSgtsGetRecordsConfigOrder(Instance).OrderType:=TSgtsGetRecordsConfigOrderType(VarToIntDef(Value,Integer(otAsc)));
  end;
end;

function TFunctions.TSgtsOrders_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  FieldName: String;
  OrderType: TSgtsGetRecordsConfigOrderType;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Add') then begin
    FieldName:=VarToStrDef(Caller.Params[0],'');
    OrderType:=TSgtsGetRecordsConfigOrderType(VarToIntDef(Caller.Params[1],Integer(otAsc)));
    Result:=Integer(TSgtsOrders(Instance).Orders.Add(FieldName,OrderType));
  end;
end;

function TFunctions.TSgtsOrders_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Items.Get') then begin
    Result:=Integer(TSgtsOrders(Instance).Orders.Items[Caller.Params[0]]);
  end;
  if AnsiSameText(MethodName,'Items.Set') then begin
    TSgtsOrders(Instance).Orders.Items[Caller.Params[0]]:=TSgtsGetRecordsConfigOrder(Integer(Caller.Params[1]));
  end;
end;

function TFunctions.TSgtsOrders_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'Count') then begin
    Result:=TSgtsOrders(Instance).Orders.Count;
  end;
end;

function TFunctions.TSgtsOrders_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Clear') then begin
    TSgtsOrders(Instance).Orders.Clear;
  end;
end;

function TFunctions.TSgtsParam_GetParamName(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := '';
  if AnsiSameText(PropName,'ParamName') then begin
    Result:=TSgtsParam(Instance).ParamName;
  end;
end;

procedure TFunctions.TSgtsParam_SetParamName(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'ParamName') then begin
    TSgtsParam(Instance).ParamName:=VarToStrDef(Value,TSgtsParam(Instance).ParamName);
  end;
end;

function TFunctions.TSgtsParam_GetParamType(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'ParamType') then begin
    Result:=TSgtsParam(Instance).ParamType;
  end;
end;

procedure TFunctions.TSgtsParam_SetParamType(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'ParamType') then begin
    TSgtsParam(Instance).ParamType:=TParamType(VarToIntDef(Value,Integer(ftUnknown)));
  end;
end;

function TFunctions.TSgtsParam_GetValue(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := Null;
  if AnsiSameText(PropName,'Value') then begin
    Result:=TSgtsParam(Instance).Value;
  end;
end;

procedure TFunctions.TSgtsParam_SetValue(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if AnsiSameText(PropName,'Value') then begin
    TSgtsParam(Instance).Value:=Value;
  end;
end;

function TFunctions.TSgtsParams_Add(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
var
  Name: String;
  ParamType: TParamType;
  Obj: TSgtsParam;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Add') then begin
    Name:=VarToStrDef(Caller.Params[0],'');
    ParamType:=TParamType(VarToIntDef(Caller.Params[1],Integer(ptInput)));
    Obj:=TSgtsParam(TSgtsParams(Instance).Params.Add(Name,Null,False,False));
    if Assigned(Obj) then begin
      Obj.ParamType:=ParamType;
      Result:=Integer(Obj);
    end;
  end;
end;

function TFunctions.TSgtsParams_Items(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result:=0;
  if AnsiSameText(MethodName,'Items.Get') then begin
    Result:=Integer(TSgtsParams(Instance).Params.Items[Caller.Params[0]]);
  end;
{  if AnsiSameText(MethodName,'Items.Set') then begin
    TSgtsParams(Instance).Params.Items[Caller.Params[0]]:=TSgtsParam(Integer(Caller.Params[1]));
  end;}
end;

function TFunctions.TSgtsParams_GetCount(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;
  if AnsiSameText(PropName,'Count') then begin
    Result:=TSgtsParams(Instance).Params.Count;
  end;
end;

function TFunctions.TSgtsParams_Clear(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  if AnsiSameText(MethodName,'Clear') then begin
    TSgtsParams(Instance).Params.Clear;
  end;
end;

{ TSgtsFieldNames }

constructor TSgtsFieldNames.Create;
begin
  inherited Create;
  FFieldNames:=TSgtsGetRecordsConfigFieldNames.Create;
end;

destructor TSgtsFieldNames.Destroy;
begin
  FFieldNames.Free;
  inherited Destroy;
end;

procedure TSgtsFieldNames.ReadData(Reader: TReader);
begin
  Reader.ReadListBegin;
  FFieldNames.Clear;
  while not Reader.EndOfList do begin
    FFieldNames.Add(Reader.ReadString,TSgtsGetRecordsConfigFieldNameFuncType(Reader.ReadInteger));
  end;
  Reader.ReadListEnd;
end;

procedure TSgtsFieldNames.WriteData(Writer: TWriter);
var
  I: Integer;
  Item: TSgtsGetRecordsConfigFieldName;
begin
  Writer.WriteListBegin;
  for I := 0 to FFieldNames.Count - 1 do begin
    Item:=FFieldNames.Items[i];
    Writer.WriteString(Item.Name);
    Writer.WriteInteger(Integer(Item.FuncType));
  end;
  Writer.WriteListEnd;
end;

procedure TSgtsFieldNames.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then begin
      Result := True;
    end else
      Result := FFieldNames.Count > 0;
  end;

begin
  Filer.DefineProperty('FieldNames',ReadData,WriteData,DoWrite);
end;

{ TSgtsOrders }

constructor TSgtsOrders.Create;
begin
  inherited Create;
  FOrders:=TSgtsGetRecordsConfigOrders.Create;
end;

destructor TSgtsOrders.Destroy;
begin
  FOrders.Free;
  inherited Destroy;
end;

procedure TSgtsOrders.ReadData(Reader: TReader);
begin
  Reader.ReadListBegin;
  FOrders.Clear;
  while not Reader.EndOfList do begin
    FOrders.Add(Reader.ReadString,TSgtsGetRecordsConfigOrderType(Reader.ReadInteger));
  end;
  Reader.ReadListEnd;
end;

procedure TSgtsOrders.WriteData(Writer: TWriter);
var
  I: Integer;
  Item: TSgtsGetRecordsConfigOrder;
begin
  Writer.WriteListBegin;
  for I := 0 to FOrders.Count - 1 do begin
    Item:=FOrders.Items[i];
    Writer.WriteString(Item.FieldName);
    Writer.WriteInteger(Integer(Item.OrderType));
  end;
  Writer.WriteListEnd;
end;

procedure TSgtsOrders.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then begin
      Result := True;
    end else
      Result := FOrders.Count > 0;
  end;

begin
  Filer.DefineProperty('Orders',ReadData,WriteData,DoWrite);
end;

{ TSgtsFilterGroups }

constructor TSgtsFilterGroups.Create;
begin
  inherited Create;
  FFilterGroups:=TSgtsGetRecordsConfigFilterGroups.Create;
end;

destructor TSgtsFilterGroups.Destroy;
begin
  FFilterGroups.Free;
  inherited Destroy;
end;

procedure TSgtsFilterGroups.ReadData(Reader: TReader);
var
  Group: TSgtsGetRecordsConfigFilterGroup;
  Filter: TSgtsGetRecordsConfigFilter;
  FieldName: String;
  Operator: TSgtsGetRecordsConfigFilterOperator;
  Condition: TSgtsGetRecordsConfigFilterCondition;
  CheckCase: Boolean;
  RightSide: Boolean;
  LeftSide: Boolean;
  Value: Variant;
begin
  Reader.ReadListBegin;
  FFilterGroups.Clear;
  while not Reader.EndOfList do begin
    Group:=FilterGroups.AddByName(Reader.ReadString,TSgtsGetRecordsConfigFilterOperator(Reader.ReadInteger));
    Reader.ReadListBegin;
    while not Reader.EndOfList do begin
      FieldName:=Reader.ReadString;
      Operator:=TSgtsGetRecordsConfigFilterOperator(Reader.ReadInteger);
      Condition:=TSgtsGetRecordsConfigFilterCondition(Reader.ReadInteger);
      CheckCase:=Reader.ReadBoolean;
      RightSide:=Reader.ReadBoolean;
      LeftSide:=Reader.ReadBoolean;
      Value:=Reader.ReadVariant;
      Filter:=Group.Filters.Add(FieldName,Condition,Value);
      Filter.Operator:=Operator;
      Filter.CheckCase:=CheckCase;
      Filter.RightSide:=RightSide;
      Filter.LeftSide:=LeftSide;
      Filter.Value:=Value;
    end;
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd;
end;

procedure TSgtsFilterGroups.WriteData(Writer: TWriter);
var
  I,J: Integer;
  Group: TSgtsGetRecordsConfigFilterGroup;
  Filter: TSgtsGetRecordsConfigFilter;
begin
  Writer.WriteListBegin;
  for I := 0 to FFilterGroups.Count - 1 do begin
    Group:=FFilterGroups.Items[i];
    Writer.WriteString(Group.GroupName);
    Writer.WriteInteger(Integer(Group.Operator));
    Writer.WriteListBegin;
    for j:=0 to Group.Filters.Count-1 do begin
      Filter:=Group.Filters.Items[j];
      Writer.WriteString(Filter.FieldName);
      Writer.WriteInteger(Integer(Filter.Operator));
      Writer.WriteInteger(Integer(Filter.Condition));
      Writer.WriteBoolean(Filter.CheckCase);
      Writer.WriteBoolean(Filter.RightSide);
      Writer.WriteBoolean(Filter.LeftSide);
      Writer.WriteVariant(Filter.Value);
    end;
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;

procedure TSgtsFilterGroups.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then begin
      Result := True;
    end else
      Result := FFilterGroups.Count > 0;
  end;

begin
  Filer.DefineProperty('FilterGroups',ReadData,WriteData,DoWrite);
end;

{ TSgtsParams }

constructor TSgtsParams.Create;
begin
  inherited Create;
  FParams:=TSgtsGetRecordsConfigParams.Create;
end;

destructor TSgtsParams.Destroy;
begin
  FParams.Free;
  inherited Destroy;
end;

procedure TSgtsParams.ReadData(Reader: TReader);
var
  Param: TSgtsGetRecordsConfigParam;
  ParamName: String;
  DataType: TFieldType;
  Value: Variant;
  IsNull: Boolean;
begin
  Reader.ReadListBegin;
  FParams.Clear;
  while not Reader.EndOfList do begin
    ParamName:=Reader.ReadString;
    DataType:=TFieldType(Reader.ReadInteger);
    Value:=Reader.ReadValue;
    IsNull:=Reader.ReadBoolean;
    Param:=FParams.Add(ParamName,Value,IsNull,false);
    if Assigned(Param) then begin
      Param.DataType:=DataType;
      Param.IsKey:=Reader.ReadBoolean;
      Param.ParamType:=TParamType(Reader.ReadInteger);
      Param.Size:=Reader.ReadInteger;
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TSgtsParams.WriteData(Writer: TWriter);
var
  I: Integer;
  Param: TSgtsGetRecordsConfigParam;
begin
  Writer.WriteListBegin;
  for I := 0 to FParams.Count - 1 do begin
    Param:=FParams.Items[i];
    Writer.WriteString(Param.ParamName);
    Writer.WriteInteger(Integer(Param.DataType));
    Writer.WriteVariant(Param.Value);
    Writer.WriteBoolean(Param.IsNull);
    Writer.WriteBoolean(Param.IsKey);
    Writer.WriteInteger(Integer(Param.ParamType));
    Writer.WriteInteger(Param.Size);
  end;
  Writer.WriteListEnd;
end;

procedure TSgtsParams.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then begin
      Result := True;
    end else
      Result := FParams.Count > 0;
  end;

begin
  Filer.DefineProperty('Params',ReadData,WriteData,DoWrite);
end;


{ TSgtsProvider }

constructor TSgtsProvider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BaseName:=SProvider;
  FFieldNames:=TSgtsFieldNames.Create;
  FOrders:=TSgtsOrders.Create;
  FFilterGroups:=TSgtsFilterGroups.Create;
  FParams:=TSgtsParams.Create;
  FFetchCount:=-1;
  SetCoreIntf;
end;

destructor TSgtsProvider.Destroy;
begin
  FParams.Free;
  FFilterGroups.Free;
  FOrders.Free;
  FFieldNames.Free;
  inherited Destroy;
end;

class function TSgtsProvider.GetDescription: String;
begin
  Result:=SProviderDesc;
end;

procedure TSgtsProvider.SetCoreIntf;
begin
  if Assigned(Report) and
     (Report is TSgtsBaseReport) then begin
    FCoreIntf:=TSgtsBaseReport(Report).CoreIntf;
  end;
end;

procedure TSgtsProvider.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (AComponent=FDataSet) and (Operation=opRemove) then
    FDataSet:=nil;
end;

constructor TSgtsProvider.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited DesignCreate(AOwner,Flags);
end;

procedure TSgtsProvider.BeforeStartReport;
begin
end;

procedure TSgtsProvider.SetProviderName(Value: String);
var
  Database: ISgtsDatabase;
  ProviderG: TSgtsGetRecordsProvider;
  ProviderE: TSgtsExecuteProvider;
begin
  FProviderName:=Value;
  if Assigned(FCoreIntf) and Assigned(FCoreIntf.DatabaseModules.Current) then begin
    Database:=FCoreIntf.DatabaseModules.Current.Database;
    if Assigned(Database) then begin
      if FOpenMode=omOpen then begin
        ProviderG:=Database.GetRecordsProviders.Find(FProviderName);
        if not Assigned(ProviderG) and (Trim(FProviderName)<>'') then
          Database.GetRecordsProviders.AddGetRecords(FProviderName,FProviderName);
      end else begin
        ProviderE:=Database.ExecuteProviders.Find(FProviderName);
        if not Assigned(ProviderE) and (Trim(FProviderName)<>'') then
          Database.ExecuteProviders.AddDefault(FProviderName);
      end;
    end;
  end;
  if Assigned(FDataSet) then begin
    FDataSet.FDataSet.ProviderName:=FProviderName;
  end;
end;

procedure TSgtsProvider.FillSelectDefs(SelectDefs: TSgtsSelectDefs; IsClear: Boolean);
var
  i: Integer;
  Def: TSgtsSelectDef;
begin
  if IsClear then
    SelectDefs.Clear;

  for i:=0 to FFieldNames.FieldNames.Count-1 do begin
    Def:=SelectDefs.AddInvisible(FFieldNames.FieldNames.Items[i].Name);
    if Assigned(Def) then begin
      case FFieldNames.FieldNames.Items[i].FuncType of
        fftNone: Def.FuncType:=ftNone;
        fftSum: Def.FuncType:=ftSum;
      end;
    end;
  end;
end;

procedure TSgtsProvider.SetFieldNames(Value: TSgtsFieldNames);
begin
  FFieldNames.Assign(Value);
  if Assigned(FDataSet) then
    FillSelectDefs(FDataSet.FDataSet.SelectDefs,True);
end;

procedure TSgtsProvider.SetFetchCount(Value: Integer);
begin
  FFetchCount:=Value;
  if Assigned(FDataSet) then
    FDataSet.FDataSet.PacketRecords:=Value;
end;

procedure TSgtsProvider.SetOpenMode(const Value: TSgtsOpenMode);
begin
  FOpenMode := Value;
  if Assigned(FDataSet) then
    FDataSet.FDataSet.OpenMode:=Value;
end;

procedure TSgtsProvider.SetOrders(Value: TSgtsOrders);
begin
  FOrders.Orders.CopyFrom(Value.Orders);
  if Assigned(FDataSet) then
    FDataSet.FDataSet.Orders.CopyFrom(Value.Orders,true);
end;

procedure TSgtsProvider.SetFilterGroups(Value: TSgtsFilterGroups);
begin
  FFilterGroups.FilterGroups.CopyFrom(Value.FilterGroups);
  if Assigned(FDataSet) then
    FDataSet.FDataSet.FilterGroups.CopyFrom(Value.FilterGroups,true);
end;

procedure TSgtsProvider.SetParams(const Value: TSgtsParams);
begin
  FParams.Params.CopyFrom(Value.Params);
  if Assigned(FDataSet) then
    FDataSet.FDataSet.Params.CopyFrom(Value.Params,true);
end;


procedure TSgtsProvider.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
end;

{ TSgtsDataSet }

constructor TSgtsDataSet.Create(AOwner: TComponent);
begin
  FDataSet:=TSgtsDatabaseCDS.Create(nil);
  FDataSet.WithWaitCursor:=true;
  DataSet:=FDataSet;
  inherited Create(AOwner);
  BaseName:=SDataSet;
  SetCoreIntf;
end;

procedure TSgtsDataSet.SetCoreIntf;
begin
  if Assigned(Report) and
     (Report is TSgtsBaseReport) then begin
    FDataSet.InitByCore(TSgtsBaseReport(Report).CoreIntf);
  end;
end;

constructor TSgtsDataSet.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited DesignCreate(AOwner,Flags);
end;

class function TSgtsDataSet.GetDescription: String;
begin
  Result:=SDataSetDesc;
end;

procedure TSgtsDataSet.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent=FProvider) and (Operation=opRemove) then begin
    FProvider:=nil;
    FDataSet.ProviderName:='';
    FDataSet.SelectDefs.Clear;
    FDataSet.PacketRecords:=-1;
    FDataSet.Orders.Clear;
    FDataSet.FilterGroups.Clear;
    FDataSet.Params.Clear;
  end;
end;

procedure TSgtsDataSet.SetMaster(const Value: TDataSource);
begin
  FDataSet.MasterSource:=Value;
end;

procedure TSgtsDataSet.SetMasterFields(const Value: String);
begin
  FDataSet.MasterFields:=Value;
end;

procedure TSgtsDataSet.SetProv;
begin
  if Assigned(FProvider) then begin
    FProvider.DataSet:=Self;
    FDataSet.ProviderName:=FProvider.ProviderName;
    FDataSet.OpenMode:=FProvider.OpenMode;
    FProvider.FillSelectDefs(FDataSet.SelectDefs,True);
    FDataSet.PacketRecords:=FProvider.FetchCount;
    FDataSet.Orders.CopyFrom(FProvider.Orders.Orders);
    FDataSet.FilterGroups.CopyFrom(FProvider.FilterGroups.FilterGroups);
    FDataSet.Params.CopyFrom(FProvider.Params.Params);
  end else begin
    FDataSet.ProviderName:='';
    FDataSet.SelectDefs.Clear;
    FDataSet.PacketRecords:=-1;
    FDataSet.Orders.Clear;
    FDataSet.FilterGroups.Clear;
    FDataSet.Params.Clear;
  end;
end;

procedure TSgtsDataSet.GetProv;
var
  i: Integer;
  Param1, Param2: TSgtsGetRecordsConfigParam;
begin
  if Assigned(FProvider) then begin
    for i:=0 to FDataSet.Params.Count-1 do begin
      Param1:=FDataSet.Params.Items[i];
      Param2:=FProvider.Params.Params.Find(Param1.ParamName);
      if Assigned(Param2) then begin
        Param2.Value:=Param1.Value;
      end;
    end;
  end;
end;

procedure TSgtsDataSet.BeforeStartReport;
begin
end;

procedure TSgtsDataSet.SetProvider(Value: TSgtsProvider);
begin
  FProvider:=nil;
  SetProv;
  FProvider:=Value;
  SetProv;
end;

function TSgtsDataSet.GetCoreIntf: ISgtsCore;
begin
  Result:=nil;
  if Assigned(FDataSet) then
    Result:=FDataSet.CoreIntf;
end;

procedure TSgtsDataSet.Open;
begin
  SetProv;
  inherited Open;
  GetProv;
end;

{ TSgtsObjectList }

constructor TSgtsObjectList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TObjectList.Create;
end;

destructor TSgtsObjectList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TSgtsObjectList.Add(AObject: TObject): Integer;
begin
  Result:=FList.Add(AObject);
end;

procedure TSgtsObjectList.Clear;
begin
  FList.Clear;
end;

function TSgtsObjectList.Count: Integer;
begin
  Result:=FList.Count;
end;

{ TSgtsColumns }

constructor TSgtsColumns.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TObjectList.Create;
end;

destructor TSgtsColumns.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TSgtsColumns.GetItems(Index: Integer): TSgtsColumn;
begin
  Result:=TSgtsColumn(FList.Items[Index]);
end;

procedure TSgtsColumns.SetItems(Index: Integer; Value: TSgtsColumn);
begin
  FList.Items[Index]:=Value;
end;

function TSgtsColumns.Add(MemoHead: TfrxMemoView; MemoData: TfrxMemoView): TSgtsColumn;
begin
  Result:=TSgtsColumn.Create;
  Result.MemoHead:=MemoHead;
  Result.MemoData:=MemoData;
  Result.Visible:=true;
  FList.Add(Result);
end;

procedure TSgtsColumns.Clear;
begin
  FList.Clear;
end;

function TSgtsColumns.Count: Integer;
begin
  Result:=FList.Count;
end;


{ TSgtsProviderNameProperty }

function TSgtsProviderNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result:=[paMultiSelect, paValueList, paSortList];
end;

procedure TSgtsProviderNameProperty.GetValues;
var
  i: Integer;
  Database: ISgtsDatabase;
  ProviderG: TSgtsGetRecordsProvider;
  ProviderE: TSgtsExecuteProvider;
begin
  inherited GetValues;
  with TSgtsProvider(Component) do begin
    if Assigned(CoreIntf) and Assigned(CoreIntf.DatabaseModules.Current) then begin
      Database:=CoreIntf.DatabaseModules.Current.Database;
      if Assigned(Database) then begin
        Values.BeginUpdate;
        try
          if OpenMode=omOpen then begin
            for i:=0 to Database.GetRecordsProviders.Count-1 do begin
              ProviderG:=Database.GetRecordsProviders.Items[i];
              if ProviderG.ProviderType=rptGetRecords then
                Values.Add(ProviderG.Name);
            end;
          end else begin
            for i:=0 to Database.ExecuteProviders.Count-1 do begin
              ProviderE:=Database.ExecuteProviders.Items[i];
              Values.Add(ProviderE.Name);
            end;
          end;
        finally
          Values.EndUpdate;
        end;
      end;
    end;
  end;
end;

procedure TSgtsProviderNameProperty.SetValue(const Value: String);
begin
  inherited SetValue(Value);
  Designer.UpdateDataTree;
end;

{ TSgtsProviderFieldNamesProperty }

function TSgtsProviderFieldNamesProperty.Edit: Boolean;
var
  Form: TSgtsBaseFieldNamesForm;
begin
  Form:=TSgtsBaseFieldNamesForm.Create(Designer);
  try
    Form.FieldNames:=TSgtsProvider(Component).FieldNames.FieldNames;
    Result:=Form.ShowModal=mrOk;
  finally
    Form.Free;
  end;
end;

function TSgtsProviderFieldNamesProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ TSgtsProviderOrdersProperty }

function TSgtsProviderOrdersProperty.Edit: Boolean;
var
  Form: TSgtsBaseOrdersForm;
begin
  Form:=TSgtsBaseOrdersForm.Create(Designer);
  try
    Form.Orders:=TSgtsProvider(Component).Orders.Orders;
    Result:=Form.ShowModal=mrOk;
  finally
    Form.Free;
  end;
end;

function TSgtsProviderOrdersProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ TSgtsProviderFilterGroupsProperty }

function TSgtsProviderFilterGroupsProperty.Edit: Boolean;
var
  Form: TSgtsBaseFilterGroupsForm;
  CoreIntf: ISgtsCore;
  Database: ISgtsDatabase;
  ProviderName: String;
begin
  Result:=false;
  CoreIntf:=TSgtsProvider(Component).CoreIntf;
  if Assigned(CoreIntf) then begin
    ProviderName:=TSgtsProvider(Component).ProviderName;
    Database:=CoreIntf.DatabaseModules.Current.Database;
    if Database.ProviderExists(ProviderName) then begin
      Form:=TSgtsBaseFilterGroupsForm.Create(Designer);
      try
        Form.FilterGroups:=TSgtsProvider(Component).FilterGroups.FilterGroups;
        Form.ProviderName:=ProviderName;
        Form.CoreIntf:=CoreIntf;
        Result:=Form.ShowModal=mrOk;
      finally
        Form.Free;
      end;
    end else
      Raise Exception.CreateFmt(SProviderNotFound,[ProviderName]);  
  end;
end;

function TSgtsProviderFilterGroupsProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

var
  B1,B2: TBitmap;

initialization
  B1:=TBitmap.Create;
  B1.LoadFromResourceName(HInstance,UpperCase('SgtsBaseProvider'));
  frxObjects.RegisterObject1(TSgtsProvider,B1,'','',0,-1,[ctData]);
  B2:=TBitmap.Create;
  B2.LoadFromResourceName(HInstance,UpperCase('SgtsBaseDataSet'));
  frxObjects.RegisterObject1(TSgtsDataSet,B2);
  frxPropertyEditors.Register(TypeInfo(String),TSgtsProvider,'ProviderName',TSgtsProviderNameProperty);
  frxPropertyEditors.Register(TypeInfo(TSgtsFieldNames), TSgtsProvider, 'FieldNames', TSgtsProviderFieldNamesProperty);
  frxPropertyEditors.Register(TypeInfo(TSgtsOrders), TSgtsProvider, 'Orders', TSgtsProviderOrdersProperty);
  frxPropertyEditors.Register(TypeInfo(TSgtsFilterGroups), TSgtsProvider, 'FilterGroups', TSgtsProviderFilterGroupsProperty);
  frxResources.Add('propProviderName','��� ���������� ������ �� �������');
  frxResources.Add('propFetchCount','�� ������� ������� ����������� � �������. �������� -1 ��� ������');
  frxResources.Add('propFieldNames','������ �����, ������������ ��� ������� � �������. ������ ������ ��� ����');
  frxResources.Add('propOrders','���������� ������ �� �������');
  frxResources.Add('propFilterGroups','���������� ������ �� �������');
//  frxResources.Add('propParams','��');
  frxResources.Add('propOpenMode','����� ��������� �������. omOpen - ��������� � ���������� �������. omExecute - ��������� � ���������� ���������� ���������');
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then fsRTTIModules.Remove(TFunctions);
  frxObjects.UnRegister(TSgtsProvider);
  frxObjects.UnRegister(TSgtsDataSet);
  B1.Free;
  B2.Free;

end.