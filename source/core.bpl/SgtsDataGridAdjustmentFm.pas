unit SgtsDataGridAdjustmentFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DbGrids, ComCtrls, CheckLst, Buttons, ImgList,
  Grids, DB, DBClient, 

  SgtsDialogFm, SgtsDbGrid, SgtsCoreIntf, SgtsSelectDefs,
  SgtsGetRecordsConfig, SgtsFm;
  
type
  TSgtsDataGridAdjustmentIface=class;

  TSgtsDataGridAdjustmentForm = class(TSgtsDialogForm)
    PageControl: TPageControl;
    TabSheetColumns: TTabSheet;
    PanelClientColumns: TPanel;
    PanelButtonColumns: TPanel;
    ButtonUpColumns: TBitBtn;
    ButtonDownColumns: TBitBtn;
    ButtonCheckAllColumns: TBitBtn;
    ButtonUnCheckAllColumns: TBitBtn;
    PanelCheckListBoxColumns: TPanel;
    CheckListBoxColumns: TCheckListBox;
    PanelBottomColumns: TPanel;
    ButtonDefaultColumns: TButton;
    TabSheetOrders: TTabSheet;
    PanelClientOrders: TPanel;
    PanelButtonOrders: TPanel;
    ButtonUpOrders: TBitBtn;
    ButtonDownOrders: TBitBtn;
    ButtonCheckAllOrders: TBitBtn;
    ButtonUnCheckAllOrders: TBitBtn;
    PanelCheckListBoxOrders: TPanel;
    CheckListBoxOrders: TCheckListBox;
    PanelBottomOrders: TPanel;
    ButtonDefaultOrders: TButton;
    LabelOrders: TLabel;
    ComboBoxOrders: TComboBox;
    ImageList: TImageList;
    CheckBoxColumnsAuto: TCheckBox;
    TabSheetFilters: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    ButtonUpFilters: TBitBtn;
    ButtonDownFilters: TBitBtn;
    ButtonCheckAllFilters: TBitBtn;
    ButtonUnCheckAllFilters: TBitBtn;
    Panel3: TPanel;
    CheckListBoxFilters: TCheckListBox;
    Panel4: TPanel;
    ButtonDefaultFilters: TButton;
    SplitterFilters1: TSplitter;
    DataSourceFilters: TDataSource;
    ClientDataSetFilters: TClientDataSet;
    ClientDataSetFiltersCONDITION: TStringField;
    ClientDataSetFiltersVALUE: TStringField;
    ClientDataSetFiltersOPERATOR: TStringField;
    SplitterFilters2: TSplitter;
    GroupBoxFilters: TGroupBox;
    PanelMemoFilters: TPanel;
    MemoFilters: TMemo;
    PanelGridFilters: TPanel;
    GridFilters: TDBGrid;
    PanelGridButtons: TPanel;
    ButtonAddFilter: TBitBtn;
    ButtonDeleteFilter: TBitBtn;
    procedure ButtonUpColumnsClick(Sender: TObject);
    procedure ButtonDownColumnsClick(Sender: TObject);
    procedure ButtonDefaultColumnsClick(Sender: TObject);
    procedure CheckListBoxColumnsClickCheck(Sender: TObject);
    procedure ButtonCheckAllColumnsClick(Sender: TObject);
    procedure ButtonUnCheckAllColumnsClick(Sender: TObject);
    procedure CheckListBoxColumnsMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBoxColumnsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure CheckListBoxColumnsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ButtonUpOrdersClick(Sender: TObject);
    procedure ButtonDownOrdersClick(Sender: TObject);
    procedure ButtonCheckAllOrdersClick(Sender: TObject);
    procedure ButtonUnCheckAllOrdersClick(Sender: TObject);
    procedure ComboBoxOrdersDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckListBoxOrdersClick(Sender: TObject);
    procedure ComboBoxOrdersChange(Sender: TObject);
    procedure ButtonDefaultOrdersClick(Sender: TObject);
    procedure ClientDataSetFiltersCONDITIONSetText(Sender: TField;
      const Text: String);
    procedure ClientDataSetFiltersOPERATORSetText(Sender: TField;
      const Text: String);
    procedure ButtonUpFiltersClick(Sender: TObject);
    procedure ButtonDownFiltersClick(Sender: TObject);
    procedure CheckListBoxFiltersClick(Sender: TObject);
    procedure CheckListBoxFiltersClickCheck(Sender: TObject);
    procedure GridFiltersExit(Sender: TObject);
    procedure ButtonCheckAllFiltersClick(Sender: TObject);
    procedure ButtonUnCheckAllFiltersClick(Sender: TObject);
    procedure ButtonDefaultFiltersClick(Sender: TObject);
    procedure CheckListBoxColumnsDblClick(Sender: TObject);
    procedure ButtonAddFilterClick(Sender: TObject);
    procedure ButtonDeleteFilterClick(Sender: TObject);
    procedure ClientDataSetFiltersVALUESetText(Sender: TField;
      const Text: String);
  private
    FFlagUpdateMemoFilters: Boolean;
    procedure GetColumns;
    procedure SetColumns;
    function GetSelectedIndex(CheckListBox: TCheckListBox): Integer;
    procedure MoveUp(CheckListBox: TCheckListBox);
    procedure MoveDown(CheckListBox: TCheckListBox);
    function GetIface: TSgtsDataGridAdjustmentIface;
    function FindDefByCaption(ACaption: String): TSgtsSelectDef;
    procedure CheckAll(CheckListBox: TCheckListBox);
    procedure UnCheckAll(CheckListBox: TCheckListBox; OneCheckedLeave: Boolean=true);
    procedure GetOrders;
    procedure SetOrders;
    procedure GetFilters;
    procedure SetFilters;
    procedure UpdateFiltersState;
    procedure RefreshDataSetFilters;
    function GetConditionByName(const S: String): TSgtsGetRecordsConfigFilterCondition;
    function GetFilterOperatorByName(const S: String): TSgtsGetRecordsConfigFilterOperator;
    function GetRealyValue(Def: TSgtsSelectDef; Value: String): Variant;
    procedure SaveFilter(FilterIndex: Integer);
    procedure UpdateFiltersEnabled;
    procedure UpdateMemoFilters;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    property Iface: TSgtsDataGridAdjustmentIface read GetIface;
  end;

  TSgtsDataGridAdjustmentIface=class(TSgtsDialogIface)
  private
    FGrid: TSgtsDbGrid;
    FSelectDefs: TSgtsSelectDefs;
    FOrders: TSgtsGetRecordsConfigOrders;
    FDefaultOrders: TSgtsGetRecordsConfigOrders;
    FAutoFitColumns: Boolean;
    FFilterGroups: TSgtsGetRecordsConfigFilterGroups;
    FDefaultFilterGroups: TSgtsGetRecordsConfigFilterGroups;
    function GetForm: TSgtsDataGridAdjustmentForm;
    function GetColumns: TDBGridColumns;
    procedure SetColumns(Value: TDBGridColumns);
    procedure SetOrders(Value: TSgtsGetRecordsConfigOrders);
    procedure SetFilterGroups(Value: TSgtsGetRecordsConfigFilterGroups);
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;

    property Columns: TDBGridColumns read GetColumns write SetColumns;
    property SelectDefs: TSgtsSelectDefs read FSelectDefs write FSelectDefs;
    property Orders: TSgtsGetRecordsConfigOrders read FOrders write SetOrders;
    property DefaultOrders: TSgtsGetRecordsConfigOrders read FDefaultOrders write FDefaultOrders;
    property AutoFitColumns: Boolean read FAutoFitColumns write FAutoFitColumns;
    property FilterGroups: TSgtsGetRecordsConfigFilterGroups read FFilterGroups write SetFilterGroups;
    property DefaultFilterGroups: TSgtsGetRecordsConfigFilterGroups read FDefaultFilterGroups write FDefaultFilterGroups;   

    property Form: TSgtsDataGridAdjustmentForm read GetForm;
  end;

