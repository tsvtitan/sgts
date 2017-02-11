unit SgtsBaseFilterGroupsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCtrls, DB, TypInfo, Buttons,
  SgtsGetRecordsConfig, SgtsDbGrid, SgtsCDS, SgtsSelectDefs, SgtsDatabaseCDS,
  SgtsCoreIntf, SgtsDatabaseIntf;

type
  TSgtsBaseFilterGroupsForm = class(TForm)
    PanelButton: TPanel;
    ButtonCancel: TButton;
    ButtonOk: TButton;
    DataSourceGroups: TDataSource;
    Splitter: TSplitter;
    PanelGroups: TPanel;
    GroupBoxGroups: TGroupBox;
    PanelGridGroups: TPanel;
    BevelGroups: TBevel;
    GridPatternGroups: TDBGrid;
    NavigatorGroups: TDBNavigator;
    PanelFilters: TPanel;
    GroupBoxFilters: TGroupBox;
    PanelGridFilters: TPanel;
    BevelFilters: TBevel;
    GridPatternFilters: TDBGrid;
    DataSourceFilters: TDataSource;
    Memo: TDBMemo;
    BevelFiltersValue: TBevel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    NavigatorFilters: TDBNavigator;
    SpeedButtonUp: TSpeedButton;
    SpeedButtonDown: TSpeedButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DataSourceFiltersDataChange(Sender: TObject; Field: TField);
    procedure SpeedButtonUpClick(Sender: TObject);
    procedure SpeedButtonDownClick(Sender: TObject);
  private
    FGridGroups: TSgtsDbGrid;
    FDataSetGroups: TSgtsCDS;
    FSelectDefsGroups: TSgtsSelectDefs;
    FFilterGroups: TSgtsGetRecordsConfigFilterGroups;
    FGridFilters: TSgtsDbGrid;
    FDataSetFilters: TSgtsCDS;
    FSelectDefsFilters: TSgtsSelectDefs;
    FIndexGroupOperator: Integer;
    FIndexFilterOperator: Integer;
    FIndexFilterCondition: Integer;
    FIndexFilterCheckCase: Integer;
    FIndexFilterRightSide: Integer;
    FIndexFilterLeftSide: Integer;
    FProviderName: String;
    FCoreIntf: ISgtsCore;
    procedure GetFilterGroups;
    procedure FillFilterGroups;
    procedure FillPickList(PickList: TStrings; PInfo: PTypeInfo);
    procedure SetFilterGroups(Value: TSgtsGetRecordsConfigFilterGroups);
    procedure FieldGroupOperatorGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FieldGroupOperatorSetText(Sender: TField; const Text: string);
    procedure FieldFilterOperatorGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FieldFilterOperatorSetText(Sender: TField; const Text: string);
    procedure FieldFilterConditionGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FieldFilterConditionSetText(Sender: TField; const Text: string);
    procedure DataSetGroupsNewRecord(DataSet: TDataSet);
    procedure DataSetFiltersNewRecord(DataSet: TDataSet);
    procedure GridFiltersCellClick(Column: TColumn);
    procedure GridFiltersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function GetCurrenGridFiltersColumn: TColumn;
    function GetRealyValue(DataSet: TSgtsDatabaseCDS; FieldName: String; Value: String): Variant;
  public
    property FilterGroups: TSgtsGetRecordsConfigFilterGroups read FFilterGroups write SetFilterGroups;
    property ProviderName: String read FProviderName write FProviderName;
    property CoreIntf: ISgtsCore read FCoreIntf write FCoreIntf;
  end;

var
  SgtsBaseFilterGroupsForm: TSgtsBaseFilterGroupsForm;

implementation

uses Consts, DBClient,
     SgtsUtils;

{$R *.dfm}

{ TSgtsBaseFilterGroupsForm }

