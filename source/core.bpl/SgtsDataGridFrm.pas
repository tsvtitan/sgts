unit SgtsDataGridFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, ExtCtrls, Grids, DBGrids, DB, Menus,
  SgtsDbGrid, SgtsDatabaseCDS, SgtsCoreIntf, SgtsCDS,
  SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete, SgtsDataFmIntf,
  SgtsDataFm, SgtsDataIfaceIntf, SgtsExecuteDefs, SgtsGetRecordsConfig, SgtsMenus,
  SgtsConfigIntf;

type

  TSgtsDataGridFrame = class(TFrame,ISgtsDataIface)
    ImageList: TImageList;
    ToolBar: TToolBar;
    ToolButtonRefresh: TToolButton;
    ToolButtonInsert: TToolButton;
    ToolButtonUpdate: TToolButton;
    ToolButtonDelete: TToolButton;
    PanelView: TPanel;
    GridPattern: TDBGrid;
    DataSource: TDataSource;
    PopupMenuView: TPopupMenu;
    procedure GridPatternDblClick(Sender: TObject);
    procedure ToolButtonRefreshClick(Sender: TObject);
    procedure ToolButtonInsertClick(Sender: TObject);
    procedure ToolButtonUpdateClick(Sender: TObject);
    procedure ToolButtonDeleteClick(Sender: TObject);
    procedure PopupMenuViewPopup(Sender: TObject);
  private
    FCoreIntf: ISgtsCore;
    FIface: TSgtsDataIface;
    FIfaces: TSgtsDataIfaces;
    FGrid: TSgtsDbGrid;
    FDataSet: TSgtsDatabaseCDS;
    FInsertClass: TSgtsDataInsertIfaceClass;
    FUpdateClass: TSgtsDataUpdateIfaceClass;
    FDeleteClass: TSgtsDataDeleteIfaceClass;

    procedure GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);

    procedure Repaint; reintroduce;

    procedure InsertByDefs(ExecuteDefs: Pointer);
    procedure UpdateByDefs(ExecuteDefs: Pointer);
    procedure DeleteByDefs(ExecuteDefs: Pointer);

    function _GetDataSet: TSgtsCDS;
    function _GetExecuteDefs: TSgtsExecuteDefs;
    function _GetMode: TSgtsDataIfaceMode;
    function _GetFilterGroups: TSgtsGetRecordsConfigFilterGroups;

    procedure WriteParam(const Param: String; Value: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true);
    function ReadParam(const Param: String; Default: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true): Variant;
    procedure ReadParams(DatabaseConfig: Boolean=true);
    procedure WriteParams(DatabaseConfig: Boolean=true);
    function PermissionExists(const AName: String): Boolean;

    procedure Init;
    procedure Done;

    function _GetName: String;
  protected  
    procedure DataSetAfterScroll(DataSet: TDataSet); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitByCore(ACoreIntf: ISgtsCore);
    procedure InitByIface(AIface: TSgtsDataIface);

    procedure UpdateButtons; virtual;

    procedure CloseData; virtual;
    procedure OpenData; 

    function CanShow: Boolean;

    function CanRefresh: Boolean;
    procedure Refresh;
    function CanInsert: Boolean;
    procedure Insert; virtual;
    function CanUpdate: Boolean;
    procedure Update; reintroduce;
    function CanDelete: Boolean;
    procedure Delete;
    function CanCopy: Boolean;
    procedure Copy;
    function CanFirst: Boolean;
    procedure First;
    function CanPrior: Boolean;
    procedure Prior;
    function CanNext: Boolean;
    procedure Next;
    function CanLast: Boolean;
    procedure Last;
    function CanSelect: Boolean;
    function CanDetail: Boolean;
    procedure Detail;

    function CanReport: Boolean;
    procedure Report;

    function CanInfo: Boolean;
    procedure Info;

    property Grid: TSgtsDbGrid read FGrid;
    property DataSet: TSgtsDatabaseCDS read FDataSet;

    property InsertClass: TSgtsDataInsertIfaceClass read FInsertClass write FInsertClass;
    property UpdateClass: TSgtsDataUpdateIfaceClass read FUpdateClass write FUpdateClass;
    property DeleteClass: TSgtsDataDeleteIfaceClass read FDeleteClass write FDeleteClass;

    property CoreIntf: ISgtsCore read FCoreIntf;

  end;

implementation

{$R *.dfm}

uses Math,
     SgtsDialogs, SgtsConsts, SgtsUtils;

{ TSgtsDataGridFrame }

constructor TSgtsDataGridFrame.Create(AOwner: TComponent);
var
  AName: String;