var
  SgtsDataGridAdjustmentForm: TSgtsDataGridAdjustmentForm;

implementation

uses SgtsIface, SgtsUtils, SgtsConsts, SgtsDialogs;

{$R *.dfm}

{ TSgtsDataGridAdjustmentIface }

constructor TSgtsDataGridAdjustmentIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  StoredInConfig:=true;
  FGrid:=TSgtsDbGrid.Create(Self);
  FOrders:=TSgtsGetRecordsConfigOrders.Create;
  FFilterGroups:=TSgtsGetRecordsConfigFilterGroups.Create;
end;

destructor TSgtsDataGridAdjustmentIface.Destroy;
begin
  FFilterGroups.Free;
  FOrders.Free;
  inherited Destroy;
end;

procedure TSgtsDataGridAdjustmentIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsDataGridAdjustmentForm;
end;

function TSgtsDataGridAdjustmentIface.GetForm: TSgtsDataGridAdjustmentForm;
begin
  Result:=TSgtsDataGridAdjustmentForm(inherited Form);
end;

function TSgtsDataGridAdjustmentIface.GetColumns: TDBGridColumns;
begin
  Result:=FGrid.Columns;
end;

procedure TSgtsDataGridAdjustmentIface.SetColumns(Value: TDBGridColumns);
begin
  CopyGridColumns(Value,FGrid.Columns);
end;

procedure TSgtsDataGridAdjustmentIface.SetOrders(Value: TSgtsGetRecordsConfigOrders);
begin
  FOrders.CopyFrom(Value);
