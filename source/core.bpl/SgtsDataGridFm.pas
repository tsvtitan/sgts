unit SgtsDataGridFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin, DBGrids, StdCtrls, Grids,
  SgtsDataFm, SgtsDbGrid, SgtsFm, SgtsCDS,
  SgtsDataGridFmIntf, SgtsCoreIntf, SgtsGetRecordsConfig;

type
  TSgtsDataGridIface=class;

  TSgtsDataGridForm = class(TSgtsDataForm)
    GridPattern: TDBGrid;
    procedure GridPatternDblClick(Sender: TObject);
  private
    FGrid: TSgtsDbGrid;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
    function GetIface: TSgtsDataGridIface;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;

    procedure InitByIface(AIface: TSgtsFormIface); override;

    property Grid: TSgtsDbGrid read FGrid;
    property Iface: TSgtsDataGridIface read GetIface;
  end;

  TSgtsDataGridIface=class(TSgtsDataIface,ISgtsDataGridForm)
  private
    FDefaultOrders: TSgtsGetRecordsConfigOrders;
    FDefaultFilterGroups: TSgtsGetRecordsConfigFilterGroups;

    FColumns: String;
    FOrders: String;
    FAutoFit: Boolean;
    FFilters: String;

    function GetForm: TSgtsDataGridForm;
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    function GetReportComponent: TComponent; override;

    property DefaultOrders: TSgtsGetRecordsConfigOrders read FDefaultOrders;
    property DefaultFilterGroups: TSgtsGetRecordsConfigFilterGroups read FDefaultFilterGroups;
    property Columns: String read FColumns write FColumns;
    property Orders: String read FOrders write FOrders;
    property AutoFit: Boolean read FAutoFit write FAutoFit;
    property Filters: String read FFilters write FFilters;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;
    function CanAdjust: Boolean; override;
    function Adjust: Boolean; override;
    procedure BeforeReadParams; override;
    procedure BeforeWriteParams; override;
    procedure OpenData; override;
    function CreateSelectedData(SelectedType: TSgtsCreateSelectedDataType): String; override;

    property Form: TSgtsDataGridForm read GetForm;
  end;

var
  SgtsDataGridForm: TSgtsDataGridForm;

implementation

uses SgtsSelectDefs, SgtsDataExport, SgtsDataIfaceIntf,
     SgtsDataGridAdjustmentFm, SgtsUtils, SgtsIface, SgtsConsts, SgtsConfigIntf,
     SgtsDatabaseCDS, DBClient;

{$R *.dfm}

{ TSgtsDataGridIface }

constructor TSgtsDataGridIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDefaultOrders:=TSgtsGetRecordsConfigOrders.Create;
  FDefaultFilterGroups:=TSgtsGetRecordsConfigFilterGroups.Create;
  FAutoFit:=true;
end;

destructor TSgtsDataGridIface.Destroy;
begin
  FDefaultFilterGroups.Free;
  FDefaultOrders.Free;
  inherited Destroy;
end;

procedure TSgtsDataGridIface.Init;
begin
  inherited Init;
end;

function TSgtsDataGridIface.GetForm: TSgtsDataGridForm;
begin
  Result:=TSgtsDataGridForm(inherited Form);
end;

function TSgtsDataGridIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsDataGridForm;
end;

function TSgtsDataGridIface.GetReportComponent: TComponent;
begin
  Result:=inherited GetReportComponent;
  if Assigned(Form) then
    Result:=Form.Grid;
end;

function TSgtsDataGridIface.CanAdjust: Boolean;
begin
  Result:=DataSet.Active and
          Assigned(Form) and
          Assigned(Form.Grid);
end;

function TSgtsDataGridIface.Adjust: Boolean;
var
  AIface: TSgtsDataGridAdjustmentIface;