procedure TSgtsBaseFilterGroupsForm.FormCreate(Sender: TObject);
begin
  FGridGroups:=TSgtsDbGrid.Create(Self);
  with FGridGroups do begin
    Parent:=GridPatternGroups.Parent;
    Align:=GridPatternGroups.Align;
    Font.Assign(GridPatternGroups.Font);
    LocateEnabled:=false;
    ColumnSortEnabled:=false;
    Options:=Options-[dgTabs]+[dgEditing];
    ColMoving:=false;
    AutoFit:=false;
    VisibleRowNumber:=true;
    ReadOnly:=false;
    DataSource:=GridPatternGroups.DataSource;
  end;

  GridPatternGroups.Free;
  GridPatternGroups:=nil;

  FGridFilters:=TSgtsDbGrid.Create(Self);
  with FGridFilters do begin
    Parent:=GridPatternFilters.Parent;
    Align:=GridPatternFilters.Align;
    Font.Assign(GridPatternFilters.Font);
    LocateEnabled:=false;
    ColumnSortEnabled:=false;
    Options:=Options-[dgTabs]+[dgEditing];
    ColMoving:=false;
    AutoFit:=false;
    VisibleRowNumber:=true;
    ReadOnly:=false;
    DataSource:=GridPatternFilters.DataSource;
    OnCellClick:=GridFiltersCellClick;
    OnKeyDown:=GridFiltersKeyDown;
  end;

  GridPatternFilters.Free;
  GridPatternFilters:=nil;

  FDataSetGroups:=TSgtsCDS.Create(nil);
  FDataSetGroups.OnNewRecord:=DataSetGroupsNewRecord;
  with FDataSetGroups.FieldDefs do begin
    Add('GROUP_ID',ftString,32);
    Add('NAME',ftString,100);
    Add('OPERATOR',ftInteger);
  end;
  FDataSetGroups.CreateDataSet;
  with FDataSetGroups.FieldByName('OPERATOR') do begin
    OnGetText:=FieldGroupOperatorGetText;
    OnSetText:=FieldGroupOperatorSetText;
    Alignment:=taLeftJustify;
  end;

  FDataSetFilters:=TSgtsCDS.Create(nil);
  FDataSetFilters.MasterSource:=DataSourceGroups;
  FDataSetFilters.MasterFields:='GROUP_ID';
  FDataSetFilters.OnNewRecord:=DataSetFiltersNewRecord;
  with FDataSetFilters.FieldDefs do begin
    Add('GROUP_ID',ftString,32);
    Add('NAME',ftString,100);
    Add('OPERATOR',ftInteger);
    Add('CONDITION',ftInteger);
    Add('CHECK_CASE',ftInteger);
    Add('RIGHT_SIDE',ftInteger);
    Add('LEFT_SIDE',ftInteger);
    Add('VALUE',ftBlob);
  end;
  FDataSetFilters.CreateDataSet;
  with FDataSetFilters.FieldByName('OPERATOR') do begin
    OnGetText:=FieldFilterOperatorGetText;
    OnSetText:=FieldFilterOperatorSetText;
    Alignment:=taLeftJustify;
  end;
  with FDataSetFilters.FieldByName('CONDITION') do begin
    OnGetText:=FieldFilterConditionGetText;
    OnSetText:=FieldFilterConditionSetText;
    Alignment:=taLeftJustify;
  end;

  DataSourceGroups.DataSet:=FDataSetGroups;
  DataSourceFilters.DataSet:=FDataSetFilters;

  FSelectDefsGroups:=TSgtsSelectDefs.Create;
  FSelectDefsGroups.Add('NAME','Имя группы',220);
  FIndexGroupOperator:=FSelectDefsGroups.Add('OPERATOR','Оператор',60).Index;

  FSelectDefsFilters:=TSgtsSelectDefs.Create;
  FSelectDefsFilters.Add('NAME','Имя поля',155);
  FIndexFilterOperator:=FSelectDefsFilters.Add('OPERATOR','Оператор',60).Index;
  FIndexFilterCondition:=FSelectDefsFilters.Add('CONDITION','Условие',100).Index;
  FIndexFilterCheckCase:=FSelectDefsFilters.AddDrawCheck('CHECK_CASE_EX','Регистр','CHECK_CASE',35,true).Index;
  FSelectDefsFilters.Find('CHECK_CASE').Field:=FDataSetFilters.FieldByName('CHECK_CASE');
  FIndexFilterRightSide:=FSelectDefsFilters.AddDrawCheck('RIGHT_SIDE_EX','По вхождению справа','RIGHT_SIDE',35,true).Index-1;
  FSelectDefsFilters.Find('RIGHT_SIDE').Field:=FDataSetFilters.FieldByName('RIGHT_SIDE');
  FIndexFilterLeftSide:=FSelectDefsFilters.AddDrawCheck('LEFT_SIDE_EX','По вхождению слева','LEFT_SIDE',35,true).Index-2;
  FSelectDefsFilters.Find('LEFT_SIDE').Field:=FDataSetFilters.FieldByName('LEFT_SIDE');

  CreateGridColumnsBySelectDefs(FGridGroups,FSelectDefsGroups);
  CreateGridColumnsBySelectDefs(FGridFilters,FSelectDefsFilters);

  FillPickList(FGridGroups.Columns.Items[FIndexGroupOperator].PickList,TypeInfo(TSgtsGetRecordsConfigFilterOperator));
  FillPickList(FGridFilters.Columns.Items[FIndexFilterOperator].PickList,TypeInfo(TSgtsGetRecordsConfigFilterOperator));
  FillPickList(FGridFilters.Columns.Items[FIndexFilterCondition].PickList,TypeInfo(TSgtsGetRecordsConfigFilterCondition));