end;

procedure TSgtsDataGridAdjustmentIface.SetFilterGroups(Value: TSgtsGetRecordsConfigFilterGroups);
begin
  FFilterGroups.CopyFrom(Value);
end;

procedure TSgtsDataGridAdjustmentIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
end;

procedure TSgtsDataGridAdjustmentIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  Form.GetColumns;
  Form.GetOrders;
  Form.CheckBoxColumnsAuto.Checked:=FAutoFitColumns;
  Form.GetFilters;
end;

procedure TSgtsDataGridAdjustmentIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    Form.SetColumns;
    Form.SetOrders;
    FAutoFitColumns:=Form.CheckBoxColumnsAuto.Checked;
    Form.SetFilters;
  end;
end;

{ TSgtsDataGridAdjustmentForm }

type
  THackGrid=class(TCustomGrid)
  public
    property Options;
  end;

constructor TSgtsDataGridAdjustmentForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  PageControl.ActivePageIndex:=0;

  THackGrid(GridFilters).Options:=THackGrid(GridFilters).Options-[goColMoving];

  with GridFilters.Columns[0].PickList do begin
    Clear;
    Add(GetFilterOperatorName(foAnd));
    Add(GetFilterOperatorName(foOr));
  end;
  with GridFilters.Columns[1].PickList do begin
    Clear;
    Add(GetFilterConditionName(fcEqual));
    Add(GetFilterConditionName(fcGreater));
    Add(GetFilterConditionName(fcLess));
    Add(GetFilterConditionName(fcNotEqual));
    Add(GetFilterConditionName(fcEqualGreater));
    Add(GetFilterConditionName(fcEqualLess));
    Add(GetFilterConditionName(fcLike));
    Add(GetFilterConditionName(fcNotLike));
    Add(GetFilterConditionName(fcIsNull));
    Add(GetFilterConditionName(fcIsNotNull));
  end;

  FFlagUpdateMemoFilters:=true;
end;

destructor TSgtsDataGridAdjustmentForm.Destroy;
begin
  inherited Destroy;
end;

function TSgtsDataGridAdjustmentForm.GetIface: TSgtsDataGridAdjustmentIface;
begin
  Result:=TSgtsDataGridAdjustmentIface(inherited Iface);
end;

procedure TSgtsDataGridAdjustmentForm.GetColumns;
var
  i: Integer;
  Column: TColumn;
  Index: Integer;
begin
  if Assigned(Iface.Columns) then begin
    CheckListBoxColumns.Items.Clear;
    for i:=0 to Iface.Columns.Count-1 do begin
      Column:=Iface.Columns[i];
      Index:=CheckListBoxColumns.Items.AddObject(Column.Title.Caption,Column);
      CheckListBoxColumns.Checked[Index]:=Column.Visible;
    end;
  end;
end;

function TSgtsDataGridAdjustmentForm.FindDefByCaption(ACaption: String): TSgtsSelectDef;
var
  i: Integer;
begin
  Result:=nil;
  if Assigned(Iface.SelectDefs) then
    for i:=0 to Iface.SelectDefs.Count-1 do begin
      if AnsiSameText(Iface.SelectDefs.Items[i].Caption,ACaption) then begin
        Result:=Iface.SelectDefs.Items[i];
        exit;
      end;
    end;
end;

procedure TSgtsDataGridAdjustmentForm.SetColumns;
var
  i: Integer;
  Column: TColumn;
  Def: TSgtsSelectDef;
begin
  if Assigned(Iface.Columns) then begin
    for i:=0 to CheckListBoxColumns.Items.Count-1 do begin
      Column:=TColumn(CheckListBoxColumns.Items.Objects[i]);
      Column.Index:=i;
      if CheckListBoxColumns.Checked[i] then begin
        if not Column.Visible then begin
          Column.Visible:=true;
          Def:=FindDefByCaption(Column.Title.Caption);
          if Assigned(Def) then
            Column.Width:=Def.Width;
        end;
      end else begin
        Column.Visible:=false;
      end;
    end;
  end;   
end;

function TSgtsDataGridAdjustmentForm.GetSelectedIndex(CheckListBox: TCheckListBox): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to CheckListBox.Items.Count-1 do begin
    if CheckListBox.Selected[i] then begin
      Result:=i;
      exit;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.MoveUp(CheckListBox: TCheckListBox);
var
  Index: Integer;
begin
  Index:=GetSelectedIndex(CheckListBox);
  if Index>0 then begin
    CheckListBox.Items.Move(Index,Index-1);
    CheckListBox.ItemIndex:=Index-1;
  end;
  CheckListBox.SetFocus;
end;

procedure TSgtsDataGridAdjustmentForm.MoveDown(CheckListBox: TCheckListBox);
var
  Index: Integer;
