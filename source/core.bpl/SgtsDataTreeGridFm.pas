unit SgtsDataTreeGridFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin, DBGrids,
  SgtsDataTreeFm, SgtsDbGrid, SgtsFm, SgtsCDS,
  SgtsDataTreeGridFmIntf, SgtsCoreIntf, StdCtrls;

type
  TSgtsDataTreeGridIface=class;

  TSgtsDataTreeGridForm = class(TSgtsDataTreeForm)
    PanelTree: TPanel;
    Splitter: TSplitter;
    PanelGrid: TPanel;
    DataSourceGrid: TDataSource;
  private
    FGrid: TSgtsDbGrid;
    procedure GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
    function GetIface: TSgtsDataTreeGridIface;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    procedure InitByIface(AIface: TSgtsFormIface); override;

    property Iface: TSgtsDataTreeGridIface read GetIface;
    property Grid: TSgtsDbGrid read FGrid;
  end;

  TSgtsDataTreeGridIface=class(TSgtsDataTreeIface,ISgtsDataTreeGridForm)
  private
    FDataSetGrid: TSgtsCDS;
    function GetDataSetTree: TSgtsCDS;
  protected
    function GetFormClass: TSgtsFormClass; override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;

    property DataSetGrid: TSgtsCDS read FDataSetGrid;
    property DataSetTree: TSgtsCDS read GetDataSetTree;
  end;

var
  SgtsDataTreeGridForm: TSgtsDataTreeGridForm;

implementation

{$R *.dfm}

{ TSgtsDataTreeGridIface }

constructor TSgtsDataTreeGridIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDataSetGrid:=TSgtsCDS.Create(nil);
end;

destructor TSgtsDataTreeGridIface.Destroy;
begin
  FDataSetGrid.Free;
  inherited Destroy;
end;

procedure TSgtsDataTreeGridIface.Init;
begin
  inherited Init;
end;

function TSgtsDataTreeGridIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsDataTreeGridForm;
end;

function TSgtsDataTreeGridIface.GetDataSetTree: TSgtsCDS;
begin
  Result:=inherited DataSet;
end;

{ TSgtsDataTreeGridForm }

constructor TSgtsDataTreeGridForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  Tree.Parent:=PanelTree;

  FGrid:=TSgtsDbGrid.Create(Self);
  with FGrid do begin
    Parent:=PanelGrid;
    Align:=alClient;
    RowSelected.Font:=Font;
    CellSelected.Font:=Font;
    TitleCellMouseDown.Font:=Font;
    Options:=Options-[dgEditing]-[dgTabs];
    OnTitleClickWithSort:=GridTitleClickWithSort;
    TabOrder:=0;
    LocateEnabled:=true;
    PopupMenu:=PopupMenuView;
    ColumnSortEnabled:=true;
  end;
  FGrid.DataSource:=DataSourceGrid;
end;

procedure TSgtsDataTreeGridForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  DataSourceGrid.DataSet:=TSgtsDataTreeGridIface(Iface).DataSetGrid;
end;

function TSgtsDataTreeGridForm.GetIface: TSgtsDataTreeGridIface;
begin
  Result:=TSgtsDataTreeGridIface(inherited Iface);
end;

procedure TSgtsDataTreeGridForm.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  NewTypeSort: TSgtsTypeSort;
  NewFieldName: string;
begin
  with Iface do begin
    if DataSetGrid.Active and not DataSetGrid.IsEmpty then begin
      Screen.Cursor:=crHourGlass;
      try
        NewTypeSort:=tsNone;
        NewFieldName:=Column.FieldName;
        case TypeSort of
          tcsNone: NewTypeSort:=tsNone;
          tcsAsc: NewTypeSort:=tsAsc;
          tcsDesc: NewTypeSort:=tsDesc;
        end;
        DataSetGrid.SetIndexBySort(NewFieldName,NewTypeSort);
      finally
        FGrid.UpdateRowNumber;
        Screen.Cursor:=crDefault;
      end;
    end;
  end;  
end;

end.