end;

procedure TSgtsBaseFilterGroupsForm.FormDestroy(Sender: TObject);
begin
  FSelectDefsFilters.Free;
  FSelectDefsGroups.Free;
  FDataSetFilters.Free;
  FDataSetGroups.Free;
end;

procedure TSgtsBaseFilterGroupsForm.FillPickList(PickList: TStrings; PInfo: PTypeInfo);
var
  i: Integer;
  PData: PTypeData;
begin
  PickList.BeginUpdate;
  try
    PickList.Clear;
    PData:=nil;
    if Assigned(PInfo) then
      PData:=GetTypeData(PInfo);
    if Assigned(PData) then
      for i:=PData.MinValue to PData.MaxValue do begin
        PickList.Add(GetEnumName(PInfo,i));
      end;
  finally
    PickList.EndUpdate;
  end;
end;

procedure TSgtsBaseFilterGroupsForm.FieldGroupOperatorGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger in [0..FGridGroups.Columns.Items[FIndexGroupOperator].PickList.Count-1] then
    Text:=FGridGroups.Columns.Items[FIndexGroupOperator].PickList[Sender.AsInteger];
end;

procedure TSgtsBaseFilterGroupsForm.FieldGroupOperatorSetText(Sender: TField; const Text: string);
var
  Index: Integer;
begin
  Index:=FGridGroups.Columns.Items[FIndexGroupOperator].PickList.IndexOf(Text);
  if Index in [0..FGridGroups.Columns.Items[FIndexGroupOperator].PickList.Count-1] then
    Sender.AsInteger:=Index;
end;

procedure TSgtsBaseFilterGroupsForm.FieldFilterOperatorGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger in [0..FGridFilters.Columns.Items[FIndexFilterOperator].PickList.Count-1] then
    Text:=FGridFilters.Columns.Items[FIndexFilterOperator].PickList[Sender.AsInteger];
end;

procedure TSgtsBaseFilterGroupsForm.FieldFilterOperatorSetText(Sender: TField; const Text: string);
var
  Index: Integer;
begin
  Index:=FGridFilters.Columns.Items[FIndexFilterOperator].PickList.IndexOf(Text);
  if Index in [0..FGridFilters.Columns.Items[FIndexFilterOperator].PickList.Count-1] then
    Sender.AsInteger:=Index;
end;