begin
  Index:=GetSelectedIndex(CheckListBox);
  if (Index<>-1) and (Index<>CheckListBox.Items.Count-1) then begin
    CheckListBox.Items.Move(Index,Index+1);
    CheckListBox.ItemIndex:=Index+1;
  end;
  CheckListBox.SetFocus;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonUpColumnsClick(
  Sender: TObject);
begin
  MoveUp(CheckListBoxColumns);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDownColumnsClick(
  Sender: TObject);
begin
  MoveDown(CheckListBoxColumns);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDefaultColumnsClick(
  Sender: TObject);
begin
  if ShowQuestion(SThrowAdjustmentColumns,mbNo)=mrYes then begin
    if Assigned(Iface.Columns) and Assigned(Iface.SelectDefs) then
      CreateColumnsBySelectDefs(Iface.Columns,Iface.SelectDefs);
    GetColumns;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxColumnsClickCheck(
  Sender: TObject);
var
  i: Integer;
  CheckCount: Integer;
  Item: TSgtsGetRecordsConfigOrder;
begin
  CheckCount:=0;
  for i:=0 to TCheckListBox(Sender).Items.Count-1 do begin
    if TCheckListBox(Sender).Checked[i] then
     Inc(CheckCount);
  end;
  if (CheckCount=0) and (Sender=CheckListBoxColumns) then begin
    if TCheckListBox(Sender).Items.Count<>0 then
      TCheckListBox(Sender).Checked[TCheckListBox(Sender).ItemIndex]:=true;
    exit;
  end;

  if Sender=CheckListBoxOrders then begin
    if CheckListBoxOrders.ItemIndex<>-1 then begin
      Item:=TSgtsGetRecordsConfigOrder(CheckListBoxOrders.Items.Objects[CheckListBoxOrders.ItemIndex]);
      if CheckListBoxOrders.Checked[CheckListBoxOrders.ItemIndex] then begin
        if Item.OrderType=otDisable then
          Item.OrderType:=otAsc;
      end else begin
        Item.OrderType:=otDisable;
      end;
      CheckListBoxOrders.Invalidate;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.CheckAll(CheckListBox: TCheckListBox);
var
  i: Integer;
  Item: TSgtsGetRecordsConfigOrder;
begin
  for i:=0 to CheckListBox.Items.Count-1 do begin
    if CheckListBox.ItemEnabled[i] then
      CheckListBox.Checked[i]:=true;
    if CheckListBox=CheckListBoxOrders then begin
      Item:=TSgtsGetRecordsConfigOrder(CheckListBox.Items.Objects[i]);
      if Item.OrderType=otDisable then
        Item.OrderType:=otAsc;
    end;
  end;
  CheckListBox.Invalidate;
end;

procedure TSgtsDataGridAdjustmentForm.UnCheckAll(CheckListBox: TCheckListBox; OneCheckedLeave: Boolean=true);
var
  i: Integer;
  OneCheck: boolean;
  Item: TSgtsGetRecordsConfigOrder;
begin
  OneCheck:=false;
  for i:=0 to CheckListBox.Items.Count-1 do begin
    if CheckListBox.ItemEnabled[i] and CheckListBox.Checked[i] then begin
      if OneCheckedLeave then begin
        if OneCheck then
          CheckListBox.Checked[i]:=false
        else
          OneCheck:=true;
      end else
        CheckListBox.Checked[i]:=false;

      if CheckListBox=CheckListBoxOrders then begin
        Item:=TSgtsGetRecordsConfigOrder(CheckListBox.Items.Objects[i]);
        Item.OrderType:=otDisable;
      end;
    end;
  end;
  CheckListBox.Invalidate;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonCheckAllColumnsClick(
  Sender: TObject);
begin
  CheckAll(CheckListBoxColumns);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonUnCheckAllColumnsClick(
  Sender: TObject);
begin
  UnCheckAll(CheckListBoxColumns);
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxColumnsMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  if (Shift=[ssLeft]) then begin
    Index:=TCheckListBox(Sender).ItemAtPos(Point(X,Y),true);
    if Index<>-1 then begin
      if Index=TCheckListBox(Sender).ItemIndex then begin
        TCheckListBox(Sender).BeginDrag(true);
      end;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxColumnsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  Index: Integer;
begin
  Index:=TCheckListBox(Sender).ItemAtPos(Point(X,Y),true);
  if Index<>-1 then begin
    if Index<>TCheckListBox(Sender).ItemIndex then begin
      if TCheckListBox(Sender).ItemIndex=-1 then exit;
      TCheckListBox(Sender).Items.Move(TCheckListBox(Sender).ItemIndex,Index);
      TCheckListBox(Sender).ItemIndex:=Index;
    end;
  end;
  if Sender=CheckListBoxFilters then
    UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxColumnsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  Accept:=false;
  if Sender=Source then begin
    Index:=TCheckListBox(Sender).ItemAtPos(Point(X,Y),true);
    if Index<>-1 then begin
      if Index<>TCheckListBox(Sender).ItemIndex then begin
        Accept:=true;
      end;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonUpOrdersClick(Sender: TObject);