begin
  inherited Create(AOwner);

  FDataSet:=TSgtsDatabaseCDS.Create(nil);
  FDataSet.AfterScroll:=DataSetAfterScroll;

  FIfaces:=TSgtsDataIfaces.Create;

  FGrid:=TSgtsDbGrid.Create(Self);
  with FGrid do begin
    Parent:=GridPattern.Parent;
    Align:=GridPattern.Align;
    SetBounds(GridPattern.Left,GridPattern.Top,GridPattern.Width,GridPattern.Height);
    Constraints.Assign(GridPattern.Constraints);
    Font.Assign(GridPattern.Font);
    RowSelected.Font:=Font;
    RowSelected.Font.Color:=clWindowText;
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
    AutoFit:=true;
    VisibleRowNumber:=true;
  end;
  FGrid.DataSource:=DataSource;
  AName:=GridPattern.Name;
  GridPattern.Free;
  GridPattern:=nil;

  DataSource.DataSet:=FDataSet;

  CreateMenuByToolBar(TMenuITem(PopupMenuView.Items),ToolBar);
end;

destructor TSgtsDataGridFrame.Destroy;
begin
  FIfaces.Free;
  FDataSet.Free;
  inherited Destroy;
end;

procedure TSgtsDataGridFrame.InitByCore(ACoreIntf: ISgtsCore);
begin
  FCoreIntf:=ACoreIntf;
  FDataSet.InitByCore(ACoreIntf);
  CreateGridColumnsBySelectDefs(FGrid,FDataSet.SelectDefs);
end;

procedure TSgtsDataGridFrame.InitByIface(AIface: TSgtsDataIface);
begin
  FIface:=AIface;
end;

procedure TSgtsDataGridFrame.Init;
begin
end;

procedure TSgtsDataGridFrame.Done;
begin
end;

procedure TSgtsDataGridFrame.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  NewTypeSort: TSgtsTypeSort;
  NewFieldName: string;
begin
  if FDataSet.Active and not FDataSet.IsEmpty then begin
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
    finally
      FGrid.UpdateRowNumber;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TSgtsDataGridFrame.DataSetAfterScroll(DataSet: TDataSet);
begin
  UpdateButtons;
end;

procedure TSgtsDataGridFrame.GridPatternDblClick(Sender: TObject);
begin
  Update;
end;

procedure TSgtsDataGridFrame.UpdateButtons;
begin
  ToolButtonRefresh.Enabled:=CanRefresh;
  ToolButtonInsert.Enabled:=CanInsert;
  ToolButtonUpdate.Enabled:=CanUpdate;
  ToolButtonDelete.Enabled:=CanDelete;

  UpdateMenuByButtons(TMenuItem(PopupMenuView.Items));
end;

procedure TSgtsDataGridFrame.CloseData;
begin
  if FDataSet.Active then
    FDataSet.Close;
end;

procedure TSgtsDataGridFrame.OpenData;
begin
  if not FDataSet.Active then begin
    try
      FDataSet.Open;
    except
      on E: Exception do
        ShowError(E.Message);
    end;
  end;
end;

procedure TSgtsDataGridFrame.Repaint;
begin
  inherited Repaint;
  if Assigned(FIface) then
    FIface.Repaint;
end;

procedure TSgtsDataGridFrame.InsertByDefs(ExecuteDefs: Pointer);
begin
  FDataSet.InsertByDefs(ExecuteDefs);
end;

procedure TSgtsDataGridFrame.UpdateByDefs(ExecuteDefs: Pointer);
begin
  FDataSet.UpdateByDefs(ExecuteDefs);
end;

procedure TSgtsDataGridFrame.DeleteByDefs(ExecuteDefs: Pointer);
begin
  FDataSet.DeleteByDefs(ExecuteDefs);
end;

function TSgtsDataGridFrame._GetDataSet: TSgtsCDS;
begin
  Result:=FDataSet;
end;

function TSgtsDataGridFrame._GetExecuteDefs: TSgtsExecuteDefs;
begin
  Result:=FDataSet.ExecuteDefs;
end;

function TSgtsDataGridFrame._GetMode: TSgtsDataIfaceMode;
begin
  Result:=imDefault;
end;

function TSgtsDataGridFrame._GetFilterGroups: TSgtsGetRecordsConfigFilterGroups;
begin
  Result:=FDataSet.FilterGroups;
end;

procedure TSgtsDataGridFrame.WriteParam(const Param: String; Value: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true);
begin
end;

function TSgtsDataGridFrame.ReadParam(const Param: String; Default: Variant; Mode: TSgtsConfigMode=cmDefault; DatabaseConfig: Boolean=true): Variant;
begin
end;

procedure TSgtsDataGridFrame.ReadParams;
begin
end;

procedure TSgtsDataGridFrame.WriteParams;
begin
end;

function TSgtsDataGridFrame.PermissionExists(const AName: String): Boolean;
begin
  Result:=true;
end;

function TSgtsDataGridFrame._GetName: String;
begin
  Result:='';
end;

function TSgtsDataGridFrame.CanShow: Boolean;
begin
  Result:=Assigned(FCoreIntf);