procedure TSgtsBaseFilterGroupsForm.FieldFilterConditionGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger in [0..FGridFilters.Columns.Items[FIndexFilterCondition].PickList.Count-1] then
    Text:=FGridFilters.Columns.Items[FIndexFilterCondition].PickList[Sender.AsInteger];
end;

procedure TSgtsBaseFilterGroupsForm.FieldFilterConditionSetText(Sender: TField; const Text: string);
var
  Index: Integer;
begin
  Index:=FGridFilters.Columns.Items[FIndexFilterCondition].PickList.IndexOf(Text);
  if Index in [0..FGridFilters.Columns.Items[FIndexFilterCondition].PickList.Count-1] then
    Sender.AsInteger:=Index;
end;

procedure TSgtsBaseFilterGroupsForm.SetFilterGroups(Value: TSgtsGetRecordsConfigFilterGroups);
begin
  FFilterGroups:=Value;
  FillFilterGroups;
end;

procedure TSgtsBaseFilterGroupsForm.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TSgtsBaseFilterGroupsForm.ButtonOkClick(Sender: TObject);
begin
  GetFilterGroups;
  ModalResult:=mrOk;
end;

function TSgtsBaseFilterGroupsForm.GetRealyValue(DataSet: TSgtsDatabaseCDS; FieldName: String; Value: String): Variant;
var
  Field: TField;
const
  NullDate: TDate=0.0;  
begin
  Result:=Null;
  if not DataSet.Active then
    exit;
  Field:=DataSet.FindField(FieldName);
  if Assigned(Field) and (Trim(Value)<>'') then begin
    case Field.DataType of
      ftInteger,ftSmallint,ftWord,ftAutoInc: begin
        Result:=StrToIntDef(Value,0);
      end;
      ftString,ftBlob,ftMemo,ftFmtMemo,ftFixedChar,ftWideString: begin
        Result:=Value;
      end;
      ftDate: begin
        Result:=StrToDateDef(Value,NullDate);
      end;
      ftDateTime: begin
        Result:=StrToDateTimeDef(Value,NullDate);
      end;
      ftBCD: begin
        if Field.DataSize=0 then
          Result:=StrToIntDef(Value,0)
        else Result:=StrToFloatDef(Value,0.0);
      end;
      ftFloat: begin
        Result:=StrToFloatDef(Value,0.0);
      end;
      ftCurrency: begin
        Result:=StrToCurrDef(Value,0.0);
      end;
    end;
  end;
end;

procedure TSgtsBaseFilterGroupsForm.GetFilterGroups;
var
  Group: TSgtsGetRecordsConfigFilterGroup;
  Filter: TSgtsGetRecordsConfigFilter;
  Value: Variant;
  FDataSet: TSgtsDatabaseCDS;
  Database: ISgtsDatabase;