begin
  MoveUp(CheckListBoxOrders);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDownOrdersClick(
  Sender: TObject);
begin
  MoveDown(CheckListBoxOrders);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonCheckAllOrdersClick(
  Sender: TObject);
begin
  CheckAll(CheckListBoxOrders);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonUnCheckAllOrdersClick(
  Sender: TObject);
begin
  UnCheckAll(CheckListBoxOrders,false);
end;

procedure TSgtsDataGridAdjustmentForm.GetOrders;
var
  i: Integer;
  Item: TSgtsGetRecordsConfigOrder;
  Index: Integer;
begin
  if Assigned(Iface.Orders) then begin
    CheckListBoxOrders.Clear;
    for i:=0 to Iface.Orders.Count-1 do begin
      Item:=Iface.Orders.Items[i];
      Index:=CheckListBoxOrders.Items.AddObject(Item.Caption,Item);
      CheckListBoxOrders.Checked[Index]:=Item.OrderType in [otAsc,otDesc];
    end;
  end;
  LabelOrders.Enabled:=false;
  ComboBoxOrders.Color:=clBtnFace;
  ComboBoxOrders.Enabled:=false;
end;

procedure TSgtsDataGridAdjustmentForm.SetOrders;
var
  i: Integer;
  Item: TSgtsGetRecordsConfigOrder;
  NewItem: TSgtsGetRecordsConfigOrder;
  Temp: TSgtsGetRecordsConfigOrders;
begin
  if Assigned(Iface.Orders) then begin
    Temp:=TSgtsGetRecordsConfigOrders.Create;
    try
      for i:=0 to CheckListBoxOrders.Count-1 do begin
        Item:=TSgtsGetRecordsConfigOrder(CheckListBoxOrders.Items.Objects[i]);
        NewItem:=Temp.Add(Item.FieldName,Item.OrderType);
        if Assigned(NewItem) then
          NewItem.Caption:=Item.Caption;
      end;
      Iface.Orders.CopyFrom(Temp,true);
    finally
      Temp.Free;
    end;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.ComboBoxOrdersDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  OrderType: TSgtsGetRecordsConfigOrderType;
  ImageIndex: Integer;
  X,Y: Integer;
  s: string;
  Image: TBitmap;
  Canvas: TCanvas;
  Item: TSgtsGetRecordsConfigOrder;
begin
  if Control=ComboBoxOrders then begin
    OrderType:=TSgtsGetRecordsConfigOrderType(Index);
    Canvas:=ComboBoxOrders.Canvas;
    s:=ComboBoxOrders.Items.Strings[Index];
  end else begin
    Item:=TSgtsGetRecordsConfigOrder(CheckListBoxOrders.Items.Objects[Index]);
    OrderType:=Item.OrderType;
    Canvas:=CheckListBoxOrders.Canvas;
    s:=CheckListBoxOrders.Items.Strings[Index];
  end;

  if OrderType in [otDisable,otAsc,otDesc] then begin
    Image:=TBitmap.Create;
    try
      Canvas.FillRect(Rect);
      Image.Width:=ImageList.Width;
      Image.Height:=ImageList.Height;
      X:=Rect.Left;
      Y:=Rect.Top+((Rect.Bottom-Rect.Top) div 2)-(ImageList.Height div 2);
      if odSelected in State then begin
        ImageIndex:=Integer(OrderType);
      end else begin
        ImageIndex:=Integer(OrderType);
      end;
      ImageList.GetBitmap(ImageIndex,Image);
      Image.TransparentColor:=Canvas.Brush.Color;
      Image.Transparent:=true;
      Canvas.Draw(X,Y,Image);
      if Control=ComboBoxOrders then
        Y:=Rect.Top+((Rect.Bottom-Rect.Top) div 2)-(Canvas.TextHeight(s) div 2)-1
      else
        Y:=Rect.Top+((Rect.Bottom-Rect.Top) div 2)-(Canvas.TextHeight(s) div 2)-1;
      X:=X+ImageList.Width+1;
      Canvas.TextOut(X,Y,s);
    finally
      Image.Free;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxOrdersClick(
  Sender: TObject);
var  
  Item: TSgtsGetRecordsConfigOrder;