begin
  Result:=inherited Adjust;
  if CanAdjust then begin
    AIface:=TSgtsDataGridAdjustmentIface.Create(CoreIntf);
    try
      AIface.Init;
      AIface.ReadParams;
      AIface.Columns:=Form.Grid.Columns;
      AIface.SelectDefs:=DataSet.SelectDefs;
      AIface.Orders:=DataSet.Orders;
      AIface.DefaultOrders:=FDefaultOrders;
      AIface.AutoFitColumns:=Form.Grid.AutoFit;
      AIface.FilterGroups:=DataSet.FilterGroups;
      AIface.DefaultFilterGroups:=FDefaultFilterGroups;
      if AIface.ShowModal=mrOk then begin
        with Form do begin
          Grid.AutoFit:=false;
          CopyGridColumns(AIface.Columns,Grid.Columns);
          Grid.AutoFit:=AIface.AutoFitColumns;
          if Grid.AutoFit then
            Grid.AutoFitColumns;
          FColumns:=Grid.GetColumnsStr;
          FAutoFit:=Grid.AutoFit;
        end;
        DataSet.Orders.CopyFrom(AIface.Orders);
        FOrders:=DataSet.Orders.GetOrdersStr;
        
        DataSet.FilterGroups.CopyFrom(AIface.FilterGroups);
        FFilters:=DataSet.FilterGroups.GetFiltersStr;

        Refresh;
        Result:=true;
      end;
    finally
      AIface.WriteParams;
      AIface.Free;
    end;
  end;
end;

procedure TSgtsDataGridIface.BeforeReadParams;
begin
  inherited BeforeReadParams;
  DataSet.Orders.CopyFromSelectDefs(DataSet.SelectDefs);
  DefaultOrders.CopyFrom(DataSet.Orders);
  FOrders:=DataSet.Orders.GetOrdersStr;

  DataSet.FilterGroups.CopyFromSelectDefs(DataSet.SelectDefs);
  DefaultFilterGroups.CopyFrom(DataSet.FilterGroups);
  FFilters:=DataSet.FilterGroups.GetFiltersStr;
end;

procedure TSgtsDataGridIface.BeforeWriteParams;
begin
  inherited BeforeWriteParams;
  FOrders:=DataSet.Orders.GetOrdersStr;
  FFilters:=DataSet.FilterGroups.GetFiltersStr;
end;

procedure TSgtsDataGridIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  inherited ReadParams(DatabaseConfig);
  FColumns:=ReadParam(SConfigParamColumns,FColumns,cmBase64);
  FAutoFit:=ReadParam(SConfigParamAutoFit,FAutoFit);
  FOrders:=ReadParam(SConfigParamOrders,FOrders,cmBase64);
  DataSet.Orders.SetOrdersStr(FOrders);
  FFilters:=ReadParam(SConfigParamFilters,FFilters,cmBase64);
  DataSet.FilterGroups.SetFiltersStr(FFilters);
end;

procedure TSgtsDataGridIface.WriteParams(DatabaseConfig: Boolean=true);
begin
  WriteParam(SConfigParamFilters,FFilters,cmBase64);
  WriteParam(SConfigParamOrders,FOrders,cmBase64);
  WriteParam(SConfigParamColumns,FColumns,cmBase64);
  WriteParam(SConfigParamAutoFit,FAutoFit);
  inherited WriteParams(DatabaseConfig);
end;

procedure TSgtsDataGridIface.OpenData;
begin
  inherited OpenData;
end;

procedure TSgtsDataGridIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) then begin
    if Mode=imMultiSelect then
      Form.Grid.Options:=Form.Grid.Options+[dgMultiSelect]
    else
      Form.Grid.Options:=Form.Grid.Options-[dgMultiSelect];
  end;
end;

function TSgtsDataGridIface.CreateSelectedData(SelectedType: TSgtsCreateSelectedDataType): String;
var
  i: Integer;
  B: TBookMark;
  DSOut: TSgtsCDS;
