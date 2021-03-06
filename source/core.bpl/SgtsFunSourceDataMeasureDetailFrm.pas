unit SgtsFunSourceDataMeasureDetailFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB,
  DBCtrls, Mask,
  SgtsFunSourceDataFrm, SgtsDbGrid, SgtsSelectDefs, SgtsCoreIntf, SgtsDatabaseCDS,
  SgtsGetRecordsConfig, SgtsRbkParamEditFm, SgtsCDS, SgtsControls, Menus;

type
  TSgtsFunSourceDataMeasureDetailColumnType=(ctUnknown,ctPointName,ctDate,ctParamName,ctParamValue,ctParamUnit,ctParamInstrument,ctBase,ctConfirm);
  TSgtsFunSourceDataMeasureDetailColumnTypes=set of TSgtsFunSourceDataMeasureDetailColumnType;
  TSgtsFunSourceDataMeasureDetailNewRecordMode=(rmCancel,rmFill,rmInput,rmFillEmpty);
  
  TSgtsFunSourceDataMeasureDetailFrame = class(TSgtsFunSourceDataFrame)
    PanelPoints: TPanel;
    Splitter: TSplitter;
    PanelValuesAndAdditional: TPanel;
    PanelValues: TPanel;
    PanelAdditional: TPanel;
    GroupBoxAdditional: TGroupBox;
    DataSource: TDataSource;
    DataSourceValues: TDataSource;
    LabelJournalNum: TLabel;
    DBEditJournalNum: TDBEdit;
    LabelNote: TLabel;
    DBMemoNote: TDBMemo;
    GridPattern: TDBGrid;
    GridValuesPattern: TDBGrid;
    PopupMenuConfirm: TPopupMenu;
    MenuItemConfirmCheckAll: TMenuItem;
    MenuItemConfirmUncheckAll: TMenuItem;
    N1: TMenuItem;
    MenuItemConfirmCancel: TMenuItem;
    LabelConverter: TLabel;
    EditConverter: TEdit;
    LabelPointCoordinateZ: TLabel;
    EditPointCoordinateZ: TEdit;
    LabelPointObject: TLabel;
    MemoPointObject: TMemo;
    procedure PopupMenuConfirmPopup(Sender: TObject);
    procedure MenuItemConfirmCheckAllClick(Sender: TObject);
    procedure MenuItemConfirmUncheckAllClick(Sender: TObject);
    procedure DBEditJournalNumKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBMemoNoteExit(Sender: TObject);
  private
    FChangePresent: Boolean;
    FNewRecordMode: TSgtsFunSourceDataMeasureDetailNewRecordMode;
    FGrid: TSgtsFunSourceDbGrid;
    FGridValues: TSgtsFunSourceDbGrid;
    FSelectDefs: TSgtsSelectDefs;
    FSelectDefsValues: TSgtsSelectDefs;
    FDataSetParams: TSgtsDatabaseCDS;
    FDataSetPoints: TSgtsDatabaseCDS;
    FDataSetCycles: TSgtsDatabaseCDS;
    FDataSetRoutes: TSgtsDatabaseCDS;
    FDataSetPointInstruments: TSgtsDatabaseCDS;
    FDataSetInstrumentUnits: TSgtsDatabaseCDS;
    FDataSetJournal: TSgtsDatabaseCDS;
    FDataSet: TSgtsFunSourceDataCDS;
    FDataSetValues: TSgtsFunSourceDataCDS;
    function GetCurrentColumn(AGrid: TSgtsFunSourceDbGrid): TColumn;
    procedure GoDropDown(AGrid: TSgtsFunSourceDbGrid);
    procedure GoBrowse(AGrid: TSgtsFunSourceDbGrid; ChangeMode: Boolean);
    procedure PointNameFieldSetText(Sender: TField; const Text: string);
    procedure DateObservationFieldSetText(Sender: TField; const Text: string);
    procedure ParamValueFieldSetText(Sender: TField; const Text: string);
    procedure ParamValueFieldGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure InstrumentNameFieldSetText(Sender: TField; const Text: string);
    procedure MeasureNameFieldSetText(Sender: TField; const Text: string);
    procedure FillPoints(Strings: TStrings);
    procedure FillInstruments(Strings: TStrings);
    procedure FillMeasureUnits(Strings: TStrings; ByInstrumentId: Boolean; InstrumentId: Variant);
    function GetColumnType(Column: TColumn): TSgtsFunSourceDataMeasureDetailColumnType;
    procedure SetColumnProperty(Column: TColumn);
    procedure GridColEnter(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
    procedure GridEnter(Sender: TObject);
    procedure DataSetAfterScroll(DataSet: TDataSet);
    procedure DataSetAfterPost(DataSet: TDataSet);
    procedure DataSetNewRecord(DataSet: TDataSet);
    procedure DataSetValuesAfterScroll(DataSet: TDataSet);
    procedure DataSetValuesBeforePost(DataSet: TDataSet);
    function DataSetParamsLocate(Counter: Integer): Boolean;
    function GetParamType: TSgtsRbkParamType;
    function ParamIsConfirm: Boolean;
    procedure Calculate;
    function GetConfirmProc(Def: TSgtsSelectDef): Variant;
    function NextPresent(AGrid: TSgtsFunSourceDbGrid; Index: Integer; ColumnTypes: TSgtsFunSourceDataMeasureDetailColumnTypes): Boolean;
    function CheckRecord(CheckChanges: Boolean; WithMessage: Boolean=true; OnlyCurrent: Boolean=false;
                         WithParam: Boolean=false; WithEvent: Boolean=false): Boolean;
    procedure GoEdit(AGrid: TSgtsFunSourceDbGrid; WithEditor: Boolean; WithDataSet: Boolean; EditorMode: Boolean=true);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function GetIsConfirm: Boolean;
    function SaveRecord(OnlyCurrent: Boolean=false): Boolean;
    function GetMeasureTypeIdByFilter: Variant;
    function GetObjectIdByFilter: Variant;
    function GridGetFontColor(Sender: TObject; Column: TColumn; var FontStyles: TFontStyles): TColor;
    function GridValuesGetFontColor(Sender: TObject; Column: TColumn; var FontStyles: TFontStyles): TColor;
    procedure GoSelect(AGrid: TSgtsFunSourceDbGrid; ReadOnly: Boolean);
    procedure ViewPointInfo;
    procedure ViewParamInfo;
    procedure ViewInstrumentInfo;
    procedure ViewMeasureUnitInfo;
    procedure SetIsBase;
    procedure ConfirmAll(Checked: Boolean);
    function GetInstrumentIdByFilter: Variant;
    function GetMeasureUnitIdByFilter: Variant;
    function Checking(var Value: Variant): Boolean;
    procedure SetAdditionalInfo;
    procedure FillDefaultInstruments(PointId, GroupId: Variant; WithCheck: Boolean);
  protected
    function GetChangeArePresent: Boolean; override;
    procedure SetChangeArePresent(Value: Boolean); override;
    function GetCycleNum: String; override;
    function GetRouteName: String; override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    function GetDataSet: TSgtsCDS; override;
    procedure Refresh; override;
    procedure BeforeRefresh; override;
    procedure AfterRefresh; override;
    function Save: Boolean; override;
    function CanSave: Boolean; override;
    function GetActiveControl: TWinControl; override;
    procedure Insert; override;
    function CanInsert: Boolean; override;
    procedure Update; override;
    function CanUpdate: Boolean; override;
    procedure Delete; override;
    function CanDelete: Boolean; override;
    procedure Confirm; override;
    function CanConfirm: Boolean; override;
    procedure Detail; override;
    function CanDetail: Boolean; override;
  end;

var
  SgtsFunSourceDataMeasureDetailFrame: TSgtsFunSourceDataMeasureDetailFrame;

implementation

uses DBClient, DateUtils,
     SgtsConsts, SgtsProviderConsts, SgtsFunSourceDataConditionFm,
     SgtsUtils, SgtsExecuteDefs, SgtsProviders, SgtsDialogs, SgtsRbkCyclesFm,
     SgtsFunSourceDataPointsIface, SgtsFunSourceDataInstrumentsIface,
     SgtsFunSourceDataMeasureUnitsIface, SgtsFunSourceDataParamsIface,
     SgtsCheckingFm, SgtsFunPointManagementFm, SgtsDataFm, SgtsRbkPointManagementFm;

{$R *.dfm}

const
  ReturnColumnTypes=[ctPointName,ctDate,ctPointName,ctParamName,ctParamUnit,ctParamInstrument,ctParamValue];
  PickListColumnTypes=[ctPointName,ctParamUnit,ctParamInstrument];
  EditColumnTypes=[ctPointName,ctDate,ctParamValue,ctParamUnit,ctParamInstrument];
  ParamColumnTypes=[ctParamValue,ctParamUnit,ctParamInstrument];
  InfoColumnTypes=[ctPointName,ctParamName,ctParamUnit,ctParamInstrument];

{ TSgtsFunSourceDataMeasureDetailFrame }

constructor TSgtsFunSourceDataMeasureDetailFrame.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FNewRecordMode:=rmCancel;
  MemoPointObject.Anchors:=[akLeft, akTop, akRight];
  DBMemoNote.Anchors:=[akLeft, akTop, akRight, akBottom];

  FSelectDefs:=TSgtsSelectDefs.Create;
  FSelectDefsValues:=TSgtsSelectDefs.Create;

  FGrid:=TSgtsFunSourceDbGrid.Create(Self);
  with FGrid do begin
    Parent:=GridPattern.Parent;
    Align:=GridPattern.Align;
    Font.Assign(GridPattern.Font);
    Font.Style:=GridPattern.Font.Style;
    LocateEnabled:=false;
    ColumnSortEnabled:=false;
    Options:=Options-[dgEditing,dgTabs];
    ColMoving:=false;
    AutoFit:=false;
    VisibleRowNumber:=true;
    DataSource:=GridPattern.DataSource;
    TabOrder:=1;
    Visible:=false;
    ReadOnly:=false;
    OnKeyDown:=GridKeyDown;
    OnColEnter:=GridColEnter;
    OnGetFontColor:=GridGetFontColor;
    OnCellClick:=GridCellClick;
    OnDblClick:=GridDblClick;
    OnEnter:=GridEnter;
  end;

  GridPattern.Free;
  GridPattern:=nil;

  FGridValues:=TSgtsFunSourceDbGrid.Create(Self);
  with FGridValues do begin
    Parent:=GridValuesPattern.Parent;
    Align:=GridValuesPattern.Align;
    Font.Assign(GridValuesPattern.Font);
    Font.Style:=GridValuesPattern.Font.Style;
    LocateEnabled:=false;
    ColumnSortEnabled:=false;
    Options:=Options-[dgEditing,dgTabs];
    ColMoving:=false;
    AutoFit:=false;
    VisibleRowNumber:=true;
    DataSource:=GridValuesPattern.DataSource;
    TabOrder:=1;
    Visible:=false;
    ReadOnly:=false;
    OnKeyDown:=GridKeyDown;
    OnColEnter:=GridColEnter;
    OnEnter:=GridEnter;
    OnDblClick:=GridDblClick;
    OnGetFontColor:=GridValuesGetFontColor;
  end;

  GridValuesPattern.Free;
  GridValuesPattern:=nil;

  FDataSetParams:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetParams do begin
    ProviderName:=SProviderSelectMeasureTypeParams;
    with SelectDefs do begin
      AddInvisible('PARAM_ID');
      AddInvisible('PARAM_NAME');
      AddInvisible('PARAM_DESCRIPTION');
      AddInvisible('PARAM_TYPE');
      AddInvisible('PARAM_FORMAT');
      AddInvisible('ALGORITHM_PROC_NAME');
      AddInvisible('PARAM_IS_NOT_CONFIRM');
    end;
  end;

  FDataSetPoints:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetPoints do begin
    ProviderName:=SProviderSelectRouteConverters;
    with SelectDefs do begin
      AddInvisible('POINT_ID');
      AddInvisible('POINT_NAME');
      AddInvisible('ROUTE_ID');
      AddInvisible('ROUTE_NAME');
      AddInvisible('PRIORITY');
      AddInvisible('CONVERTER_NAME');
      AddInvisible('COORDINATE_Z');
      AddInvisible('OBJECT_PATHS');
      AddInvisible('CONVERTER_NOT_OPERATION');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;

  FDataSetCycles:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetCycles do begin
    ProviderName:=SProviderSelectCycles;
    with SelectDefs do begin
      AddInvisible('CYCLE_ID');
      AddInvisible('CYCLE_NUM');
      AddInvisible('CYCLE_YEAR');
      AddInvisible('CYCLE_MONTH');
      AddInvisible('DESCRIPTION');
      AddInvisible('IS_CLOSE');
    end;
  end;

  FDataSetRoutes:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetRoutes do begin
    ProviderName:=SProviderSelectMeasureTypeRoutes;
    with SelectDefs do begin
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('ROUTE_ID');
      AddInvisible('ROUTE_NAME');
      AddInvisible('PRIORITY');
      AddInvisible('IS_BASE');
    end;
  end;

  FDataSetPointInstruments:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetPointInstruments do begin
    ProviderName:=SProviderSelectPointInstruments;
    with SelectDefs do begin
      AddInvisible('POINT_ID');
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('PARAM_ID');
      AddInvisible('INSTRUMENT_NAME');
      AddInvisible('POINT_NAME');
      AddInvisible('PARAM_NAME');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;

  FDataSetInstrumentUnits:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetInstrumentUnits do begin
    ProviderName:=SProviderSelectInstrumentUnits;
    with SelectDefs do begin
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('MEASURE_UNIT_ID');
      AddInvisible('INSTRUMENT_NAME');
      AddInvisible('MEASURE_UNIT_NAME');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;
  
  FDataSetJournal:=TSgtsDatabaseCDS.Create(ACoreIntf);
  with FDataSetJournal do begin
    ProviderName:=SProviderSelectJournalFields;
    with SelectDefs do begin
      AddInvisible('JOURNAL_FIELD_ID');
      AddInvisible('JOURNAL_NUM');
      AddInvisible('NOTE');
      AddInvisible('DATE_OBSERVATION');
      AddInvisible('CYCLE_ID');
      AddInvisible('CYCLE_NUM');
      AddInvisible('POINT_ID');
      AddInvisible('POINT_NAME');
      AddInvisible('PARAM_ID');
      AddInvisible('PARAM_NAME');
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('INSTRUMENT_NAME');
      AddInvisible('MEASURE_UNIT_ID');
      AddInvisible('MEASURE_UNIT_NAME');
      AddInvisible('VALUE');
      AddInvisible('WHO_ENTER');
      AddInvisible('DATE_ENTER');
      AddInvisible('WHO_CONFIRM');
      AddInvisible('DATE_CONFIRM');
      AddInvisible('GROUP_ID');
      AddInvisible('IS_BASE');
      AddInvisible('IS_CHECK');
    end;
    Orders.Add('DATE_OBSERVATION',otAsc);
    Orders.Add('GROUP_ID',otAsc);
    Orders.Add('PRIORITY',otAsc);
  end;

  FDataSet:=TSgtsFunSourceDataCDS.Create(nil);
  with FDataSet do begin
    IndexDefs.Add('IDX_CYCLE_DATE_ROUTE_POINT','CYCLE_ID;DATE_OBSERVATION;ROUTE_PRIORITY;POINT_PRIORITY',[]);
    IndexDefs.Add('IDX_CYCLE_DATE_POINT','CYCLE_ID;DATE_OBSERVATION;POINT_ID',[]);
    AfterScroll:=DataSetAfterScroll;
    OnNewRecord:=DataSetNewRecord;
    AfterPost:=DataSetAfterPost;
    IndexName:='IDX_CYCLE_DATE_ROUTE_POINT';
  end;
  FDataSet.SelectDefs:=FSelectDefs;
  DataSource.DataSet:=FDataSet;

  FDataSetValues:=TSgtsFunSourceDataCDS.Create(nil);
  with FDataSetValues do begin
    MasterFields:='GROUP_ID';
    MasterSource:=DataSource;
    AfterScroll:=DataSetValuesAfterScroll;
    BeforePost:=DataSetValuesBeforePost;
    AfterPost:=DataSetAfterPost;
  end;
  FDataSetValues.SelectDefs:=FSelectDefsValues;
  DataSourceValues.DataSet:=FDataSetValues;
end;

destructor TSgtsFunSourceDataMeasureDetailFrame.Destroy;
begin
  FDataSetValues.Free;
  FDataSet.Free;
  FDataSetJournal.Free;
  FDataSetInstrumentUnits.Free;
  FDataSetPointInstruments.Free;
  FDataSetCycles.Free;
  FDataSetPoints.Free;
  FDataSetParams.Free;
  FSelectDefsValues.Free;
  FSelectDefs.Free;
  inherited Destroy;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.FillDefaultInstruments(PointId, GroupId: Variant; WithCheck: Boolean);
var
  FOldAfterScroll: TDataSetNotifyEvent;
  Counter: Integer;
  ParamId: Variant;
  InstrumentId: Variant;
begin
  if FDataSetPointInstruments.Active and
     FDataSetInstrumentUnits.Active then begin
    FOldAfterScroll:=FDataSetValues.AfterScroll;
    FDataSetValues.AfterScroll:=nil;
    try
      Counter:=0;
      FDataSetParams.First;
      while not FDataSetParams.Eof do begin
        FDataSetValues.Append;
        FDataSetValues.FieldByName('GROUP_ID').Value:=GroupId;
        ParamId:=FDataSetParams.FieldByName('PARAM_ID').Value;
        FDataSetValues.FieldByName('PARAM_ID').Value:=ParamId;
        FDataSetValues.FieldByName('PARAM_FORMAT').Value:=FDataSetParams.FieldByName('PARAM_FORMAT').Value;
        FDataSetValues.FieldByName('PARAM_NAME').Value:=FDataSetParams.FieldByName('PARAM_NAME').Value;
        FDataSetPointInstruments.First;
        if FDataSetPointInstruments.Locate('POINT_ID;PARAM_ID',VarArrayOf([PointId,ParamId])) then begin
          InstrumentId:=FDataSetPointInstruments.FieldByName('INSTRUMENT_ID').Value;
          FDataSetValues.FieldByName('INSTRUMENT_ID').Value:=InstrumentId;
          FDataSetValues.FieldByName('INSTRUMENT_NAME').Value:=FDataSetPointInstruments.FieldByName('INSTRUMENT_NAME').Value;
          FDataSetInstrumentUnits.First;
          if FDataSetInstrumentUnits.Locate('INSTRUMENT_ID',InstrumentId) then begin
            FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value:=FDataSetInstrumentUnits.FieldByName('MEASURE_UNIT_ID').Value;
            FDataSetValues.FieldByName('MEASURE_UNIT_NAME').Value:=FDataSetInstrumentUnits.FieldByName('MEASURE_UNIT_NAME').Value;
          end;
        end else begin
          InstrumentId:=GetValueByCounter('INSTRUMENT_ID',Counter);
          FDataSetValues.FieldByName('INSTRUMENT_ID').Value:=InstrumentId;
          FDataSetValues.FieldByName('INSTRUMENT_NAME').Value:=GetValueByCounter('INSTRUMENT_NAME',Counter);
          FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value:=GetValueByCounter('MEASURE_UNIT_ID',Counter);
          FDataSetValues.FieldByName('MEASURE_UNIT_NAME').Value:=GetValueByCounter('MEASURE_UNIT_NAME',Counter);
        end;
        if WithCheck then
          FDataSetValues.FieldByName('IS_CHECK').Value:=Integer(true);
        FDataSetValues.Post;
        Inc(Counter);
        FDataSetParams.Next;
      end;
    finally
      FDataSetValues.AfterScroll:=FOldAfterScroll;
    end;
  end;

end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Refresh;
var
  DSRestrictIsBase: TSgtsDatabaseCDS;

  function CreateData: Boolean;
  begin
    Result:=false;
    FDataSetParams.Close;
    FDataSetPoints.Close;
    FDataSetCycles.Close;
    FDataSetRoutes.Close;
    FDataSetPointInstruments.Close;
    FDataSetInstrumentUnits.Close;
    FDataSetJournal.Close;
    FDataSet.Close;
    FDataSet.Fields.Clear;
    FDataSet.FieldDefs.Clear;
    FDataSetValues.Close;
    FDataSetValues.Fields.Clear;
    FDataSetValues.FieldDefs.Clear;

    with FDataSetParams do begin
      FilterGroups.Clear;
      SetFilterGroupsTo(FilterGroups,'MEASURE_TYPE_ID',foOr);
      SetFilterGroupsTo(FilterGroups,'PARAM_ID',foOr);
    end;
    FDataSetParams.Open;

    with FDataSetPoints do begin
      FilterGroups.Clear;
      FilterGroups.Add.Filters.Add('CONVERTER_NOT_OPERATION',fcEqual,0);
      SetFilterGroupsTo(FilterGroups,'ROUTE_ID',foOr);
      SetFilterGroupsTo(FilterGroups,'OBJECT_ID',foOr);
    end;
    FDataSetPoints.Open;

    with FDataSetCycles do begin
      FilterGroups.Clear;
      SetFilterGroupsTo(FilterGroups,'CYCLE_ID',foOr);
    end;
    FDataSetCycles.Open;

    with FDataSetRoutes do begin
      FilterGroups.Clear;
      SetFilterGroupsTo(FilterGroups,'MEASURE_TYPE_ID',foOr);
      SetFilterGroupsTo(FilterGroups,'ROUTE_ID',foOr);
    end;
    FDataSetRoutes.Open;

    with FDataSetPointInstruments do begin
      FilterGroups.Clear;
      SetDataSetTo(FDataSetParams,FilterGroups,'PARAM_ID',foOr);
      SetDataSetTo(FDataSetPoints,FilterGroups,'POINT_ID',foOr);
    end;
    FDataSetPointInstruments.Open;

    with FDataSetInstrumentUnits do begin
      FilterGroups.Clear;
    end;
    FDataSetInstrumentUnits.Open;

    with FDataSetJournal do begin
      FilterGroups.Clear;
      SetFilterGroupsTo(FilterGroups,'CYCLE_ID',foOr);
      SetDataSetTo(FDataSetParams,FilterGroups,'PARAM_ID',foOr);
      SetDataSetTo(FDataSetPoints,FilterGroups,'POINT_ID',foOr);
      FilterGroups.Add.Filters.Add('DATE_OBSERVATION',fcEqualGreater,GetDateBegin);
      FilterGroups.Add.Filters.Add('DATE_OBSERVATION',fcEqualLess,GetDateEnd);
      FilterGroups.Add.Filters.Add('PARENT_ID',fcIsNull,NULL);
    end;
    FDataSetJournal.Open;

    if FDataSetParams.Active and
       FDataSetPoints.Active and
       FDataSetCycles.Active and
       FDataSetRoutes.Active and
       FDataSetPointInstruments.Active and
       FDataSetInstrumentUnits.Active and
       FDataSetJournal.Active then begin

      with FDataSet do begin
        CreateField('IS_CHANGE',ftInteger);
        CreateFieldBySource('JOURNAL_NUM',FDataSetJournal);
        CreateFieldBySource('NOTE',FDataSetJournal);
        CreateFieldBySource('GROUP_ID',FDataSetJournal);
        CreateFieldBySource('CYCLE_ID',FDataSetJournal);
        CreateFieldBySource('POINT_ID',FDataSetJournal);
        CreateFieldBySource('POINT_PRIORITY',FDataSetPoints,false,'PRIORITY');
        CreateFieldBySource('ROUTE_PRIORITY',FDataSetRoutes,false,'PRIORITY');
        CreateFieldBySource('POINT_NAME',FDataSetJournal).OnSetText:=PointNameFieldSetText;
        with CreateFieldBySource('DATE_OBSERVATION',FDataSetJournal) do begin
          EditMask:=SDateMask;
          ValidChars:=CDateValidChars;
          OnSetText:=DateObservationFieldSetText;
        end;
        CreateFieldBySource('WHO_ENTER',FDataSetJournal);
        CreateFieldBySource('DATE_ENTER',FDataSetJournal);
        CreateFieldBySource('WHO_CONFIRM',FDataSetJournal);
        CreateFieldBySource('DATE_CONFIRM',FDataSetJournal);

        FSelectDefs.Add('POINT_NAME','������������� �����',50);
        FSelectDefs.Add('DATE_OBSERVATION','���� ���������',70);

        CreateFieldBySource('IS_BASE',FDataSetJournal);
        FSelectDefs.AddDrawRadio('IS_BASE_EX','�������','IS_BASE',30,true);
        FSelectDefs.Find('IS_BASE').Field:=FindField('IS_BASE');
        CreateField('IS_CONFIRM',ftInteger).FieldKind:=fkCalculated;
        FSelectDefs.AddCalcInvisible('IS_CONFIRM',GetConfirmProc,ftInteger).Field:=FindField('IS_CONFIRM');
        FSelectDefs.AddDrawCheck('IS_CONFIRM_EX','����������','IS_CONFIRM',30);

        CreateDataSet;
      end;

      with FDataSetValues do begin
        CreateFieldBySource('GROUP_ID',FDataSetJournal);
        CreateFieldBySource('JOURNAL_FIELD_ID',FDataSetJournal);
        CreateFieldBySource('PARAM_ID',FDataSetJournal);
        CreateFieldBySource('PARAM_FORMAT',FDataSetParams);
        CreateFieldBySource('PARAM_NAME',FDataSetJournal);
        FSelectDefsValues.Add('PARAM_NAME','��������',160);

        CreateFieldBySource('INSTRUMENT_ID',FDataSetJournal);
        CreateFieldBySource('INSTRUMENT_NAME',FDataSetJournal).OnSetText:=InstrumentNameFieldSetText;
        FSelectDefsValues.Add('INSTRUMENT_NAME','������',100);
        CreateFieldBySource('MEASURE_UNIT_ID',FDataSetJournal);
        CreateFieldBySource('MEASURE_UNIT_NAME',FDataSetJournal).OnSetText:=MeasureNameFieldSetText;
        FSelectDefsValues.Add('MEASURE_UNIT_NAME','������� ���������',50);

        with CreateFieldBySource('VALUE',FDataSetJournal) do begin
          if DecimalSeparator<>'.' then
             ValidChars:=ValidChars+['.']
          else ValidChars:=ValidChars+[','];
          OnSetText:=ParamValueFieldSetText;
          OnGetText:=ParamValueFieldGetText;
        end;
        FSelectDefsValues.Add('VALUE','��������',100);

        CreateFieldBySource('IS_CHECK',FDataSetJournal);

        CreateDataSet;
      end;

      Result:=FDataSet.Active and FDataSetValues.Active;
    end;
  end;

  function CheckRestrictIsBase(CycleId,PointId: Variant): Boolean;
  var
    Str: TStringList;
    ValueIsNull: Boolean;
    NotIsBase: Boolean;
    GroupId: Variant;
    OldGroupId: Variant;
    Counter: Integer;
    FlagFirst: Boolean;
  begin
    Result:=true;
    if DSRestrictIsBase.Active then begin
      Str:=TStringList.Create;
      DSRestrictIsBase.BeginUpdate(false);
      try
        ValueIsNull:=true;
        NotIsBase:=true;
        OldGroupId:=Null;
        Counter:=0;
        FlagFirst:=true;
        Str.Add(Format('CYCLE_ID=%s',[QuotedStr(VarToStrDef(CycleId,''))]));
        Str.Add(Format('POINT_ID=%s',[QuotedStr(VarToStrDef(PointId,''))]));
        DSRestrictIsBase.Filter:=GetFilterString(Str,'AND');
        DSRestrictIsBase.Filtered:=true;
        DSRestrictIsBase.First;
        while not DSRestrictIsBase.Eof do begin
          GroupId:=DSRestrictIsBase.FieldByName('GROUP_ID').Value;
          if FlagFirst or (OldGroupId=GroupId) then begin
            Inc(Counter);
            FlagFirst:=false;
          end else begin
            if Counter<>FDataSetParams.RecordCount then begin
              Result:=true;
              Break;
            end else begin
              Result:=ValueIsNull and NotIsBase;
              if not Result then
                Break;
            end;
          end;
          ValueIsNull:=ValueIsNull and VarIsNull(DSRestrictIsBase.FieldByName('VALUE').Value);
          NotIsBase:=NotIsBase and not Boolean(DSRestrictIsBase.FieldByName('IS_BASE').AsInteger);
          OldGroupId:=GroupId;
          DSRestrictIsBase.Next;
        end;
        if Counter<>FDataSetParams.RecordCount then begin
          Result:=true;
        end else begin
          Result:=ValueIsNull and NotIsBase;
        end;
      finally
        DSRestrictIsBase.EndUpdate(false);
        Str.Free;
      end;
    end;
  end;
  
  procedure LoadEmptyData;
  var
    CycleId: Variant;
    PointId: Variant;
    Group: TSgtsGetRecordsConfigFilterGroup;
    Filter: TSgtsGetRecordsConfigFilter;
    i,j: Integer;
    Year,Month: Word;
    Day,DayCount: Word;
    TempDate: Variant;
    D1, D2: TDate;
  begin
    FNewRecordMode:=rmFillEmpty;
    D1:=GetDateBegin;
    D2:=GetDateEnd;
    for i:=0 to FilterGroups.Count-1 do begin
      Group:=FilterGroups.Items[i];
      for j:=0 to Group.Filters.Count-1 do begin
        Filter:=Group.Filters.Items[j];
        if AnsiSameText(Filter.FieldName,'CYCLE_ID') then begin
          CycleId:=Filter.Value;
          if FDataSetCycles.Locate('CYCLE_ID',CycleId) then begin
            Year:=FDataSetCycles.FieldByName('CYCLE_YEAR').Value;
            Month:=FDataSetCycles.FieldByName('CYCLE_MONTH').Value+1;
            DayCount:=DaysInAMonth(Year,Month);
            CoreIntf.MainForm.Progress(0,DayCount,0);
            try
              for Day:=1 to DayCount do begin
                TempDate:=EncodeDate(Year,Month,Day);
                if (D1<=TempDate) and (TempDate<=D2) then begin
                  FDataSetPoints.First;
                  while not FDataSetPoints.Eof do begin
                    PointId:=FDataSetPoints.FieldByName('POINT_ID').Value;
                    if CheckRestrictIsBase(CycleId,PointId) and
                       not FDataSet.FindKey([CycleId,TempDate,PointId]) then begin
                      FDataSet.Append;
                      FDataSet.FieldByName('CYCLE_ID').Value:=CycleId;
                      FDataSet.FieldByName('POINT_ID').Value:=PointId;
                      FDataSet.FieldByName('POINT_PRIORITY').Value:=FDataSetPoints.FieldByName('PRIORITY').Value;
                      if FDataSetRoutes.Locate('ROUTE_ID',FDataSetPoints.FieldByName('ROUTE_ID').Value) then
                        FDataSet.FieldByName('ROUTE_PRIORITY').Value:=FDataSetRoutes.FieldByName('PRIORITY').Value;
                      FDataSet.FieldByName('POINT_NAME').Value:=FDataSetPoints.FieldByName('POINT_NAME').Value;
                      FDataSet.FieldByName('DATE_OBSERVATION').Value:=TempDate;
                      if RestrictIsBase then
                        FDataSet.FieldByName('IS_BASE').AsInteger:=1;
                      FillDefaultInstruments(PointId,FDataSet.FieldByName('GROUP_ID').Value,true);
                      FDataSet.Post;
                    end;
                    FDataSetPoints.Next;
                  end;
                end else
                  Sleep(10);
                CoreIntf.MainForm.Progress(0,DayCount,Day);
              end;
            finally
              CoreIntf.MainForm.Progress(0,0,0);
            end;  
          end;
        end;
      end;
    end;  
  end;

  procedure LoadRealData;
  var
    GroupId,OldGroupId: Variant;
    ParamId: Variant;

    procedure SetEmptyFields;
    begin
      FDataSetParams.First;
      while not FDataSetParams.Eof do begin
        if not FDataSetValues.Locate('GROUP_ID;PARAM_ID',VarArrayOf([GroupId,FDataSetParams.FieldByName('PARAM_ID').Value]),
                                     [loCaseInsensitive]) then begin
          FDataSetValues.Append;
          FDataSetValues.FieldByName('GROUP_ID').Value:=GroupId;
          FDataSetValues.FieldByName('PARAM_ID').Value:=FDataSetParams.FieldByName('PARAM_ID').Value;
          FDataSetValues.FieldByName('PARAM_FORMAT').Value:=FDataSetParams.FieldByName('PARAM_FORMAT').Value;
          FDataSetValues.FieldByName('PARAM_NAME').Value:=FDataSetParams.FieldByName('PARAM_NAME').Value;
          FDataSetValues.FieldByName('IS_CHECK').Value:=Integer(true);
          FDataSetValues.Post;
        end;
        FDataSetParams.Next;
      end;
    end;

    procedure SetOtherFields;
    begin
      if FDataSetValues.Locate('GROUP_ID;PARAM_ID',VarArrayOf([GroupId,ParamId]),[loCaseInsensitive]) then begin
        FDataSetValues.Edit;
        FDataSetValues.FieldByName('JOURNAL_FIELD_ID').Value:=FDataSetJournal.FieldByName('JOURNAL_FIELD_ID').Value;
        FDataSetValues.FieldByName('INSTRUMENT_ID').Value:=FDataSetJournal.FieldByName('INSTRUMENT_ID').Value;
        FDataSetValues.FieldByName('INSTRUMENT_NAME').Value:=FDataSetJournal.FieldByName('INSTRUMENT_NAME').Value;
        FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value:=FDataSetJournal.FieldByName('MEASURE_UNIT_ID').Value;
        FDataSetValues.FieldByName('MEASURE_UNIT_NAME').Value:=FDataSetJournal.FieldByName('MEASURE_UNIT_NAME').Value;
        FDataSetValues.FieldByName('VALUE').Value:=FDataSetJournal.FieldByName('VALUE').Value;
        FDataSetValues.FieldByName('IS_CHECK').Value:=FDataSetJournal.FieldByName('IS_CHECK').Value;
        FDataSetValues.Post;
      end;
    end;

  var
    Position: Integer;
    CycleId: Variant;
    PointId: Variant;
  begin
    Position:=0;
    CoreIntf.MainForm.Progress(0,FDataSetJournal.RecordCount,0);
    try
      OldGroupId:=Null;
      FDataSetJournal.First;
      while not FDataSetJournal.Eof do begin
        GroupId:=FDataSetJournal.FieldByName('GROUP_ID').Value;
        ParamId:=FDataSetJournal.FieldByName('PARAM_ID').Value;
        CycleId:=FDataSetJournal.FieldByName('CYCLE_ID').Value;
        PointId:=FDataSetJournal.FieldByName('POINT_ID').Value;
        if CheckRestrictIsBase(CycleId,PointId) then begin
          if OldGroupId<>GroupId then begin
            FDataSet.Append;
            FDataSet.FieldByName('IS_CHANGE').Value:=Boolean(false);
            FDataSet.FieldByName('JOURNAL_NUM').Value:=FDataSetJournal.FieldByName('JOURNAL_NUM').Value;
            FDataSet.FieldByName('NOTE').Value:=FDataSetJournal.FieldByName('NOTE').Value;
            FDataSet.FieldByName('GROUP_ID').Value:=GroupId;
            FDataSet.FieldByName('CYCLE_ID').Value:=CycleId;
            FDataSet.FieldByName('POINT_ID').Value:=PointId;
            if FDataSetPoints.Locate('POINT_ID',PointId) then begin
              FDataSet.FieldByName('POINT_PRIORITY').Value:=FDataSetPoints.FieldByName('PRIORITY').Value;
              if FDataSetRoutes.Locate('ROUTE_ID',FDataSetPoints.FieldByName('ROUTE_ID').Value) then
                FDataSet.FieldByName('ROUTE_PRIORITY').Value:=FDataSetRoutes.FieldByName('PRIORITY').Value;
            end;
            FDataSet.FieldByName('POINT_NAME').Value:=FDataSetJournal.FieldByName('POINT_NAME').Value;
            FDataSet.FieldByName('DATE_OBSERVATION').Value:=FDataSetJournal.FieldByName('DATE_OBSERVATION').Value;
            FDataSet.FieldByName('WHO_ENTER').Value:=FDataSetJournal.FieldByName('WHO_ENTER').Value;
            FDataSet.FieldByName('DATE_ENTER').Value:=FDataSetJournal.FieldByName('DATE_ENTER').Value;
            FDataSet.FieldByName('IS_BASE').Value:=FDataSetJournal.FieldByName('IS_BASE').Value;
            FDataSet.FieldByName('WHO_CONFIRM').Value:=FDataSetJournal.FieldByName('WHO_CONFIRM').Value;
            FDataSet.FieldByName('DATE_CONFIRM').Value:=FDataSetJournal.FieldByName('DATE_CONFIRM').Value;
            FDataSet.Post;
            SetEmptyFields;
          end;
          SetOtherFields;
          OldGroupId:=GroupId;
        end;  
        Inc(Position);
        CoreIntf.MainForm.Progress(0,FDataSetJournal.RecordCount,Position);
        FDataSetJournal.Next;
      end;
    finally
      CoreIntf.MainForm.Progress(0,0,0);
    end;
  end;

var
  OldMasterFields: String;
  OldIndexName: String;
begin
  if CanRefresh then begin
    DSRestrictIsBase:=TSgtsDatabaseCDS.Create(CoreIntf);
    FDataSet.BeginUpdate;
    FDataSetValues.BeginUpdate;
    OldMasterFields:=FDataSetValues.MasterFields;
    FDataSetValues.MasterFields:='';
    FDataSetValues.MasterSource:=nil;
    OldIndexName:=FDataSet.IndexName;
    FDataSet.IndexName:='IDX_CYCLE_DATE_POINT';
    FNewRecordMode:=rmFill;
    try
      FGrid.Columns.Clear;
      FGridValues.Columns.Clear;
      FSelectDefs.Clear;
      FSelectDefsValues.Clear;
      if CreateData then begin
        CreateGridColumnsBySelectDefs(FGrid,FSelectDefs);
        CreateGridColumnsBySelectDefs(FGridValues,FSelectDefsValues);
        if IsEdit and RestrictIsBase then begin
          DSRestrictIsBase.ProviderName:=SProviderSelectJournalFields;
          with DSRestrictIsBase do begin
            with SelectDefs do begin
              AddInvisible('CYCLE_ID');
              AddInvisible('POINT_ID');
              AddInvisible('PARAM_ID');
              AddInvisible('GROUP_ID');
              AddInvisible('VALUE');
              AddInvisible('IS_BASE');
            end;
            SetFilterGroupsTo(FilterGroups,'CYCLE_ID',foOr);
            SetDataSetTo(FDataSetParams,FilterGroups,'PARAM_ID',foOr);
            SetDataSetTo(FDataSetPoints,FilterGroups,'POINT_ID',foOr);
            FilterGroups.Add.Filters.Add('PARENT_ID',fcIsNull,NULL);
            Orders.CopyFrom(FDataSetJournal.Orders);
            Open;
          end;
        end;
        LoadRealData;
        if IsEdit then
          LoadEmptyData;
        FGrid.AutoSizeColumns;
        FGrid.Hint:='�������� ������: '+MeasureTypeName+'  (��������� �������������)';
        FGridValues.AutoSizeColumns;
        SetColumnProperty(GetCurrentColumn(FGrid));
      end;
    finally
      GoBrowse(FGrid,false);
      GoBrowse(FGridValues,false);
      FNewRecordMode:=rmInput;
      FDataSet.IndexName:=OldIndexName;
      FDataSetValues.EndUpdate(true);
      FDataSet.EndUpdate(true);
      FDataSetValues.MasterFields:=OldMasterFields;
      FDataSetValues.MasterSource:=DataSource;
      FDataSet.First;
      FDataSetValues.First;
      FGrid.UpdateRowNumber;
      FGridValues.UpdateRowNumber;
      DSRestrictIsBase.Free;
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetCurrentColumn(AGrid: TSgtsFunSourceDbGrid): TColumn;
var
  Index: Integer;
begin
  Result:=nil;
  Index:=AGrid.SelectedIndex;
  if Index in [0..AGrid.Columns.Count-1] then
    Result:=AGrid.Columns[Index];
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GoBrowse(AGrid: TSgtsFunSourceDbGrid; ChangeMode: Boolean);
begin
  if ChangeMode then begin
    if AGrid=FGrid then
      with FDataSet do begin
        if State in [dsInsert,dsEdit] then
          Post;
      end;
    if AGrid=FGridValues then
      with FDataSetValues do begin
        if State in [dsInsert,dsEdit] then
          Post;
      end;
  end;
  AGrid.Options:=AGrid.Options-[dgEditing];
  AGrid.EditorMode:=false;
  DBEditJournalNum.ReadOnly:=true;
  DBMemoNote.ReadOnly:=true;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.PointNameFieldSetText(Sender: TField; const Text: string);
var
  Column: TColumn;
  Index: Integer;
  Obj: TSgtsPointInfo;
begin
  Column:=GetCurrentColumn(FGrid);
  if Assigned(Column) and
     Assigned(FGrid.InplaceEdit) then begin
    Index:=FGrid.InplaceEdit.PickList.ItemIndex;
    if Index in [0..Column.PickList.Count-1] then begin
      Obj:=TSgtsPointInfo(Column.PickList.Objects[Index]);
      Sender.Value:=Obj.PointName;
      FDataSet.FieldByName('POINT_ID').Value:=Obj.PointId;
      if FDataSetPoints.Locate('POINT_ID',Obj.PointId) then begin
        FDataSet.FieldByName('POINT_PRIORITY').Value:=FDataSetPoints.FieldByName('PRIORITY').Value;
        if FDataSetRoutes.Locate('ROUTE_ID',FDataSetPoints.FieldByName('ROUTE_ID').Value) then
          FDataSet.FieldByName('ROUTE_PRIORITY').Value:=FDataSetRoutes.FieldByName('PRIORITY').Value;
      end;
//      FillDefaultInstruments(Obj.PointId,FDataSet.FieldByName('GROUP_ID').Value,false);
      FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
      FChangePresent:=true;
      GoBrowse(FGrid,false);
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DateObservationFieldSetText(Sender: TField; const Text: string);
var
  NewDate: TDate;
begin
  NewDate:=StrToDateDef(Text,0.0);
  if NewDate<>0.0 then begin
    try
      Sender.Value:=NewDate;
      FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
      FChangePresent:=true;
      GoBrowse(FGrid,false);
    except
      On E: Exception do
        ShowError(E.Message);
    end;  
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ParamValueFieldGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var
  ParamFormat: String;
  Value: Variant;
begin
  Value:=Sender.Value;
  if not VarIsNull(Value) then begin
    ParamFormat:=FDataSetValues.FieldByName('PARAM_FORMAT').AsString;
    if DisplayText then begin
      if Trim(ParamFormat)<>'' then
        Text:=FormatFloat(ParamFormat,Sender.AsFloat)
      else
        Text:=Sender.AsString;
    end else
      Text:=Sender.AsString;
  end else
    Text:=Sender.AsString;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ParamValueFieldSetText(Sender: TField; const Text: string);
var
  ParamType: TSgtsRbkParamType;
  NewText: String;
  Value: Variant;
begin
  Sender.OnSetText:=nil;
  try
    if DecimalSeparator<>'.' then
      NewText:=ChangeChar(Text,'.',DecimalSeparator)
    else NewText:=ChangeChar(Text,',',DecimalSeparator);
    NewText:=DeleteDuplicate(NewText,DecimalSeparator);
    NewText:=DeleteToOne(NewText,DecimalSeparator);
    Sender.AsString:=NewText;
    ParamType:=GetParamType;
    if ParamType=ptIntroduced then begin
      Calculate;
      Value:=Sender.Value;
      if Checking(Value) then begin
        FDataSetValues.Edit;
        Sender.Value:=Value;
        FDataSetValues.FieldByName('IS_CHECK').Value:=Integer(true);
        FDataSet.Edit;
        FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
        FDataSet.Post;
        FChangePresent:=true;
      end else begin
        FDataSetValues.Edit;
        Sender.Value:=Value;
        FDataSetValues.FieldByName('IS_CHECK').Value:=Integer(false);
        FDataSet.Edit;
        FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
        FDataSet.Post;
        FChangePresent:=true;
      end;
    end;
    GoBrowse(FGridValues,false);
  finally
    Sender.OnSetText:=ParamValueFieldSetText;
  end;  
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.InstrumentNameFieldSetText(Sender: TField; const Text: string);
var
  Column: TColumn;
  Index: Integer;
  Obj: TSgtsInstrumentInfo;
  Units: TStringList;
  ObjUnit: TSgtsMeasureUnitInfo;
begin
  Column:=GetCurrentColumn(FGridValues);
  if Assigned(Column) and
     Assigned(FGridValues.InplaceEdit) then begin
    Index:=FGridValues.InplaceEdit.PickList.ItemIndex;
    if Index in [0..Column.PickList.Count-1] then begin
      Obj:=TSgtsInstrumentInfo(Column.PickList.Objects[Index]);
      Sender.Value:=Obj.InstrumentName;
      FDataSetValues.FieldByName('INSTRUMENT_ID').Value:=Obj.InstrumentId;

      Units:=TStringList.Create;
      try
        FillMeasureUnits(Units,true,Obj.InstrumentId);
        if Units.Count>0 then begin
          ObjUnit:=TSgtsMeasureUnitInfo(Units.Objects[0]);
          FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value:=ObjUnit.MeasureUnitId;
          FDataSetValues.FieldByName('MEASURE_UNIT_NAME').Value:=ObjUnit.MeasureUnitName;
        end else begin
          FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value:=Null;
          FDataSetValues.FieldByName('MEASURE_UNIT_NAME').Value:=Null;
        end;
      finally
        Units.Free;
      end;

      FDataSet.Edit;
      FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
      FChangePresent:=true;
      FDataSet.Post;
      GoBrowse(FGridValues,false);
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.MeasureNameFieldSetText(Sender: TField; const Text: string);
var
  Column: TColumn;
  Index: Integer;
  Obj: TSgtsMeasureUnitInfo;
begin
  Column:=GetCurrentColumn(FGridValues);
  if Assigned(Column) and
     Assigned(FGridValues.InplaceEdit) then begin
    Index:=FGridValues.InplaceEdit.PickList.ItemIndex;
    if Index in [0..Column.PickList.Count-1] then begin
      Obj:=TSgtsMeasureUnitInfo(Column.PickList.Objects[Index]);
      Sender.Value:=Obj.MeasureUnitName;
      FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value:=Obj.MeasureUnitId;
      FDataSet.Edit;
      FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
      FChangePresent:=true;
      FDataSet.Post;
      GoBrowse(FGridValues,false);
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetColumnType(Column: TColumn): TSgtsFunSourceDataMeasureDetailColumnType;
begin
  Result:=ctUnknown;
  if Assigned(Column) then begin
    if Pos('POINT_NAME',Column.FieldName)>0 then Result:=ctPointName;
    if Pos('DATE_OBSERVATION',Column.FieldName)>0 then Result:=ctDate;
    if Pos('PARAM_NAME',Column.FieldName)>0 then Result:=ctParamName;
    if Pos('VALUE',Column.FieldName)>0 then Result:=ctParamValue;
    if Pos('INSTRUMENT_NAME',Column.FieldName)>0 then Result:=ctParamInstrument;
    if Pos('MEASURE_UNIT_NAME',Column.FieldName)>0 then Result:=ctParamUnit;
    if Pos('IS_BASE_EX',Column.FieldName)>0 then Result:=ctBase;
    if Pos('IS_CONFIRM_EX',Column.FieldName)>0 then Result:=ctConfirm;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.FillPoints(Strings: TStrings);
var
  Obj: TSgtsPointInfo;
begin
  if FDataSetPoints.Active then begin
    Strings.BeginUpdate;
    try
      FDataSetPoints.First;
      while not FDataSetPoints.Eof do begin
        Obj:=TSgtsPointInfo.Create;
        Obj.PointId:=FDataSetPoints.FieldByName('POINT_ID').Value;
        Obj.PointName:=FDataSetPoints.FieldByName('POINT_NAME').AsString;
        Strings.AddObject(Obj.PointName,Obj);
        FDataSetPoints.Next;
      end;
    finally
      Strings.EndUpdate;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.FillInstruments(Strings: TStrings);

  function InstrumentFind(AInstrumentId: Variant): Boolean;
  var
    i: Integer;
    Obj: TSgtsInstrumentInfo;
  begin
    Result:=false;
    for i:=0 to Strings.Count-1 do begin
      Obj:=TSgtsInstrumentInfo(Strings.Objects[i]);
      if Obj.InstrumentId=AInstrumentId then begin
        Result:=true;
        exit;
      end;
    end;
  end;

var
  DS: TSgtsDatabaseCDS;
  Obj: TSgtsInstrumentInfo;
  ParamId: Variant;
  PointId: Variant;
begin
  if FDataSetValues.Active and
     not FDataSetValues.IsEmpty then begin
    ParamId:=FDataSetValues.FieldByName('PARAM_ID').Value;
    PointId:=FDataSet.FieldByName('POINT_ID').Value;
    if not VarIsNull(ParamId) and
       not VarIsNull(PointId) then begin

      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      Strings.BeginUpdate;
      try

        DS.ProviderName:=SProviderSelectPointInstruments;
        with DS.SelectDefs do begin
          Clear;
          AddInvisible('INSTRUMENT_ID');
          AddInvisible('INSTRUMENT_NAME');
        end;
        DS.FilterGroups.Clear;
        DS.FilterGroups.Add.Filters.Add('POINT_ID',fcEqual,PointId);
        DS.FilterGroups.Add.Filters.Add('PARAM_ID',fcEqual,ParamId);
        DS.Orders.Clear;
        DS.Orders.Add('PRIORITY',otAsc);
        DS.Open;
        if DS.Active and not DS.IsEmpty then begin
          DS.First;
          while not DS.Eof do begin
            if not InstrumentFind(DS.FieldByName('INSTRUMENT_ID').Value) then begin
              Obj:=TSgtsInstrumentInfo.Create;
              Obj.InstrumentId:=DS.FieldByName('INSTRUMENT_ID').Value;
              Obj.InstrumentName:=DS.FieldByName('INSTRUMENT_NAME').AsString;
              Strings.AddObject(Obj.InstrumentName,Obj);
            end;  
            DS.Next;
          end;
        end;

        DS.Close;
        
        DS.ProviderName:=SProviderSelectParamInstruments;
        with DS.SelectDefs do begin
          Clear;
          AddInvisible('INSTRUMENT_ID');
          AddInvisible('INSTRUMENT_NAME');
        end;
        DS.FilterGroups.Clear;
        DS.FilterGroups.Add.Filters.Add('PARAM_ID',fcEqual,ParamId);
        DS.Orders.Clear;
        DS.Orders.Add('PRIORITY',otAsc);
        DS.Open;
        if DS.Active and not DS.IsEmpty then begin
          DS.First;
          while not DS.Eof do begin
            Obj:=TSgtsInstrumentInfo.Create;
            Obj.InstrumentId:=DS.FieldByName('INSTRUMENT_ID').Value;
            Obj.InstrumentName:=DS.FieldByName('INSTRUMENT_NAME').AsString;
            Strings.AddObject(Obj.InstrumentName,Obj);
            DS.Next;
          end;
        end;

      finally
        Strings.EndUpdate;
        DS.Free;
      end;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.FillMeasureUnits(Strings: TStrings; ByInstrumentId: Boolean; InstrumentId: Variant);
var
  DS: TSgtsDatabaseCDS;
  Obj: TSgtsMeasureUnitInfo;
  AInstrumentId: Variant;
begin
  if FDataSetValues.Active and
     not FDataSetValues.IsEmpty then begin
    if ByInstrumentId then begin
      AInstrumentId:=InstrumentId;
    end else begin
      AInstrumentId:=FDataSetValues.FieldByName('INSTRUMENT_ID').Value;
    end;  
    if not VarIsNull(AInstrumentId) then begin
      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      Strings.BeginUpdate;
      try
        DS.ProviderName:=SProviderSelectInstrumentUnits;
        with DS.SelectDefs do begin
          AddInvisible('MEASURE_UNIT_ID');
          AddInvisible('MEASURE_UNIT_NAME');
        end;
        DS.FilterGroups.Add.Filters.Add('INSTRUMENT_ID',fcEqual,AInstrumentId);
        DS.Orders.Add('PRIORITY',otAsc);
        DS.Open;
        if DS.Active and not DS.IsEmpty then begin
          DS.First;
          while not DS.Eof do begin
            Obj:=TSgtsMeasureUnitInfo.Create;
            Obj.MeasureUnitId:=DS.FieldByName('MEASURE_UNIT_ID').Value;
            Obj.MeasureUnitName:=DS.FieldByName('MEASURE_UNIT_NAME').AsString;
            Strings.AddObject(Obj.MeasureUnitName,Obj);
            DS.Next;
          end;
        end;
      finally
        Strings.EndUpdate;
        DS.Free;
      end;
    end;  
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.SetColumnProperty(Column: TColumn);
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
  AGrid: TSgtsFunSourceDbGrid;
begin
  if Assigned(Column) then begin
    FGrid.PopupMenu:=DefaultPopupMenu;
    ClearStrings(Column.PickList);
    Column.ButtonStyle:=cbsNone;
    if FGridValues.Focused then
      AGrid:=FGridValues
    else AGrid:=FGrid;
    GoBrowse(AGrid,true);
    ColumnType:=GetColumnType(Column);
    case ColumnType of
      ctPointName: begin
        Column.ButtonStyle:=cbsAuto;
        FillPoints(Column.PickList);
      end;
      ctParamInstrument: begin
        Column.ButtonStyle:=cbsAuto;
        FillInstruments(Column.PickList);
      end;
      ctParamUnit: begin
        Column.ButtonStyle:=cbsAuto;
        FillMeasureUnits(Column.PickList,false,Null);
      end;
      ctParamValue: begin
      end;
      ctConfirm: begin
        FGrid.PopupMenu:=PopupMenuConfirm;
      end;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GridColEnter(Sender: TObject);
begin
  if Sender is TSgtsFunSourceDbGrid then
    SetColumnProperty(GetCurrentColumn(TSgtsFunSourceDbGrid(Sender)));
  UpdateButtons;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GridDblClick(Sender: TObject);
begin
  Update;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GridCellClick(Column: TColumn);
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
begin
  ColumnType:=GetColumnType(Column);
  case ColumnType of
    ctBase: SetIsBase;
    ctConfirm: Confirm;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DataSetAfterScroll(DataSet: TDataSet);
begin
  SetColumnProperty(GetCurrentColumn(FGrid));
  SetAdditionalInfo;
  UpdateButtons;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DataSetValuesAfterScroll(DataSet: TDataSet);
begin
  GridColEnter(FGridValues);
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DataSetAfterPost(DataSet: TDataSet);
begin
  if DataSet=FDataSet then
    GoBrowse(FGrid,false)
  else begin
    GoBrowse(FGridValues,false);
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DataSetValuesBeforePost(DataSet: TDataSet);
begin
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DataSetNewRecord(DataSet: TDataSet);
var
  GroupId: Variant;

  function GetIsBaseDefault: Integer;
  var
    MeasureTypeId: Variant;
  begin
    Result:=Integer(false);
    MeasureTypeId:=GetMeasureTypeIdByFilter;
    if not VarIsNull(MeasureTypeId) and
       FDataSetRoutes.Active and
       not FDataSetRoutes.IsEmpty then begin
      if FDataSetRoutes.Locate('MEASURE_TYPE_ID',MeasureTypeId) then begin
        Result:=FDataSetRoutes.FieldByName('IS_BASE').AsInteger;
      end;
    end;
  end;

var
  FOldAfterScroll: TDataSetNotifyEvent;
begin
  case FNewRecordMode of
    rmCancel: FDataSet.Cancel;
    rmInput: begin
      FOldAfterScroll:=FDataSetValues.AfterScroll;
      FDataSetValues.AfterScroll:=nil;
      try
        FChangePresent:=true;
        GroupId:=CreateUniqueId;
        FDataSet.FieldByName('IS_CHANGE').Value:=Integer(True);
        FDataSet.FieldByName('GROUP_ID').Value:=GroupId;
        FDataSet.FieldByName('CYCLE_ID').Value:=GetValueByCounter('CYCLE_ID',0);
        FDataSet.FieldByName('DATE_OBSERVATION').Value:=DateOf(Date);
        FDataSet.FieldByName('WHO_ENTER').Value:=Database.PersonnelId;
        FDataSet.FieldByName('DATE_ENTER').Value:=DateOf(Date);
        FDataSet.FieldByName('IS_BASE').Value:=GetIsBaseDefault;
      finally
        FDataSetValues.AfterScroll:=FOldAfterScroll;
      end;
    end;
    rmFillEmpty: begin
      FOldAfterScroll:=FDataSetValues.AfterScroll;
      FDataSetValues.AfterScroll:=nil;
      try
        GroupId:=CreateUniqueId;
        FDataSet.FieldByName('IS_CHANGE').Value:=Integer(False);
        FDataSet.FieldByName('JOURNAL_NUM').Value:=JournalNum;
        FDataSet.FieldByName('GROUP_ID').Value:=GroupId;
        FDataSet.FieldByName('WHO_ENTER').Value:=Database.PersonnelId;
        FDataSet.FieldByName('DATE_ENTER').Value:=DateOf(Date);
        FDataSet.FieldByName('IS_BASE').Value:=GetIsBaseDefault;
      finally
        FDataSetValues.AfterScroll:=FOldAfterScroll;
      end;
    end;
  end;
end;


function TSgtsFunSourceDataMeasureDetailFrame.DataSetParamsLocate(Counter: Integer): Boolean;
var
  i: Integer;
begin
  Result:=false;
  if FDataSetParams.Active then begin
    i:=0;
    FDataSetParams.First;
    while not FDataSetParams.Eof do begin
      if i=Counter then begin
        Result:=true;
        exit;
      end;
      Inc(i);
      FDataSetParams.Next;
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetParamType: TSgtsRbkParamType;
begin
  Result:=ptIntegral;
  if DataSetParamsLocate(FDataSetValues.RecNo-1) then begin
    Result:=TSgtsRbkParamType(FDataSetParams.FieldByName('PARAM_TYPE').AsInteger);
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetConfirmProc(Def: TSgtsSelectDef): Variant;
begin
  Result:=0;
  if not VarIsNull(FDataSet.FieldByName('WHO_CONFIRM').Value) then
    Result:=1;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Calculate;

  function GetFieldNameByCounter(FieldName: String; Counter: Integer): String;
  begin
    Result:=Format('%s_%d',[FieldName,Counter]); 
  end;

  procedure CalculateLocal(ProcName: String);
  var
    DS: TSgtsDatabaseCDS;
    Provider: TSgtsExecuteProvider;
    Counter: Integer;
    InstrumentId: Variant;
    MeasureUnitId: Variant;
    Def: TSgtsExecuteDef;
    S: String;
  begin
    DS:=TSgtsDatabaseCDS.Create(CoreIntf);
    Provider:=Database.ExecuteProviders.AddDefault(ProcName);
    try
      if Assigned(Provider) then begin
        DS.ProviderName:=ProcName;
        DS.StopException:=true;
        with DS.ExecuteDefs do begin
          AddValue('DATE_OBSERVATION',FDataSet.FieldByName('DATE_OBSERVATION').Value);
          AddValue('CYCLE_ID',FDataSet.FieldByName('CYCLE_ID').Value);
          AddValue('POINT_ID',FDataSet.FieldByName('POINT_ID').Value);
        end;
        Counter:=0;
        FDataSetValues.First;
        while not FDataSetValues.Eof do begin
          DS.ExecuteDefs.AddValue(GetFieldNameByCounter('PARAM_ID',Counter),FDataSetValues.FieldByName('PARAM_ID').Value);
          InstrumentId:=FDataSetValues.FieldByName('INSTRUMENT_ID').Value;
          if not VarIsNull(InstrumentId) then
            DS.ExecuteDefs.AddValue(GetFieldNameByCounter('INSTRUMENT_ID',Counter),InstrumentId);
          MeasureUnitId:=FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value;
          if not VarIsNull(MeasureUnitId) then
            DS.ExecuteDefs.AddValue(GetFieldNameByCounter('MEASURE_UNIT_ID',Counter),MeasureUnitId);
          DS.ExecuteDefs.AddValue(GetFieldNameByCounter('VALUE',Counter),FDataSetValues.FieldByName('VALUE').Value).ParamType:=ptInputOutput;

          Inc(Counter);
          FDataSetValues.Next;
        end;
        DS.Execute;
        Counter:=0;
        FDataSetValues.First;
        while not FDataSetValues.Eof do begin
          S:=GetFieldNameByCounter('VALUE',Counter);
          Def:=DS.ExecuteDefs.Find(S);
          if Assigned(Def) then begin
            FDataSetValues.Edit;
            FDataSetValues.FieldByName('VALUE').Value:=Def.Value;
          end;  
          Inc(Counter);
          FDataSetValues.Next;
        end;
      end;
    finally
      Database.ExecuteProviders.Remove(Provider);
      DS.Free;
    end;
  end;
  
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
  OldCursor: TCursor;
  B: TBookmark;
  ParamId: Variant;
  ProcName: String;
  DefaultValue: Variant;
begin
  if FDataSetValues.Active and
     not FDataSetValues.IsEmpty and
     IsEdit then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      ColumnType:=GetColumnType(GetCurrentColumn(FGridValues));
      if ColumnType=ctParamValue then begin
        FDataSetValues.DisableControls;
        B:=FDataSetValues.GetBookmark;
        try
          ParamId:=FDataSetValues.FieldByName('PARAM_ID').Value;
          if FDataSetParams.Locate('PARAM_ID',ParamId) then begin
            DefaultValue:=GetValueByCounter('DEFAULT_VALUE',FDataSetValues.RecNo-1);
            if VarIsNull(FDataSetValues.FieldByName('VALUE').Value) then begin
              FDataSetValues.Edit;
              FDataSetValues.FieldByName('VALUE').Value:=DefaultValue;
            end;
            ProcName:=FDataSetParams.FieldByName('ALGORITHM_PROC_NAME').AsString;
            if Trim(ProcName)<>'' then begin
              CalculateLocal(ProcName);
            end;
          end;
        finally
          if Assigned(B) and
             FDataSetValues.BookmarkValid(B) then begin
            FDataSetValues.GotoBookmark(B);
          end;
          FDataSetValues.EnableControls;
        end;
      end;
    finally
      Screen.Cursor:=OldCursor;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.BeforeRefresh;
begin
  FGrid.Visible:=false;
  FGridValues.Visible:=false;
  PanelPoints.Visible:=false;
  Splitter.Visible:=false;
  PanelValuesAndAdditional.Visible:=false;
  PanelStatus.Update;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.AfterRefresh;
begin
  FGrid.Visible:=true;
  FGridValues.Visible:=true;
  PanelPoints.Visible:=true;
  Splitter.Visible:=true;
  PanelValuesAndAdditional.Visible:=true;
  Splitter.Left:=PanelPoints.Left+1;
  if FGrid.CanFocus then
    FGrid.SetFocus;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetDataSet: TSgtsCDS;
begin
  Result:=FDataSet;
end;

function TSgtsFunSourceDataMeasureDetailFrame.Save: Boolean;
var
  APosition: Integer;
begin
  Result:=Inherited Save;
  if CanSave then begin
    CoreIntf.MainForm.Progress(0,FDataSet.RecordCount,0);
    GoBrowse(FGrid,true);
    FGrid.VisibleRowNumber:=false;
    GoBrowse(FGridValues,true);
    FGridValues.VisibleRowNumber:=false;
   // FDataSet.BeginUpdate(true);
    FDataSetValues.BeginUpdate(true);
    try
      APosition:=1;
      InProgress:=true;
      CancelProgress:=false;
      FDataSet.First;
      while not FDataSet.Eof do begin
        Application.ProcessMessages;
        if CancelProgress then
          break;
        if CheckRecord(true,true,false,false,true) then begin
          SaveRecord;
        end else begin
          Result:=false;
          Exit;
        end;
        CoreIntf.MainForm.Progress(0,FDataSet.RecordCount,APosition);
        Inc(APosition);
        FDataSet.Next;
      end;
      if not CancelProgress then begin
        FDataSet.First;
        FChangePresent:=false;
        Result:=True;
      end;
    finally
      InProgress:=false;
      FDataSetValues.EndUpdate(false);
   //   FDataSet.EndUpdate(true);
      FGrid.VisibleRowNumber:=true;
      FGridValues.VisibleRowNumber:=true;
      FGrid.UpdateRowNumber;
      FGridValues.UpdateRowNumber;
      UpdateButtons;
      CoreIntf.MainForm.Progress(0,0,0);
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.CanSave: Boolean;
begin
  Result:=FDataSet.Active and
          not FDataSet.IsEmpty and
          FDataSetValues.Active and
          not FDataSetValues.IsEmpty and
          FChangePresent;
end;

function TSgtsFunSourceDataMeasureDetailFrame.NextPresent(AGrid: TSgtsFunSourceDbGrid; Index: Integer;
                                                          ColumnTypes: TSgtsFunSourceDataMeasureDetailColumnTypes): Boolean;
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
  i: Integer;
begin
  Result:=false;
  if Index in [0..AGrid.Columns.Count-1] then
    for i:=Index to AGrid.Columns.Count-1 do begin
      ColumnType:=GetColumnType(AGrid.Columns[i]);
      if ColumnType in ColumnTypes then begin
        Result:=true;
        exit;
      end;
    end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.ParamIsConfirm: Boolean;
begin
  Result:=true;
  if DataSetParamsLocate(FDataSetValues.RecNo-1) then begin
    Result:=not Boolean(FDataSetParams.FieldByName('PARAM_IS_NOT_CONFIRM').AsInteger);
  end;
end;


function TSgtsFunSourceDataMeasureDetailFrame.CheckRecord(CheckChanges: Boolean; WithMessage: Boolean=true;
                                                          OnlyCurrent: Boolean=false; WithParam: Boolean=false;
                                                          WithEvent: Boolean=false): Boolean;
var
  Column: TColumn;
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;

  procedure ResultFalse(AGrid: TSgtsFunSourceDbGrid);
  begin
    if WithMessage then begin
      ShowError(Format(SNeedElementValue,[Column.Title.Caption]));
      AGrid.SetFocus;
      AGrid.SelectedIndex:=Column.Index;
    end;
    Result:=false;
  end;

  procedure ResultFalseEx(ParamName: String);
  var
    Ret: Integer;
  begin
    if WithMessage then begin
      Ret:=ShowQuestion(Format(SParamValueNotChecking,[ParamName]),mbNo);
      Result:=Ret<>mrNo;
      if not Result then begin
        FGridValues.SetFocus;
        FGridValues.SelectedIndex:=Column.Index;
      end;
    end else
      Result:=false;
  end;

  procedure CheckRecordLocal;
  var
    Flag: Boolean;
    i: Integer;
    FilterInstrumentId: Variant;
    FilterMeasureUnitId: Variant;
  begin
    Flag:=true;
    for i:=0 to FGridValues.Columns.Count-1 do begin
      Column:=FGridValues.Columns[i];
      ColumnType:=GetColumnType(Column);
      case ColumnType of
        ctParamInstrument: begin
          FilterInstrumentId:=GetInstrumentIdByFilter;
          if not VarIsNull(FilterInstrumentId) then
            if VarIsNull(FDataSetValues.FieldByName('INSTRUMENT_ID').Value) or
               (Trim(FDataSetValues.FieldByName('INSTRUMENT_NAME').AsString)='') then begin
              ResultFalse(FGridValues);
              Flag:=false;
              break;
            end;
        end;
        ctParamUnit: begin
          FilterMeasureUnitId:=GetMeasureUnitIdByFilter;
          if not VarIsNull(FilterMeasureUnitId) then
            if VarIsNull(FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value) or
               (Trim(FDataSetValues.FieldByName('MEASURE_UNIT_NAME').AsString)='') then begin
              ResultFalse(FGridValues);
              Flag:=false;
              break;
            end;
        end;
        ctParamValue: begin
          if WithParam then begin
            if ParamIsConfirm then
              if (GetParamType=ptIntroduced) and
                  VarIsNull(FDataSetValues.FieldByName('VALUE').Value) then begin
                ResultFalse(FGridValues);
                Flag:=false;
                break;
              end;
          end;
        end;
      end;
    end;

    if Flag then begin
      for i:=0 to FGridValues.Columns.Count-1 do begin
        Column:=FGridValues.Columns[i];
        ColumnType:=GetColumnType(Column);
        case ColumnType of
          ctParamValue: begin
            if WithParam then begin
              if ParamIsConfirm then begin
                if VarToIntDef(FDataSetValues.FieldByName('IS_CHECK').Value,0)=0 then begin
                  ResultFalseEx(FDataSetValues.FieldByName('PARAM_NAME').AsString);
                  break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

var
  i: Integer;
  Flag: Boolean;
begin
  Result:=true;
  if FDataSet.Active and
     not FDataSet.IsEmpty then begin
    Flag:=true;
    if CheckChanges then
      Flag:=Boolean(FDataSet.FieldByName('IS_CHANGE').AsInteger);
    if Flag then begin
      for i:=0 to FGrid.Columns.Count-1 do begin
        Column:=FGrid.Columns[i];
        ColumnType:=GetColumnType(Column);
        case ColumnType of
          ctPointName: begin
            if VarIsNull(FDataSet.FieldByName('POINT_ID').Value) or
               (Trim(FDataSet.FieldByName('POINT_NAME').AsString)='') then begin
              ResultFalse(FGrid);
              break;
            end;
          end;
          ctDate: begin
            if VarIsNull(FDataSet.FieldByName('DATE_OBSERVATION').Value) then begin
              ResultFalse(FGrid);
              break;
            end;
          end;
        end;
      end;
      if FDataSetValues.Active and
         not FDataSetValues.IsEmpty then begin

        if OnlyCurrent then
          CheckRecordLocal
        else begin
          if WithEvent then
            FDataSetValues.DataEvent(deParentScroll,0);
          FDataSetValues.First;
          while not FDataSetValues.Eof do begin
            CheckRecordLocal;
            if not Result then begin
              break;
            end;
            FDataSetValues.Next;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GoEdit(AGrid: TSgtsFunSourceDbGrid; WithEditor: Boolean; WithDataSet: Boolean; EditorMode: Boolean=true);
begin
  if IsEdit then begin
    if not (dgEditing in AGrid.Options) then begin
      AGrid.Options:=AGrid.Options+[dgEditing];
    end;
    AGrid.TopLeftChanged;
    DBEditJournalNum.ReadOnly:=false;
    DBMemoNote.ReadOnly:=false;
    if WithDataSet then begin
      if AGrid=FGrid then begin
        with FDataSet do begin
          if IsEmpty and (State<>dsInsert) then Insert
          else if (State<>dsEdit) then Edit;
        end;
      end else begin
        with FDataSetValues do begin
          if (FDataSetValues.State<>dsEdit) then
            FDataSetValues.Edit;
          if (FDataSetValues.State<>dsEdit) then
            FDataSetValues.Edit;
        end;
      end;
    end;
    if WithEditor then begin
      AGrid.EditorMode:=EditorMode;
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetIsConfirm: Boolean;
begin
  Result:=false;
  if FDataSet.Active and
     not FDataSet.IsEmpty then begin
    Result:=Boolean(FDataSet.FieldByName('IS_CONFIRM').AsInteger);
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GoDropDown(AGrid: TSgtsFunSourceDbGrid);
var
  Column: TColumn;
begin
  if IsEdit then begin
    Column:=GetCurrentColumn(AGrid);
    if Assigned(AGrid.InplaceEdit) and Assigned(Column) then begin
      TSgtsFunSourceEditList(AGrid.InplaceEdit).CloseUp(true);
      if (Column.PickList.Count>0) and not AGrid.InplaceEdit.ListVisible then
        TSgtsFunSourceEditList(AGrid.InplaceEdit).DropDown;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
  Index: Integer;
  AGrid: TSgtsFunSourceDbGrid;
  Field: TField;
begin
  FNewRecordMode:=rmInput;
  AGrid:=Sender as TSgtsFunSourceDbGrid;

  ColumnType:=GetColumnType(GetCurrentColumn(AGrid));
  case Key of
    VK_DELETE: begin
      if (ssCtrl in Shift) then begin
        Key:=0;
        exit;
      end;
    end;
    VK_F2: begin
      if not CanUpdate then
        GoBrowse(AGrid,false)
      else
        if AGrid=FGridValues then begin
          Update;
          Key:=0;
        end else
          Key:=0;
    end;
    VK_F3: begin
      if not CanDetail then
        if IsCanInfo then
          if AGrid=FGrid then
            ShowInfo(FDataSet.GetInfo)
          else
            ShowInfo(FDataSetValues.GetInfo);
    end;
    VK_SPACE: begin
      if (ColumnType=ctBase) then begin
        SetIsBase;
        Key:=0;
      end;
      if ColumnType=ctConfirm then begin
        Confirm;
        Key:=0;
      end;
    end;
    VK_RETURN: begin
      if ColumnType in ReturnColumnTypes then begin
        if GetCurrentColumn(AGrid).PickList.Count>0 then
          GoBrowse(AGrid,true)
        else begin
          if ColumnType=ctParamValue then begin
            if not (FDataSetValues.State in [dsEdit,dsInsert]) then begin
              Field:=GetCurrentColumn(AGrid).Field;
              if Assigned(Field) then begin
                if VarIsNull(Field.Value) then begin
                  FDataSetValues.Edit;
                  ParamValueFieldSetText(Field,'');
                end;
              end;
            end;
          end;
          GoBrowse(AGrid,false);
        end;
        Index:=AGrid.SelectedIndex+1;
        if NextPresent(AGrid,Index,ReturnColumnTypes) then
          AGrid.SelectedIndex:=Index
        else begin
          if AGrid=FGrid then
            FDataSetValues.BeginUpdate(false);
          try
            if CheckRecord(false,true,AGrid=FGridValues) then begin
              if SaveRecord(AGrid=FGridValues) then begin
                if IsCanInsert and IsEdit then begin
                  if (AGrid=FGrid) then begin
                    if FDataSet.RecNo=FDataSet.RecordCount then
                      FDataSet.Append
                    else FDataSet.Next;
                    AGrid.SelectedIndex:=0;
                  end else begin
                    if FDataSetValues.State=dsBrowse then begin
                      FDataSetValues.Next;
                      AGrid.SelectedIndex:=0;
                    end;
                  end;
                end;
              end;
            end;
          finally
            if AGrid=FGrid then
              FDataSetValues.EndUpdate(false);
          end;
        end;
        Key:=0;
        exit;
      end;
    end;
    VK_DOWN: begin
      if (ssAlt in Shift) and
         (ColumnType in PickListColumnTypes) and
         (GetCurrentColumn(AGrid).PickList.Count>0) and
         IsCanUpdate and
         not GetIsConfirm then begin
        GoEdit(AGrid,true,true);
        GoDropDown(AGrid);
        Key:=0;
      end else begin
        FNewRecordMode:=rmCancel;
      end;
    end;
    VK_UP: begin
    end;
    VK_INSERT: begin
      Key:=0;
    end;

    else begin
      case ColumnType of
        ctDate: begin
          if IsCanUpdate and
             not GetIsConfirm then
            GoEdit(AGrid,false,false);
        end;
        ctParamValue: begin
          if IsCanUpdate and
             (GetParamType=ptIntroduced) and
             not GetIsConfirm then begin
            GoEdit(AGrid,false,false);
          end;
        end;
      end;
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetMeasureTypeIdByFilter: Variant;
begin
  Result:=GetValueByCounter('MEASURE_TYPE_ID',0);
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetObjectIdByFilter: Variant;
begin
  Result:=GetValueByCounter('OBJECT_ID',0);
end;

function TSgtsFunSourceDataMeasureDetailFrame.SaveRecord(OnlyCurrent: Boolean=false): Boolean;
var
  JournalNum: Variant;
  Note: Variant;
  CycleId: Variant;
  PointId: Variant;
  GroupId: Variant;
  Priority: Variant;
  WhoEnter: Variant;
  DateEnter: Variant;
  DateObservation: Variant;
  IsBase: Variant;
  WhoConfirm: Variant;
  DateConfirm: Variant;

  procedure SaveLocal;
  var
    JournalFieldId: Variant;
    ParamId: Variant;
    ParamValue: Variant;
    InstrumentId: Variant;
    MeasureUnitId: Variant;
    IsCheck: Variant;

    procedure InsertLocal;
    var
      DS: TSgtsDatabaseCDS;
      AKey: TSgtsExecuteDefKey;
    begin
      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderInsertJournalField;
        DS.StopException:=true;
        with DS.ExecuteDefs do begin
          AKey:=AddKey('JOURNAL_FIELD_ID');
          AddInvisible('JOURNAL_NUM').Value:=iff(Trim(VarToStrDef(JournalNum,''))<>'',JournalNum,Null);
          AddInvisible('NOTE').Value:=iff(Trim(VarToStrDef(Note,''))<>'',Note,Null);
          AddInvisible('CYCLE_ID').Value:=CycleId;
          AddInvisible('POINT_ID').Value:=PointId;
          AddInvisible('PARAM_ID').Value:=ParamId;
          AddInvisible('INSTRUMENT_ID').Value:=InstrumentId;
          AddInvisible('MEASURE_UNIT_ID').Value:=MeasureUnitId;
          AddInvisible('VALUE').Value:=ParamValue;
          AddInvisible('DATE_OBSERVATION').Value:=DateObservation;
          AddInvisible('WHO_ENTER').Value:=WhoEnter;
          AddInvisible('DATE_ENTER').Value:=DateEnter;
          AddInvisible('WHO_CONFIRM').Value:=WhoConfirm;
          AddInvisible('DATE_CONFIRM').Value:=DateConfirm;
          AddInvisible('GROUP_ID').Value:=GroupId;
          AddInvisible('PRIORITY').Value:=Priority;
          AddInvisible('IS_BASE').Value:=IsBase;
          AddInvisible('IS_CHECK').Value:=IsCheck;
          AddInvisible('MEASURE_TYPE_ID').Value:=GetMeasureTypeIdByFilter;
        end;
        DS.Execute;
        Result:=Result and DS.ExecuteSuccess;

        if Result then begin
          FDataSetValues.Edit;
          FDataSetValues.FieldByName('JOURNAL_FIELD_ID').Value:=AKey.Value;
          FDataSetValues.Post;
        end;  
      finally
        DS.Free;
      end;
    end;

    procedure UpdateLocal;
    var
      DS: TSgtsDatabaseCDS;
    begin
      DS:=TSgtsDatabaseCDS.Create(CoreIntf);
      try
        DS.ProviderName:=SProviderUpdateJournalField;
        DS.StopException:=true;
        with DS.ExecuteDefs do begin
          AddKeyLink('JOURNAL_FIELD_ID').Value:=JournalFieldId;
          AddInvisible('JOURNAL_NUM').Value:=iff(Trim(VarToStrDef(JournalNum,''))<>'',JournalNum,Null);
          AddInvisible('NOTE').Value:=iff(Trim(VarToStrDef(Note,''))<>'',Note,Null);
          AddInvisible('CYCLE_ID').Value:=CycleId;
          AddInvisible('POINT_ID').Value:=PointId;
          AddInvisible('PARAM_ID').Value:=ParamId;
          AddInvisible('INSTRUMENT_ID').Value:=InstrumentId;
          AddInvisible('MEASURE_UNIT_ID').Value:=MeasureUnitId;
          AddInvisible('VALUE').Value:=ParamValue;
          AddInvisible('DATE_OBSERVATION').Value:=DateObservation;
          AddInvisible('WHO_ENTER').Value:=WhoEnter;
          AddInvisible('DATE_ENTER').Value:=DateEnter;
          AddInvisible('WHO_CONFIRM').Value:=WhoConfirm;
          AddInvisible('DATE_CONFIRM').Value:=DateConfirm;
          AddInvisible('GROUP_ID').Value:=GroupId;
          AddInvisible('PRIORITY').Value:=Priority;
          AddInvisible('IS_BASE').Value:=IsBase;
          AddInvisible('IS_CHECK').Value:=IsCheck;
          AddInvisible('MEASURE_TYPE_ID').Value:=GetMeasureTypeIdByFilter;
        end;
        DS.Execute;
        Result:=Result and DS.ExecuteSuccess;
      finally
        DS.Free;
      end;
    end;

  var
    RecordExists: Boolean;
    FOldAfterScroll: TDataSetNotifyEvent;
    Position: Integer;
  begin
    if OnlyCurrent then begin
      ParamValue:=FDataSetValues.FieldByName('VALUE').Value;
      if not VarIsNull(ParamValue) then begin
        JournalFieldId:=FDataSetValues.FieldByName('JOURNAL_FIELD_ID').Value;
        ParamId:=FDataSetValues.FieldByName('PARAM_ID').Value;
        InstrumentId:=FDataSetValues.FieldByName('INSTRUMENT_ID').Value;
        MeasureUnitId:=FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value;
        IsCheck:=FDataSetValues.FieldByName('IS_CHECK').Value;

        RecordExists:=not VarIsNull(JournalFieldId);
        if not RecordExists then
          InsertLocal
        else UpdateLocal;
      end;
    end else begin
      CoreIntf.MainForm.Progress2(0,FDataSetValues.RecordCount,0);
      FOldAfterScroll:=FDataSetValues.AfterScroll;
      FDataSetValues.AfterScroll:=nil;
      try
        Position:=0;
        FDataSetValues.First;
        while not FDataSetValues.Eof do begin
          ParamValue:=FDataSetValues.FieldByName('VALUE').Value;
          if not VarIsNull(ParamValue) then begin
            JournalFieldId:=FDataSetValues.FieldByName('JOURNAL_FIELD_ID').Value;
            ParamId:=FDataSetValues.FieldByName('PARAM_ID').Value;
            InstrumentId:=FDataSetValues.FieldByName('INSTRUMENT_ID').Value;
            MeasureUnitId:=FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value;
            IsCheck:=FDataSetValues.FieldByName('IS_CHECK').Value;

            RecordExists:=not VarIsNull(JournalFieldId);
            if not RecordExists then
              InsertLocal
            else UpdateLocal;
          end;

          Inc(Position);
          CoreIntf.MainForm.Progress2(0,FDataSetValues.RecordCount,Position);
          FDataSetValues.Next;
        end;
      finally
        FDataSetValues.AfterScroll:=FOldAfterScroll;
        CoreIntf.MainForm.Progress2(0,0,0);
      end;
    end;
  end;

var
  OldCursor: TCursor;
  IsChange: Boolean;
begin
  Result:=true;
  if FDataSet.Active and
     not FDataSet.IsEmpty and
     FDataSetValues.Active and
     not FDataSetValues.IsEmpty and
     IsEdit then begin

    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      IsChange:=Boolean(FDataSet.FieldByName('IS_CHANGE').AsInteger);
      if IsChange then begin
        JournalNum:=FDataSet.FieldByName('JOURNAL_NUM').Value;
        Note:=FDataSet.FieldByName('NOTE').Value;
        CycleId:=FDataSet.FieldByName('CYCLE_ID').Value;
        PointId:=FDataSet.FieldByName('POINT_ID').Value;
        GroupId:=FDataSet.FieldByName('GROUP_ID').Value;
        Priority:=FDataSet.RecNo;
        WhoEnter:=FDataSet.FieldByName('WHO_ENTER').Value;
        DateEnter:=FDataSet.FieldByName('DATE_ENTER').Value;
        DateObservation:=FDataSet.FieldByName('DATE_OBSERVATION').Value;
        IsBase:=FDataSet.FieldByName('IS_BASE').Value;
        WhoConfirm:=FDataSet.FieldByName('WHO_CONFIRM').Value;
        DateConfirm:=FDataSet.FieldByName('DATE_CONFIRM').Value;

        SaveLocal;

        if not OnlyCurrent and Result then begin
          FDataSet.Edit;
          FDataSet.FieldByName('IS_CHANGE').AsInteger:=Integer(false);
          FDataSet.Post;
        end;
      end;
    finally
      Screen.Cursor:=OldCursor;
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GridGetFontColor(Sender: TObject; Column: TColumn; var FontStyles: TFontStyles): TColor;
var
  IsChange: Boolean;
begin
  Result:=Column.Font.Color;
  if FDataSet.Active and not FDataSet.IsEmpty then begin
    IsChange:=Boolean(FDataSet.FieldByName('IS_CHANGE').AsInteger);
    if isChange then
      Result:=clGreen;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GridValuesGetFontColor(Sender: TObject; Column: TColumn; var FontStyles: TFontStyles): TColor;
var
  IsCheck: Boolean;
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
begin
  Result:=Column.Font.Color;
  FontStyles:=Column.Font.Style;
  if FDataSetValues.Active and not FDataSetValues.IsEmpty then begin
    ColumnType:=GetColumnType(Column);
    IsCheck:=Boolean(FDataSetValues.FieldByName('IS_CHECK').AsInteger);
    if not IsCheck then begin
      Result:=clRed;
      if ColumnType=ctParamValue then
        FontStyles:=[fsBold];
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetChangeArePresent: Boolean;
begin
  Result:=FChangePresent;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.SetChangeArePresent(Value: Boolean);
begin
  FChangePresent:=Value;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetCycleNum: String;
begin
  Result:='';
  if FDataSet.Active and
     not FDataSet.IsEmpty then begin
    if FDataSetCycles.Locate('CYCLE_ID',FDataSet.FieldByName('CYCLE_ID').Value) then begin
      Result:=Format(SCycleFormat,[FDataSetCycles.FieldByName('CYCLE_NUM').AsInteger,
                                   GetMonthNameByIndex(FDataSetCycles.FieldByName('CYCLE_MONTH').AsInteger),
                                   FDataSetCycles.FieldByName('CYCLE_YEAR').AsInteger]);
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetRouteName: String;
begin
  Result:='';
  if FDataSet.Active and
     not FDataSet.IsEmpty then begin
    if FDataSetPoints.Locate('POINT_ID',FDataSet.FieldByName('POINT_ID').Value) then begin
      Result:=FDataSetPoints.FieldByName('ROUTE_NAME').AsString;
    end;
  end;   
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetActiveControl: TWinControl;
begin
  Result:=FGrid;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Insert;
begin
  if CanInsert then begin
    FDataSet.Append;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.CanInsert: Boolean;
begin
  Result:=IsCanInsert and 
          FDataSet.Active and
          IsEdit and
          not FGridValues.Focused;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GoSelect(AGrid: TSgtsFunSourceDbGrid; ReadOnly: Boolean);
begin
  if Assigned(AGrid.InplaceEdit) then begin
//    AGrid.InplaceEdit.SelStart:=0;
    AGrid.InplaceEdit.SelectAll;
    TSgtsFunSourceEditList(AGrid.InplaceEdit).ReadOnly:=ReadOnly;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Update;
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
begin
  if CanUpdate then begin
    if FGridValues.Focused then begin
      GoEdit(FGridValues,true,true);
      ColumnType:=GetColumnType(GetCurrentColumn(FGridValues));
      GoSelect(FGridValues,(ColumnType in PickListColumnTypes));
    end else begin
      GoEdit(FGrid,true,true);
      ColumnType:=GetColumnType(GetCurrentColumn(FGrid));
      GoSelect(FGrid,(ColumnType in PickListColumnTypes));
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.CanUpdate: Boolean;
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
  Flag: Boolean;
  AGrid: TSgtsFunSourceDbGrid;
begin
  Result:=IsCanUpdate and
          FDataSet.Active and
          FDataSetValues.Active and
          IsEdit;
  if Result then begin
    if FGridValues.Focused then
      AGrid:=FGridValues
    else AGrid:=FGrid;
    Flag:=false;
    ColumnType:=GetColumnType(GetCurrentColumn(AGrid));
    if (ColumnType in EditColumnTypes) and
       not GetIsConfirm then begin
      Flag:=true;
      if ColumnType in PickListColumnTypes then
        Flag:=GetCurrentColumn(AGrid).PickList.Count>0;
      if ColumnType in ParamColumnTypes then
        Flag:=GetParamType=ptIntroduced;
    end;
    Result:=Result and Flag;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Delete;
var
  Counter: Integer;
  Field: TField;
  DS: TSgtsDatabaseCDS;
begin
  if CanDelete then begin
    FDataSet.BeginUpdate(true);
    FDataSetValues.BeginUpdate;
    CoreIntf.MainForm.Progress(0,FDataSetParams.RecordCount,0);
    try
      Counter:=0;
      FDataSetValues.Last;
      while not FDataSetValues.Bof do begin
        Field:=FDataSetValues.FieldByName('JOURNAL_FIELD_ID');
        if not VarIsNull(Field.Value) then begin
          DS:=TSgtsDatabaseCDS.Create(CoreIntf);
          try
            DS.ProviderName:=SProviderDeleteJournalField;
            DS.StopException:=true;
            DS.ExecuteDefs.AddKeyLink('JOURNAL_FIELD_ID').Value:=Field.Value;
            DS.Execute;
          finally
            DS.Free;
          end;
        end;
        Inc(Counter);
        CoreIntf.MainForm.Progress(0,FDataSetParams.RecordCount,Counter);
        FDataSetValues.Delete;;
      end;
      FDataSet.Delete;
      UpdateButtons;
    finally
      CoreIntf.MainForm.Progress(0,0,0);
      FDataSetValues.EndUpdate;
      FDataSet.EndUpdate;
    end;
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.CanDelete: Boolean;
begin
  Result:=IsCanDelete and
          FDataSet.Active and
          not FDataSet.IsEmpty and
          IsEdit and
          not (FDataSet.State in [dsInsert,dsEdit]) and
          not GetIsConfirm and
          not FGridValues.Focused and
          not (FDataSetValues.State in [dsInsert,dsEdit]);
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Confirm;
var
  Flag: Boolean;
  ADate: TDate;
begin
  if CanConfirm then begin
    FDataSetValues.BeginUpdate(false);
    try
      ADate:=DateOf(Date);
      Flag:=Boolean(FDataSet.FieldByName('IS_CONFIRM').AsInteger);
      if not Flag then begin
        if CheckRecord(false,true,false,true) then begin
          FDataSet.Edit;
          FDataSet.FieldByName('WHO_CONFIRM').Value:=Database.PersonnelId;
          FDataSet.FieldByName('DATE_CONFIRM').Value:=ADate;
          FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
          FChangePresent:=true;
          FDataSet.Post;
        end;
      end else begin
        FDataSet.Edit;
        FDataSet.FieldByName('WHO_CONFIRM').Value:=Null;
        FDataSet.FieldByName('DATE_CONFIRM').Value:=Null;
        FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
        FChangePresent:=true;
        FDataSet.Post;
      end;
      SetAdditionalInfo;
      UpdateButtons;
    finally
      FDataSetValues.EndUpdate(false);
    end;  
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.CanConfirm: Boolean;
begin
  Result:=IsCanConfirm and
          Assigned(Database) and
          FDataSet.Active and
          not FDataSet.IsEmpty and
          FDataSetValues.Active and
          not FDataSetValues.IsEmpty and
          IsEdit;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ViewPointInfo;
var
  AIface: TSgtsFunPointManagementIface;
  Data: String;
  AFilterGroups: TSgtsGetRecordsConfigFilterGroups;
  AMeasureTypeId: Variant;
begin
  AIface:=TSgtsFunPointManagementIface.Create(CoreIntf);
  AFilterGroups:=TSgtsGetRecordsConfigFilterGroups.Create;
  try
    AIface.IsCanSelect:=false;
    AIface.FilterOnShow:=false;
    AMeasureTypeId:=GetMeasureTypeIdByFilter;
    AFilterGroups.Add.Filters.Add('MEASURE_TYPE_ID',fcEqual,AMeasureTypeId);
    AIface.SelectByUnionType('UNION_ID;UNION_TYPE',VarArrayOf([FDataSet.FieldByName('POINT_ID').Value,utPoint]),Data,utPoint,AFilterGroups,false);
  finally
    AFilterGroups.Free;
    AIface.Free;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ViewParamInfo;
var
  AIface: TSgtsFunSourceDataParamsIface;
begin
  AIface:=TSgtsFunSourceDataParamsIface.CreateByParamId(CoreIntf,FDataSetValues.FieldByName('PARAM_ID').Value);
  try
    AIface.Init;
    AIface.AsModal:=true;
    AIface.DatabaseLink;
    AIface.Refresh;
    AIface.Detail;
  finally
    AIface.Free;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ViewInstrumentInfo;
var
  AIface: TSgtsFunSourceDataInstrumentsIface;
begin
  AIface:=TSgtsFunSourceDataInstrumentsIface.CreateByInstrumentId(CoreIntf,FDataSetValues.FieldByName('INSTRUMENT_ID').Value);
  try
    AIface.Init;
    AIface.AsModal:=true;
    AIface.DatabaseLink;
    AIface.Refresh;
    AIface.Detail;
  finally
    AIface.Free;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ViewMeasureUnitInfo;
var
  AIface: TSgtsFunSourceDataMeasureUnitsIface;
begin
  AIface:=TSgtsFunSourceDataMeasureUnitsIface.CreateByMeasureUnitId(CoreIntf,FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value);
  try
    AIface.Init;
    AIface.AsModal:=true;
    AIface.DatabaseLink;
    AIface.Refresh;
    AIface.Detail;
  finally
    AIface.Free;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.Detail;
var
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
begin
  if CanDetail then begin
    if FGridValues.Focused then begin
      ColumnType:=GetColumnType(GetCurrentColumn(FGridValues));
      case ColumnType of
        ctParamName: ViewParamInfo;
        ctParamInstrument: ViewInstrumentInfo;
        ctParamUnit: ViewMeasureUnitInfo;
      end;
    end else begin
      ColumnType:=GetColumnType(GetCurrentColumn(FGrid));
      case ColumnType of
        ctPointName: ViewPointInfo;
      end;
    end;  
  end;
end;

function TSgtsFunSourceDataMeasureDetailFrame.CanDetail: Boolean;
var
  Column: TColumn;
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
begin
  if FGridValues.Focused then begin
    Column:=GetCurrentColumn(FGridValues);
    Result:=IsCanDetail and
            FDataSetValues.Active and
            not FDataSetValues.IsEmpty;
  end else begin
    Column:=GetCurrentColumn(FGrid);
    Result:=IsCanDetail and
            FDataSet.Active and
            not FDataSet.IsEmpty;
  end;
  if Result then begin
    ColumnType:=GetColumnType(Column);
    Result:=ColumnType in InfoColumnTypes;
    if Result then begin
      case ColumnType of
        ctPointName: begin
          Result:=not VarIsNull(FDataSet.FieldByName('POINT_ID').Value) and
                  (Trim(FDataSet.FieldByName('POINT_NAME').AsString)<>'');
        end;
        ctParamName: begin
          Result:=not VarIsNull(FDataSetValues.FieldByName('PARAM_ID').Value) and
                 (Trim(FDataSetValues.FieldByName('PARAM_NAME').AsString)<>'');
        end;
        ctParamInstrument: begin
          Result:=not VarIsNull(FDataSetValues.FieldByName('INSTRUMENT_ID').Value) and
                 (Trim(FDataSetValues.FieldByName('INSTRUMENT_NAME').AsString)<>'');
        end;
        ctParamUnit: begin
          Result:=not VarIsNull(FDataSetValues.FieldByName('MEASURE_UNIT_ID').Value) and
                 (Trim(FDataSetValues.FieldByName('MEASURE_UNIT_NAME').AsString)<>'');
        end;
      end;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.SetIsBase;
var
  FlagCheck: Boolean;
  FlagEdit: Boolean;
begin
  if IsCanUpdate and
     FDataSet.Active and
     not FDataSet.IsEmpty and
     IsEdit and
     not GetIsConfirm then begin
    FlagEdit:=true;
    FlagCheck:=Boolean(FDataSet.FieldByName('IS_BASE').AsInteger);
    if not FlagCheck then begin
      FDataSet.BeginUpdate(true);
      try
        FDataSet.Filter:=Format('CYCLE_ID=%s AND POINT_ID=%s AND DATE_OBSERVATION=%s',
                                [QuotedStr(FDataSet.FieldByName('CYCLE_ID').AsString),
                                 QuotedStr(FDataSet.FieldByName('POINT_ID').AsString),
                                 QuotedStr(FDataSet.FieldByName('DATE_OBSERVATION').AsString)]);
        FDataSet.Filtered:=true;
        FDataSet.First;
        while not FDataSet.Eof do begin
          if Boolean(FDataSet.FieldByName('IS_BASE').AsInteger) then begin
            if not Boolean(FDataSet.FieldByName('IS_CONFIRM').AsInteger) then begin
              FDataSet.Edit;
              FDataSet.FieldByName('IS_BASE').AsInteger:=Integer(false);
              FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
              FChangePresent:=true;
              FDataSet.Post;
            end else
              FlagEdit:=false;  
          end;
          FDataSet.Next;
        end;
      finally
        FDataSet.EndUpdate(true);
      end;
    end;
    if FlagEdit then begin
      FDataSet.Edit;
      FDataSet.FieldByName('IS_BASE').AsInteger:=Integer(not FlagCheck);
      FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
      FChangePresent:=true;
      FDataSet.Post;
    end;  
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.PopupMenuConfirmPopup(
  Sender: TObject);
begin
  MenuItemConfirmCheckAll.Enabled:=CanConfirm;
  MenuItemConfirmUnCheckAll.Enabled:=MenuItemConfirmCheckAll.Enabled;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.MenuItemConfirmCheckAllClick(
  Sender: TObject);
begin
  ConfirmAll(True);
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.MenuItemConfirmUncheckAllClick(
  Sender: TObject);
begin
  ConfirmAll(False);
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.ConfirmAll(Checked: Boolean);

  function LocalCanConfirm: Boolean;
  var
    Value: Variant;
  begin
    Result:=false;
    if VarIsNull(FDataSet.FieldByName('DATE_CONFIRM').Value) then begin
      FDataSetValues.DataEvent(deParentScroll,0);
      FDataSetValues.UpdatePosInControls;
      FDataSetValues.First;
      while not FDataSetValues.Eof do begin
        Value:=FDataSetValues.FieldByName('VALUE').Value;
        if VarIsNull(Value) then
          exit;
        FDataSetValues.Next;
      end;
      Result:=true;
    end;
  end;

var
  ADate: TDate;
begin
  if CanConfirm then begin
    FDataSet.BeginUpdate(true);
    FDataSetValues.BeginUpdate(false);
    try
      ADate:=DateOf(Date);
      FDataSet.First;
      while not FDataSet.Eof do begin
        if Checked then begin
          if LocalCanConfirm then begin
            FDataSet.UpdatePosInControls;
            if CheckRecord(false,true,false,true,true) then begin
              FDataSet.Edit;
              FDataSet.FieldByName('WHO_CONFIRM').Value:=Database.PersonnelId;
              FDataSet.FieldByName('DATE_CONFIRM').Value:=ADate;
              FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
              FChangePresent:=true;
              FDataSet.Post;
            end else begin
              FDataSet.ThrowBookmark;
              break;
            end;
          end;  
        end else begin
          if not VarIsNull(FDataSet.FieldByName('DATE_CONFIRM').Value) then begin
            FDataSet.Edit;
            FDataSet.FieldByName('WHO_CONFIRM').Value:=Null;
            FDataSet.FieldByName('DATE_CONFIRM').Value:=Null;
            FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
            FChangePresent:=true;
            FDataSet.Post;
          end;  
        end;
        FDataSet.Next;
      end;
    finally
      FDataSetValues.EndUpdate(true);
      FDataSet.EndUpdate(true);
    end;
  end;  
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.GridEnter(Sender: TObject);
begin
  SetColumnProperty(GetCurrentColumn(FGrid));
  UpdateButtons;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DBEditJournalNumKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if FDataSet.Active and not FDataSet.IsEmpty then begin
    GoEdit(FGrid,False,True,False);
    FDataSet.FieldByName('IS_CHANGE').Value:=Integer(true);
    FChangePresent:=true;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.DBMemoNoteExit(Sender: TObject);
begin
  GoBrowse(FGrid,true);
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetInstrumentIdByFilter: Variant;
begin
  Result:=GetValueByCounter('INSTRUMENT_ID',FDataSetValues.RecNo-1);
end;

function TSgtsFunSourceDataMeasureDetailFrame.GetMeasureUnitIdByFilter: Variant;
begin
  Result:=GetValueByCounter('MEASURE_UNIT_ID',FDataSetValues.RecNo-1);
end;

function TSgtsFunSourceDataMeasureDetailFrame.Checking(var Value: Variant): Boolean;
var
  Column: TColumn;
  ColumnType: TSgtsFunSourceDataMeasureDetailColumnType;
  AIface: TSgtsCheckingIface;
  Checked: Boolean;
begin
  Result:=true;
  if FDataSet.Active and
     not FDataSet.IsEmpty then begin
    Column:=GetCurrentColumn(FGridValues);
    if Assigned(Column) then begin
      ColumnType:=GetColumnType(Column);
      if ColumnType=ctParamValue then begin
        if not VarIsNull(Value) then begin

          AIface:=TSgtsCheckingIface.Create(CoreIntf);
          try
            AIface.DateObservation:=FDataSet.FieldByName('DATE_OBSERVATION').Value;
            AIface.CycleId:=FDataSet.FieldByName('CYCLE_ID').Value;
            AIface.CycleNum:=GetCycleNum;
            AIface.MeasureTypeId:=GetMeasureTypeIdByFilter;
            AIface.MeasureTypeName:=MeasureTypeName;
            AIface.MeasureTypePath:=MeasureTypePath;
            AIface.ObjectId:=GetObjectIdByFilter;
            AIface.ObjectName:=ObjectName;
            AIface.PointId:=FDataSet.FieldByName('POINT_ID').Value;
            AIface.PointName:=FDataSet.FieldByName('POINT_NAME').AsString;
            AIface.ParamId:=FDataSetValues.FieldByName('PARAM_ID').Value;
            AIface.ParamName:=FDataSetValues.FieldByName('PARAM_NAME').Value;
            AIface.Value:=Value;

            Checked:=AIface.Checking;
            if Checked then begin
              Value:=AIface.Value;
              Checked:=AIface.Checked;
            end else
              Value:=Null;

            Result:=Checked;

          finally
            AIface.Free;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSgtsFunSourceDataMeasureDetailFrame.SetAdditionalInfo;
var
  PointId: Variant;
begin
  DBEditJournalNum.Color:=iff(IsCanUpdate and IsEdit and not GetIsConfirm,clWindow,clBtnFace);
  DBMemoNote.Color:=DBEditJournalNum.Color;
  if FDataSet.Active and
     not FDataSet.IsEmpty and
     FDataSetPoints.Active and
     not FDataSetPoints.IsEmpty then begin
    PointId:=FDataSet.FieldByName('POINT_ID').Value;
    if FDataSetPoints.Locate('POINT_ID',PointId) then begin
      EditConverter.Text:=FDataSetPoints.FieldByName('CONVERTER_NAME').AsString;
      EditPointCoordinateZ.Text:=FDataSetPoints.FieldByName('COORDINATE_Z').AsString;
      MemoPointObject.Lines.Text:=FDataSetPoints.FieldByName('OBJECT_PATHS').AsString;
    end else begin
      EditConverter.Text:='';
      EditPointCoordinateZ.Text:='';
      MemoPointObject.Clear;
    end;
  end;
end;

end.