begin
  if CheckListBoxOrders.ItemIndex<>-1 then begin
    Item:=TSgtsGetRecordsConfigOrder(CheckListBoxOrders.Items.Objects[CheckListBoxOrders.ItemIndex]);
    if CheckListBoxOrders.Checked[CheckListBoxOrders.ItemIndex] then
      ComboBoxOrders.ItemIndex:=Integer(Item.OrderType)
    else ComboBoxOrders.ItemIndex:=Integer(otDisable);
    LabelOrders.Enabled:=true;
    ComboBoxOrders.Color:=clWindow;
    ComboBoxOrders.Enabled:=true;
  end else begin
    LabelOrders.Enabled:=false;
    ComboBoxOrders.Color:=clBtnFace;
    ComboBoxOrders.Enabled:=false;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.ComboBoxOrdersChange(
  Sender: TObject);
var
  Item: TSgtsGetRecordsConfigOrder;
begin
  if CheckListBoxOrders.ItemIndex<>-1 then begin
    if ComboBoxOrders.ItemIndex<>-1 then begin
      Item:=TSgtsGetRecordsConfigOrder(CheckListBoxOrders.Items.Objects[CheckListBoxOrders.ItemIndex]);
      Item.OrderType:=TSgtsGetRecordsConfigOrderType(ComboBoxOrders.ItemIndex);
      CheckListBoxOrders.Checked[CheckListBoxOrders.ItemIndex]:=Item.OrderType in [otAsc,otDesc];
      CheckListBoxOrders.Invalidate;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDefaultOrdersClick(
  Sender: TObject);
begin
  if ShowQuestion(SThrowAdjustmentOrders,mbNo)=mrYes then begin
    if Assigned(Iface.Orders) then
      Iface.Orders.CopyFrom(Iface.DefaultOrders);
    GetOrders;
    CheckListBoxOrdersClick(nil);
    CheckListBoxOrders.Invalidate;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.ClientDataSetFiltersOPERATORSetText(
  Sender: TField; const Text: String);
begin
  if GridFilters.Columns[0].PickList.IndexOf(Text)<>-1 then
    Sender.Value:=Text;
  if FFlagUpdateMemoFilters then begin
    SaveFilter(CheckListBoxFilters.ItemIndex);
    UpdateMemoFilters;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.ClientDataSetFiltersCONDITIONSetText(
  Sender: TField; const Text: String);
begin
  if GridFilters.Columns[1].PickList.IndexOf(Text)<>-1 then
    Sender.Value:=Text;
  if FFlagUpdateMemoFilters then begin
    SaveFilter(CheckListBoxFilters.ItemIndex);
    UpdateMemoFilters;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.GetFilters;
var
  i: Integer;
  Item: TSgtsGetRecordsConfigFilterGroup;
  Index: Integer;
begin
  if Assigned(Iface.FilterGroups) then begin
    CheckListBoxFilters.Clear;
    for i:=0 to Iface.FilterGroups.Count-1 do begin
      Item:=Iface.FilterGroups.Items[i];
      if Item.Visible then begin
        Index:=CheckListBoxFilters.Items.AddObject(Item.GroupName,Item);
        CheckListBoxFilters.Checked[Index]:=Item.Enabled;
        CheckListBoxFilters.ItemEnabled[Index]:=Item.Active;
      end;
    end;
  end;
  GridFilters.Color:=clBtnFace;
  GridFilters.Enabled:=false;
  ButtonAddFilter.Enabled:=false;
  ButtonDeleteFilter.Enabled:=false;
  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.SetFilters;
var
  i: Integer;
  Temp: TSgtsGetRecordsConfigFilterGroups;
  Item, NewItem: TSgtsGetRecordsConfigFilterGroup;
begin
  if Assigned(Iface.FilterGroups) then begin
    Temp:=TSgtsGetRecordsConfigFilterGroups.Create;
    try
      for i:=0 to Iface.FilterGroups.Count-1 do begin
        Item:=Iface.FilterGroups.Items[i];
        if not Item.Visible then begin
          NewItem:=Temp.Add(Item.Operator);
          NewItem.CopyFrom(Item);
        end;
      end; 
      for i:=0 to CheckListBoxFilters.Items.Count-1 do begin
        Item:=TSgtsGetRecordsConfigFilterGroup(CheckListBoxFilters.Items.Objects[i]);
        NewItem:=Temp.Add(Item.Operator);
        NewItem.CopyFrom(Item);
      end;
      Iface.FilterGroups.CopyFrom(Temp,true);
    finally
      Temp.Free;
    end;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.ButtonUpFiltersClick(Sender: TObject);
begin
  MoveUp(CheckListBoxFilters);
  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDownFiltersClick(
  Sender: TObject);
begin
  MoveDown(CheckListBoxFilters);
  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxFiltersClick(
  Sender: TObject);
begin
  RefreshDataSetFilters;
  UpdateFiltersState;
  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.UpdateFiltersState;
var
  Index: Integer;