begin
  if Assigned(FFilterGroups) and
     Assigned(FCoreIntf) then begin
    Database:=FCoreIntf.DatabaseModules.Current.Database;
    if not Database.ProviderExists(FProviderName) then
      exit;
    FDataSet:=TSgtsDatabaseCDS.Create(FCoreIntf);
    try
      FDataSet.WithWaitCursor:=true;
      FDataSet.ProviderName:=FProviderName;
      FDataSet.PacketRecords:=0;
      if not FDataSetFilters.IsEmpty then
        FDataSet.Open;
      FFilterGroups.Clear;
      FDataSetGroups.BeginUpdate;
      FDataSetFilters.BeginUpdate;
      FDataSetFilters.MasterFields:='';
      FDataSetFilters.MasterSource:=nil;
      try
        FDataSetGroups.First;
        while not FDataSetGroups.Eof do begin
          Group:=FFilterGroups.AddByName(FDataSetGroups.FieldByName('NAME').AsString,
                                         TSgtsGetRecordsConfigFilterOperator(FDataSetGroups.FieldByName('OPERATOR').AsInteger));

          FDataSetFilters.Filter:=Format('GROUP_ID=%s',[QuotedStr(FDataSetGroups.FieldByName('GROUP_ID').AsString)]);
          FDataSetFilters.Filtered:=true;
          FDataSetFilters.First;
          while not FDataSetFilters.Eof do begin
            Value:=GetRealyValue(FDataSet,FDataSetFilters.FieldByName('NAME').AsString,FDataSetFilters.FieldByName('VALUE').AsString);
            Filter:=Group.Filters.Add(FDataSetFilters.FieldByName('NAME').AsString,
                                      TSgtsGetRecordsConfigFilterCondition(FDataSetFilters.FieldByName('CONDITION').AsInteger),
                                      Value);
            if Assigned(Filter) then begin
              Filter.Operator:=TSgtsGetRecordsConfigFilterOperator(FDataSetFilters.FieldByName('OPERATOR').AsInteger);
              Filter.CheckCase:=Boolean(FDataSetFilters.FieldByName('CHECK_CASE').AsInteger);
              Filter.RightSide:=Boolean(FDataSetFilters.FieldByName('RIGHT_SIDE').AsInteger);
              Filter.LeftSide:=Boolean(FDataSetFilters.FieldByName('LEFT_SIDE').AsInteger);
            end;
            FDataSetFilters.Next;
          end;
          FDataSetFilters.Filter:='';
          FDataSetFilters.Filtered:=false;

          FDataSetGroups.Next;
        end;
      finally
        FDataSetFilters.MasterFields:='GROUP_ID';
        FDataSetFilters.MasterSource:=DataSourceGroups;
        FDataSetFilters.EndUpdate;
        FDataSetGroups.EndUpdate;

      end;
    finally
      FDataSet.Free;
    end;
  end;
end;

procedure TSgtsBaseFilterGroupsForm.FillFilterGroups;
var
  i,j: Integer;
  Group: TSgtsGetRecordsConfigFilterGroup;
  Filter: TSgtsGetRecordsConfigFilter;
begin
  if Assigned(FFilterGroups) then begin
    FDataSetGroups.BeginUpdate;
    FDataSetGroups.OnNewRecord:=nil;
    FDataSetFilters.BeginUpdate;
    FDataSetFilters.OnNewRecord:=nil; 
    try
      FDataSetGroups.EmptyDataSet;
      FDataSetFilters.EmptyDataSet;
      for i:=0 to FFilterGroups.Count-1 do begin
        Group:=FFilterGroups.Items[i];
        FDataSetGroups.Append;
        FDataSetGroups.FieldByName('GROUP_ID').AsString:=CreateUniqueId;
        FDataSetGroups.FieldByName('NAME').AsString:=Group.GroupName;
        FDataSetGroups.FieldByName('OPERATOR').AsInteger:=Integer(Group.Operator);
        for j:=0 to Group.Filters.Count-1 do begin
          Filter:=Group.Filters.Items[j];
          FDataSetFilters.Append;
          FDataSetFilters.FieldByName('GROUP_ID').AsString:=FDataSetGroups.FieldByName('GROUP_ID').AsString;
          FDataSetFilters.FieldByName('NAME').AsString:=Filter.FieldName;
          FDataSetFilters.FieldByName('OPERATOR').AsInteger:=Integer(Filter.Operator);
          FDataSetFilters.FieldByName('CONDITION').AsInteger:=Integer(Filter.Condition);
          FDataSetFilters.FieldByName('CHECK_CASE').AsInteger:=Integer(Filter.CheckCase);
          FDataSetFilters.FieldByName('RIGHT_SIDE').AsInteger:=Integer(Filter.RightSide);
          FDataSetFilters.FieldByName('LEFT_SIDE').AsInteger:=Integer(Filter.LeftSide);
          FDataSetFilters.FieldByName('VALUE').Value:=Filter.Value;
          FDataSetFilters.Post;
        end;
        FDataSetGroups.Post;
      end;
      FDataSetGroups.First;
    finally
      FDataSetFilters.OnNewRecord:=DataSetFiltersNewRecord;
      FDataSetFilters.EndUpdate;
      FDataSetGroups.OnNewRecord:=DataSetGroupsNewRecord;
      FDataSetGroups.EndUpdate;
    end;
  end;