end;

function TSgtsDataGridFrame.CanRefresh: Boolean;
begin
  Result:=CanShow;
  if Result then begin
    if Assigned(FCoreIntf.DatabaseModules.Current) then
      with FCoreIntf.DatabaseModules.Current do begin
        if Assigned(Database) then
          Result:=Result and Database.ProviderExists(FDataSet.ProviderName);
      end;
  end;
end;

procedure TSgtsDataGridFrame.Refresh;
begin
  if CanRefresh then begin
    Screen.Cursor:=crHourGlass;
    try
      CloseData;
      OpenData;
      UpdateButtons;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

function TSgtsDataGridFrame.CanInsert: Boolean;
begin
  Result:=Assigned(FInsertClass) and
          FDataSet.Active;
end;

procedure TSgtsDataGridFrame.Insert;
var
  AIface: TSgtsDataInsertIface;
begin
  if CanInsert then begin
    AIface:=FInsertClass.Create(FCoreIntf,Self);
    FIfaces.Add(AIface);
    AIface.DisableSet:=true;
    AIface.Init;
    AIface.BeforeReadParams;
    AIface.ReadParams;
    AIface.DatabaseLink;
    AIface.ShowModal;
  end;
end;

function TSgtsDataGridFrame.CanUpdate: Boolean;
begin
  Result:=Assigned(FUpdateClass) and
          FDataSet.Active and
          not FDataSet.IsEmpty;
end;

procedure TSgtsDataGridFrame.Update;
var
  AIface: TSgtsDataUpdateIface;
begin
  if CanUpdate then begin
    AIface:=FUpdateClass.Create(FCoreIntf,Self);
    FIfaces.Add(AIface);
    AIface.Init;
    AIface.ReadParams;
    AIface.DatabaseLink;
    AIface.ShowModal;
  end;
end;

function TSgtsDataGridFrame.CanDelete: Boolean;
begin
  Result:=Assigned(FDeleteClass) and
          FDataSet.Active and
          not FDataSet.IsEmpty;
end;

procedure TSgtsDataGridFrame.Delete;
var
  AIface: TSgtsDataDeleteIface;
begin
  if CanDelete then begin
    AIface:=FDeleteClass.Create(FCoreIntf,Self);
    FIfaces.Add(AIface);
    with AIface do begin
      Init;
      ReadParams;
      Sync;
      Show;
    end;  
  end;
end;

function TSgtsDataGridFrame.CanCopy: Boolean;
begin
  Result:=false;
end;

procedure TSgtsDataGridFrame.Copy;
begin
end;

function TSgtsDataGridFrame.CanFirst: Boolean;
begin
  Result:=FDataSet.Active and
          not FDataSet.IsEmpty and
          not FDataSet.Bof;
end;

procedure TSgtsDataGridFrame.First;
begin
end;

function TSgtsDataGridFrame.CanPrior: Boolean;
begin
  Result:=CanFirst;
end;

procedure TSgtsDataGridFrame.Prior;
begin
end;

function TSgtsDataGridFrame.CanNext: Boolean;
begin
  Result:=CanLast;
end;

procedure TSgtsDataGridFrame.Next;
begin
end;

function TSgtsDataGridFrame.CanLast: Boolean;
begin
  Result:=FDataSet.Active and
          not FDataSet.IsEmpty and
          not FDataSet.Eof;
end;

procedure TSgtsDataGridFrame.Last;
begin
end;

function TSgtsDataGridFrame.CanSelect: Boolean;
begin
  Result:=false;
end;

function TSgtsDataGridFrame.CanDetail: Boolean;
begin
  Result:=false;
end;

procedure TSgtsDataGridFrame.Detail;
begin
end;

function TSgtsDataGridFrame.CanReport: Boolean;
begin
  Result:=false;
end;

procedure TSgtsDataGridFrame.Report;
begin

end;

function TSgtsDataGridFrame.CanInfo: Boolean;
begin
  Result:=FDataSet.Active and
          not FDataSet.IsEmpty and
          FIface.PermissionExists(SPermissionNameInfo);
end;

procedure TSgtsDataGridFrame.Info;
begin
  if CanInfo then begin
    ShowInfo(FDataSet.GetInfo);
  end;
end;

procedure TSgtsDataGridFrame.ToolButtonRefreshClick(Sender: TObject);
begin
  Refresh;
end;

procedure TSgtsDataGridFrame.ToolButtonInsertClick(Sender: TObject);
begin
  Insert;
end;

procedure TSgtsDataGridFrame.ToolButtonUpdateClick(Sender: TObject);
begin
  Update;
end;

procedure TSgtsDataGridFrame.ToolButtonDeleteClick(Sender: TObject);
begin
  Delete;
end;

procedure TSgtsDataGridFrame.PopupMenuViewPopup(Sender: TObject);
begin
  UpdateButtons;
end;

end.