begin
  Index:=CheckListBoxFilters.ItemIndex;
  if Index=-1 then begin
    GridFilters.Enabled:=false;
    GridFilters.Color:=clBtnFace;
    GridFilters.ReadOnly:=true;
    ButtonAddFilter.Enabled:=false;
    ButtonDeleteFilter.Enabled:=false;
  end else begin
    GridFilters.Enabled:=CheckListBoxFilters.Checked[Index] and CheckListBoxFilters.ItemEnabled[Index];
    GridFilters.Color:=iff(GridFilters.Enabled,clWindow,clBtnFace);
    GridFilters.ReadOnly:=not GridFilters.Enabled;
    ButtonAddFilter.Enabled:=GridFilters.Enabled;
    ButtonDeleteFilter.Enabled:=GridFilters.Enabled;
  end;
end;

function TSgtsDataGridAdjustmentForm.GetFilterOperatorByName(const S: String): TSgtsGetRecordsConfigFilterOperator;
begin
  Result:=foAnd;
  if AnsiSameText(S,'и') then Result:=foAnd;
  if AnsiSameText(S,'или') then Result:=foOr;
end;

function TSgtsDataGridAdjustmentForm.GetConditionByName(const S: String): TSgtsGetRecordsConfigFilterCondition;
begin
  Result:=fcEqual;
  if AnsiSameText(S,'=') then Result:=fcEqual;
  if AnsiSameText(S,'>') then Result:=fcGreater;
  if AnsiSameText(S,'<') then Result:=fcLess;
  if AnsiSameText(S,'<>') then Result:=fcNotEqual;
  if AnsiSameText(S,'>=') then Result:=fcEqualGreater;
  if AnsiSameText(S,'<=') then Result:=fcEqualLess;
  if AnsiSameText(S,'входит') then Result:=fcLike;
  if AnsiSameText(S,'не входит') then Result:=fcNotLike;
  if AnsiSameText(S,'пусто') then Result:=fcIsNull;
  if AnsiSameText(S,'не пусто') then Result:=fcIsNotNull;
end;

procedure TSgtsDataGridAdjustmentForm.RefreshDataSetFilters;
var
  Index: Integer;
  i: Integer;
  Item: TSgtsGetRecordsConfigFilterGroup;
  Filter: TSgtsGetRecordsConfigFilter;
begin
  Index:=CheckListBoxFilters.ItemIndex;
  if Index<>-1 then begin
    Item:=TSgtsGetRecordsConfigFilterGroup(CheckListBoxFilters.Items.Objects[Index]);
    if Assigned(Item) then begin
      FFlagUpdateMemoFilters:=false;
      ClientDataSetFilters.DisableControls;
      try
        ClientDataSetFilters.EmptyDataSet;
        for i:=0 to Item.Filters.Count-1 do begin
          Filter:=Item.Filters.Items[i];
          ClientDataSetFilters.Append;
          ClientDataSetFiltersOPERATOR.Value:=GetFilterOperatorName(Filter.Operator);
          ClientDataSetFiltersCONDITION.Value:=GetFilterConditionName(Filter.Condition);
          ClientDataSetFiltersVALUE.Value:=VarToStrDef(Filter.Value,'');
          ClientDataSetFilters.Post;
        end;
      finally
        ClientDataSetFilters.EnableControls;
        FFlagUpdateMemoFilters:=true;
      end;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxFiltersClickCheck(
  Sender: TObject);
var
  Index: Integer;
  Item: TSgtsGetRecordsConfigFilterGroup;
begin
  Index:=CheckListBoxFilters.ItemIndex;
  if Index<>-1 then begin
    Item:=TSgtsGetRecordsConfigFilterGroup(CheckListBoxFilters.Items.Objects[Index]);
    Item.Enabled:=CheckListBoxFilters.Checked[Index];
  end;
  UpdateFiltersState;
end;

function TSgtsDataGridAdjustmentForm.GetRealyValue(Def: TSgtsSelectDef; Value: String): Variant;
var
  Field: TField;
begin
  Result:=Null;
  Field:=Def.Field;
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

procedure TSgtsDataGridAdjustmentForm.SaveFilter(FilterIndex: Integer);
var
  Def: TSgtsSelectDef;
  Item: TSgtsGetRecordsConfigFilterGroup;
  Filter: TSgtsGetRecordsConfigFilter;
  Value: Variant;
  B: TBookmark;