end;

procedure TSgtsBaseFilterGroupsForm.DataSetGroupsNewRecord(DataSet: TDataSet);
begin
  FDataSetGroups.FieldByName('GROUP_ID').AsString:=CreateUniqueId;
  FDataSetGroups.FieldByName('NAME').AsString:=Format('Новая группа %d',[FDataSetGroups.RecordCount+1]);
end;

procedure TSgtsBaseFilterGroupsForm.DataSetFiltersNewRecord(DataSet: TDataSet);
begin
  if FDataSetGroups.Active and
     not FDataSetGroups.IsEmpty then begin
    FDataSetFilters.FieldByName('GROUP_ID').AsString:=FDataSetGroups.FieldByName('GROUP_ID').AsString;
  end else
    FDataSetFilters.Cancel;   
end;

procedure TSgtsBaseFilterGroupsForm.GridFiltersCellClick(Column: TColumn);
var
  Flag: Boolean;
begin
  if Column.Index in [FIndexFilterCheckCase,FIndexFilterRightSide,FIndexFilterLeftSide] then begin
    FGridFilters.Options:=FGridFilters.Options-[dgEditing];
  end else
    FGridFilters.Options:=FGridFilters.Options+[dgEditing];
  if FDataSetFilters.Active and
     not FDataSetFilters.IsEmpty then begin
    if Column.Index=FIndexFilterCheckCase then begin
      Flag:=Boolean(FDataSetFilters.FieldByName('CHECK_CASE').AsInteger);
      FDataSetFilters.Edit;
      FDataSetFilters.FieldByName('CHECK_CASE').AsInteger:=Integer(not Flag);
      FDataSetFilters.Post;
    end;
    if Column.Index=FIndexFilterRightSide then begin
      Flag:=Boolean(FDataSetFilters.FieldByName('RIGHT_SIDE').AsInteger);
      FDataSetFilters.Edit;
      FDataSetFilters.FieldByName('RIGHT_SIDE').AsInteger:=Integer(not Flag);
      FDataSetFilters.Post;
    end;  
    if Column.Index=FIndexFilterLeftSide then begin
      Flag:=Boolean(FDataSetFilters.FieldByName('LEFT_SIDE').AsInteger);
      FDataSetFilters.Edit;
      FDataSetFilters.FieldByName('LEFT_SIDE').AsInteger:=Integer(not Flag);
      FDataSetFilters.Post;
    end;  
  end;
end;

function TSgtsBaseFilterGroupsForm.GetCurrenGridFiltersColumn: TColumn;
begin
  Result:=nil;
  if FGridFilters.SelectedIndex<>-1 then
    Result:=FGridFilters.Columns[FGridFilters.SelectedIndex];
end;

procedure TSgtsBaseFilterGroupsForm.GridFiltersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_SPACE then begin
    GridFiltersCellClick(GetCurrenGridFiltersColumn);
  end;  
end;

procedure TSgtsBaseFilterGroupsForm.DataSourceFiltersDataChange(
  Sender: TObject; Field: TField);
begin
  SpeedButtonUp.Enabled:=FDataSetFilters.Active and not FDataSetFilters.IsEmpty;
  SpeedButtonDown.Enabled:=SpeedButtonUp.Enabled;
end;

procedure TSgtsBaseFilterGroupsForm.SpeedButtonUpClick(Sender: TObject);
begin
  FDataSetFilters.MasterSource:=nil;
  try
    FDataSetFilters.MoveData(true);
  finally
    FDataSetFilters.MasterSource:=DataSourceGroups;
  end;
end;

procedure TSgtsBaseFilterGroupsForm.SpeedButtonDownClick(Sender: TObject);
begin
  FDataSetFilters.MasterSource:=nil;
  try
    FDataSetFilters.MoveData(false);
  finally
    FDataSetFilters.MasterSource:=DataSourceGroups;
  end;
end;

end.