begin
  Result:=inherited CreateSelectedData(SelectedType);
  if Assigned(Form) then begin
    DataSet.BeginUpdate(true);
    DSOut:=TSgtsCDS.Create(nil);
    try
      with Form do begin
        if DataSet.Active and
           (SelectedType=sdtBookmark) then begin
          DSOut.CreateDataSetBySource(DataSet);
          if Grid.SelectedRows.Count>0 then begin
            for i:=0 to Grid.SelectedRows.Count-1 do begin
              B:=TBookmark(Grid.SelectedRows.Items[i]);
              if Assigned(B) and
                 DataSet.BookmarkValid(B) then begin
                DataSet.GotoBookmark(B);
                DSOut.FieldValuesBySource(DataSet);
              end;
            end;
          end else begin
            DSOut.FieldValuesBySource(DataSet);
          end;
          DSOut.MergeChangeLog;
          Result:=DSOut.XMLData;
        end;
      end;
    finally
      DSOut.Free;
      DataSet.EndUpdate(false);
    end;
  end;
end;

{ TSgtsDataGridForm }

constructor TSgtsDataGridForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FGrid:=TSgtsDbGrid.Create(Self);
  with FGrid do begin
    Parent:=GridPattern.Parent;
    Align:=GridPattern.Align;
    SetBounds(GridPattern.Left,GridPattern.Top,GridPattern.Width,GridPattern.Height);
    Constraints.Assign(GridPattern.Constraints);
    Font.Assign(GridPattern.Font);
    RowSelected.Font:=Font;
    CellSelected.Font:=Font;
    CellSelected.Font.Color:=clHighlightText;
    TitleCellMouseDown.Font:=Font;
    Options:=Options-[dgEditing]-[dgTabs];
    OnTitleClickWithSort:=GridTitleClickWithSort;
    OnDblClick:=GridPattern.OnDblClick;
    TabOrder:=GridPattern.TabOrder;   
    LocateEnabled:=true;
    PopupMenu:=GridPattern.PopupMenu;
    ColumnSortEnabled:=true;
  end;
  FGrid.DataSource:=DataSource;
  GridPattern.Free;
  GridPattern:=nil;
end;

destructor TSgtsDataGridForm.Destroy;
begin
  Iface.Columns:=FGrid.GetColumnsStr;
  Iface.AutoFit:=FGrid.AutoFit;
  inherited Destroy;
end;

procedure TSgtsDataGridForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  with Iface do begin
    CreateGridColumnsBySelectDefs(FGrid,DataSet.SelectDefs);
    FGrid.SetColumnsStr(Columns);
    UpdateGridColumnsBySelectDefs(FGrid,DataSet.SelectDefs);
    FGrid.AutoFit:=AutoFit;
  end;
end;

function TSgtsDataGridForm.GetIface: TSgtsDataGridIface;
begin
  Result:=TSgtsDataGridIface(inherited Iface);
end;

procedure TSgtsDataGridForm.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  NewTypeSort: TSgtsTypeSort;
  NewFieldName: string;
begin
  with Iface do begin
    if DataSet.Active and not DataSet.IsEmpty then begin
      Screen.Cursor:=crHourGlass;
      try
        NewTypeSort:=tsNone;
        NewFieldName:=Column.FieldName;
        case TypeSort of
          tcsNone: NewTypeSort:=tsNone;
          tcsAsc: NewTypeSort:=tsAsc;
          tcsDesc: NewTypeSort:=tsDesc;
        end;
        if Assigned(Column.Field) then
          if Column.Field.Calculated then
            NewFieldName:=DataSet.SelectDefs.FindCalcNameByName(NewFieldName);
        DataSet.SetIndexBySort(NewFieldName,NewTypeSort);
        UpdateStatusBar;
      finally
        FGrid.UpdateRowNumber;
        Screen.Cursor:=crDefault;
      end;
    end;
  end;
end;

procedure TSgtsDataGridForm.GridPatternDblClick(Sender: TObject);
begin
  DblClickAction;
end;

procedure TSgtsDataGridForm.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do begin
    if (CharCode=VK_ESCAPE) and (KeyDataToShiftState(Message.KeyData) = []) then begin
      if not Iface.InProgress then begin
        if (IfaceIntf.Mode in [imSelect,imMultiSelect]) and (Trim(FGrid.LocateValue)='') then begin
          Close;
          Result:=1;
        end;
      end else
        Iface.CancelProgress:=true;
    end else
      inherited;
  end;      
end;


end.