begin
  if (FilterIndex<>-1) and
     Assigned(Iface.SelectDefs) then begin
    Item:=TSgtsGetRecordsConfigFilterGroup(CheckListBoxFilters.Items.Objects[FilterIndex]);
    Item.Filters.Clear;
    Def:=Iface.SelectDefs.FindByCaption(Item.GroupName);
    if Assigned(Def) then begin
      ClientDataSetFilters.DisableControls;
      B:=ClientDataSetFilters.GetBookmark;
      try
        ClientDataSetFilters.First;
        while not ClientDataSetFilters.Eof do begin
          Value:=GetRealyValue(Def,ClientDataSetFiltersVALUE.AsString);
          Filter:=Item.Filters.Add(Def.Name,GetConditionByName(ClientDataSetFiltersCONDITION.AsString),Value);
          Filter.Operator:=GetFilterOperatorByName(ClientDataSetFiltersOPERATOR.AsString);
          Filter.CheckCase:=false;
          Filter.RightSide:=true;
          Filter.LeftSide:=true;
          ClientDataSetFilters.Next;
        end;
      finally
        if Assigned(B) and ClientDataSetFilters.BookmarkValid(B) then
          ClientDataSetFilters.GotoBookmark(B);
        ClientDataSetFilters.EnableControls;
      end;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.GridFiltersExit(Sender: TObject);
begin
//  SaveFilter(CheckListBoxFilters.ItemIndex);
//  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.UpdateFiltersEnabled;
var
  i: Integer;
  Item: TSgtsGetRecordsConfigFilterGroup;
begin
  for i:=0 to CheckListBoxFilters.Items.Count-1 do begin
    Item:=TSgtsGetRecordsConfigFilterGroup(CheckListBoxFilters.Items.Objects[i]);
    Item.Enabled:=CheckListBoxFilters.Checked[i];
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.ButtonCheckAllFiltersClick(Sender: TObject);
begin
  CheckAll(CheckListBoxFilters);
  UpdateFiltersEnabled;
  UpdateFiltersState;
  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonUnCheckAllFiltersClick(
  Sender: TObject);
begin
  UnCheckAll(CheckListBoxFilters,false);
  UpdateFiltersEnabled;
  UpdateFiltersState;
  UpdateMemoFilters;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDefaultFiltersClick(
  Sender: TObject);
begin
  if ShowQuestion(SThrowAdjustmentFilters,mbNo)=mrYes then begin
    if Assigned(Iface.FilterGroups) then
      Iface.FilterGroups.CopyFrom(Iface.DefaultFilterGroups);
    ClientDataSetFilters.EmptyDataSet;
    GetFilters;
    UpdateFiltersState;
  end;  
end;

procedure TSgtsDataGridAdjustmentForm.CheckListBoxColumnsDblClick(
  Sender: TObject);
var
  Index: Integer;
  Column: TColumn;
  S: String;
begin
  Index:=CheckListBoxColumns.ItemIndex;
  if Index<>-1 then begin
    Column:=TColumn(CheckListBoxColumns.Items.Objects[Index]);
    S:=CheckListBoxColumns.Items.Strings[Index];
    if InputQuery(SCaptionColumn,SInputColumn,S) then begin
      if Trim(S)='' then begin
        ShowError(SColumnNameNotEmpty);
      end else begin
        CheckListBoxColumns.Items.Strings[Index]:=S;
        Column.Title.Caption:=S;
      end;
    end;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.UpdateMemoFilters;
var
  i: Integer;
  Temp: TSgtsGetRecordsConfigFilterGroups;
  Item, NewItem: TSgtsGetRecordsConfigFilterGroup;
begin
  Temp:=TSgtsGetRecordsConfigFilterGroups.Create;
  try
    for i:=0 to CheckListBoxFilters.Items.Count-1 do begin
      Item:=TSgtsGetRecordsConfigFilterGroup(CheckListBoxFilters.Items.Objects[i]);
      NewItem:=Temp.Add(Item.Operator);
      NewItem.CopyFrom(Item);
    end;
    MemoFilters.Lines.Text:=Temp.GetUserFilter;
  finally
    Temp.Free;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.ButtonAddFilterClick(
  Sender: TObject);
begin
  ClientDataSetFilters.Append;
  ClientDataSetFiltersOPERATOR.Value:=GetFilterOperatorName(foAnd);
  ClientDataSetFiltersCONDITION.Value:=GetFilterConditionName(fcEqual);
end;

procedure TSgtsDataGridAdjustmentForm.ButtonDeleteFilterClick(
  Sender: TObject);
begin
  if not ClientDataSetFilters.IsEmpty then begin
    ClientDataSetFilters.Delete;
    SaveFilter(CheckListBoxFilters.ItemIndex);
    UpdateMemoFilters;
  end;
end;

procedure TSgtsDataGridAdjustmentForm.ClientDataSetFiltersVALUESetText(
  Sender: TField; const Text: String);
begin
  Sender.Value:=Text;
  if FFlagUpdateMemoFilters then begin
    SaveFilter(CheckListBoxFilters.ItemIndex);
    UpdateMemoFilters;
  end;
end;

end.
