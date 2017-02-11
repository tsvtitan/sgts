unit SgtsPlanGraphFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids,
  SgtsFm, SgtsChildFm, SgtsCoreIntf, SgtsDatabaseCDS, SgtsProviders, ComCtrls,
  DBTables, ExtCtrls, ImgList, SgtsDataFm, ToolWin, SgtsCDS, SgtsDbGrid, Menus;

type
  TSgtsPlanGraphForm = class(TSgtsChildForm)
    PanelGraph: TPanel;
    ImageList: TImageList;
    DataSource: TDataSource;
    StatusBar: TStatusBar;
    PanelToolLeftBar: TPanel;
    PanelRightPG: TPanel;
    PanelYear: TPanel;
    PanelEditYear: TPanel;
    LabelYear: TLabel;
    ComboBoxYear: TComboBox;
    ToolBarYearRight: TToolBar;
    ToolButtonOk: TToolButton;
    PanelRigh: TPanel;
    GridPattern: TDBGrid;
    ToolBarYearLeft: TToolBar;
    ToolButtonRefrash: TToolButton;
    ToolButtonAddYear: TToolButton;
    ToolButtonDeleteYear: TToolButton;
    ToolButtonHome: TToolButton;
    ToolButtonUp: TToolButton;
    ToolButtonDown: TToolButton;
    ToolButtonEnd: TToolButton;
    PopupMenuSelectMonth: TPopupMenu;
    AllMonth: TMenuItem;
    Clear: TMenuItem;

    procedure GridPatternCellClick(Column: TColumn);
    procedure GridPatternDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

    procedure ToolButtonRefrashClick(Sender: TObject);
    procedure ToolButtonAddYearClick(Sender: TObject);
    procedure ToolButtonDeleteYearClick(Sender: TObject);
    procedure ToolButtonHomeClick(Sender: TObject);
    procedure ToolButtonUpClick(Sender: TObject);
    procedure ToolButtonDownClick(Sender: TObject);
    procedure ToolButtonEndClick(Sender: TObject);
    procedure ToolButtonOkClick(Sender: TObject);

    procedure ComboBoxYearSelect(Sender: TObject);
    procedure AllMonthClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure ComboBoxYearKeyPress(Sender: TObject; var Key: Char);
    procedure GridPatternKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBoxYearChange(Sender: TObject);
  private
    { Private declarations }
    FCoreIntf: ISgtsCore;
    FGridPlan: TSgtsDbGrid;
    FYearEndCycleClosed: array of Boolean;
    FReadOnly: Boolean;
    FCurrentYear: Integer;

    FDataSetGraph: TSgtsDatabaseCDS;	//DS Отображаемый в FGridPlan

    procedure UpdatePeriod;
    procedure UpdateButtons;
    function CanRefrash: Boolean;
    procedure Refrash;
    function CanDelete: Boolean;
    procedure DeleteYear;
    function CanOk: Boolean;
    procedure SaveYear;
    function CanAdd: Boolean;
    procedure AddNewYear;
    function CanNewYear: Boolean;

    function CanHome: Boolean;
    procedure MoveHome;
    procedure MoveUp;
    function CanEnd: Boolean;
    procedure MoveEnd;
    procedure MoveDown;

    function GetNewYear: Boolean;

    procedure CreateDataSetGraph; // Создание FDataSetGraph
    procedure FillComboBoxYear;
    procedure FillGridPlan;	//Заполнение FDataSetGraph

    procedure SetFieldDataSet(ADataSetChangeable: TSgtsDatabaseCDS; ADataSetConst:TSgtsDatabaseCDS; AFieldName: String);
    procedure CreateColumn(ACaption: String; AField: String; AWidth: Integer; AAlignment: TAlignment);
  public
    { Public declarations }
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
  end;

  TSgtsPlanGraphIface = class(TSgtsChildIface)
  public
    procedure Init; override;
  end;

var
  SgtsPlanGraphForm: TSgtsPlanGraphForm;

implementation

uses SgtsConsts, SgtsDatabaseIntf, SgtsSelectDefs,
     SgtsDialogs, SgtsGetRecordsConfig;

{$R *.dfm}

{TSgtsPlanGraphIface}

procedure TSgtsPlanGraphIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsPlanGraphForm;
  InterfaceName:='План график';
  MenuPath:=Format('Функции\%s',['План график']);
  MenuIndex:=1002;
  with Permissions do begin
    AddDefault(SPermissionNameShow);
  end;
end;

{ TSgtsPlanGraphForm }

constructor TSgtsPlanGraphForm.Create(ACoreIntf: ISgtsCore);
begin
	FCoreIntf:=ACoreIntf;
  inherited Create(ACoreIntf);
  FCurrentYear:=FCoreIntf.DatabaseConfig.Read('Year',Format('%s',['Year']),1);
  ComboBoxYear.Text:=IntToStr(FCurrentYear);
  //FYearEndCycleClosed:=IntegerArray
  FGridPlan:=TSgtsDbGrid.Create(Self);
  with FGridPlan do begin
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
    OnCellClick:=GridPatternCellClick;
    OnDrawColumnCell:= GridPatternDrawColumnCell;
    OnKeyDown:=GridPatternKeyDown;     
    TabOrder:=GridPattern.TabOrder;
    LocateEnabled:=true;
    PopupMenu:=GridPattern.PopupMenu;
    ColumnSortEnabled:=false;
    ColMoving:=false;
    AutoFit:=true;
    VisibleRowNumber:=true;

  end;

   GridPattern.Free;
   GridPattern:=nil;
   FGridPlan.DataSource:=DataSource;

   CreateColumn('Виды наблюдений','MEASURE_TYPE_NAME',300, taLeftJustify);
   CreateColumn('Периодичность','PERIOD',100, taCenter);
   CreateColumn('Янв.','JANUARY',30, taCenter);
   CreateColumn('Фев.','FEBRUARY',30, taCenter);
   CreateColumn('Мар.','MARCH',30, taCenter);
   CreateColumn('Апр.','APRIL',30, taCenter);
   CreateColumn('Май.','MAY',30, taCenter);
   CreateColumn('Июнь','JUNE',30, taCenter);
   CreateColumn('Июль','JULY',30, taCenter);
   CreateColumn('Авг.','AUGUST',30, taCenter);
   CreateColumn('Сен.','SEPTEMBER',30, taCenter);
   CreateColumn('Окт.','OKTOBER',30, taCenter);
   CreateColumn('Нояб','NOVEMBER',30, taCenter);
   CreateColumn('Дек.','DECEMBER',30, taCenter);

   CreateDataSetGraph;
   FillGridPlan;
   FillComboBoxYear;
   Refrash;
end;

destructor TSgtsPlanGraphForm.Destroy;
begin
  FDataSetGraph.Free;
  
  inherited Destroy;
end;

procedure TSgtsPlanGraphForm.CreateColumn(ACaption: string; AField: string;
								AWidth: Integer; AAlignment: TAlignment);
var
  Column: TColumn;
begin
   Column:=FGridPlan.Columns.Add; 
   Column.Title.Caption:=ACaption;
   Column.FieldName:=AField;
   Column.Alignment:=AAlignment;
   Column.Width:=AWidth;
end;

procedure TSgtsPlanGraphForm.CreateDataSetGraph;
begin
	FDataSetGraph:=TSgtsDatabaseCDS.Create(FCoreIntf);
  DataSource.DataSet:=FDataSetGraph;
	FDataSetGraph.FieldDefs.Add('MEASURE_TYPE_NAME', ftString, 100);
  FDataSetGraph.FieldDefs.Add('PERIOD', ftString, 20);
  FDataSetGraph.FieldDefs.Add('MEASURE_TYPE_ID', ftInteger);
  FDataSetGraph.FieldDefs.Add('PLANING', ftInteger);
  FDataSetGraph.FieldDefs.Add('JANUARY', ftInteger);
  FDataSetGraph.FieldDefs.Add('FEBRUARY', ftInteger);
  FDataSetGraph.FieldDefs.Add('MARCH', ftInteger);
  FDataSetGraph.FieldDefs.Add('APRIL', ftInteger);
  FDataSetGraph.FieldDefs.Add('MAY', ftInteger);
  FDataSetGraph.FieldDefs.Add('JUNE', ftInteger);
  FDataSetGraph.FieldDefs.Add('JULY', ftInteger);
  FDataSetGraph.FieldDefs.Add('AUGUST', ftInteger);
  FDataSetGraph.FieldDefs.Add('SEPTEMBER', ftInteger);
  FDataSetGraph.FieldDefs.Add('OKTOBER', ftInteger);
  FDataSetGraph.FieldDefs.Add('NOVEMBER', ftInteger);
  FDataSetGraph.FieldDefs.Add('DECEMBER', ftInteger);
  FDataSetGraph.CreateDataSet;
end;

procedure TSgtsPlanGraphForm.FillGridPlan();
var
  curID: Integer;
  haveSubItems: Boolean;
  FDataSetMTG: TSgtsDatabaseCDS;
begin
  FDataSetMTG:=TSgtsDatabaseCDS.Create(FCoreIntf);
  with FDataSetMTG do begin
    ProviderName:='S_MEASURE_TYPE_GRAPHS';
    with FDataSetMTG.SelectDefs do begin
      AddInvisible('MEASURE_TYPE_NAME');
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('JANUARY');
      AddInvisible('FEBRUARY');
      AddInvisible('MARCH');
      AddInvisible('APRIL');
      AddInvisible('MAY');
      AddInvisible('JUNE');
      AddInvisible('JULY');
      AddInvisible('AUGUST');
      AddInvisible('SEPTEMBER');
      AddInvisible('OKTOBER');
      AddInvisible('NOVEMBER');
      AddInvisible('DECEMBER');
      AddInvisible('PARENT_ID');
      AddInvisible('PRIORITY');
    end;
    FilterGroups.Clear;
    FilterGroups.Add.Filters.Add('YEAR',fcEqual,FCurrentYear);
    CheckProvider:=false;
    Close;
    Orders.Add('PRIORITY', otAsc);
    //PacketRecords:=1;
    Open;
    First;
  end;


  while not FDataSetMTG.Eof do begin
    if FDataSetMTG.FieldByName('PARENT_ID').AsInteger = 0 then begin
      FDataSetGraph.Append;
      SetFieldDataSet(FDataSetGraph,FDataSetMTG,'MEASURE_TYPE_NAME');
      FDataSetGraph.FieldByName('PLANING').AsInteger:=1;
      curID:=FDataSetMTG.FieldByName('MEASURE_TYPE_ID').AsInteger;
      FDataSetGraph.FieldByName('MEASURE_TYPE_ID').AsInteger:=curID;

      FDataSetMTG.First;
      haveSubItems:=false;

      while not FDataSetMTG.Eof do begin
      	if FDataSetMTG.FieldByName('PARENT_ID').AsInteger = curID then begin
          haveSubItems:=true;
        	FDataSetGraph.Append;
          FDataSetGraph.FieldByName('MEASURE_TYPE_NAME').AsString:='     ' + FDataSetMTG.FieldByName('MEASURE_TYPE_NAME').AsString;
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'MEASURE_TYPE_ID');
          FDataSetGraph.FieldByName('PLANING').AsInteger:=0;
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'JANUARY');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'FEBRUARY');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'MARCH');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'APRIL');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'MAY');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'JUNE');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'JULY');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'AUGUST');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'SEPTEMBER');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'OKTOBER');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'NOVEMBER');
          SetFieldDataSet(FDataSetGraph,FDataSetMTG,'DECEMBER');
          UpdatePeriod
        end;
        FDataSetMTG.Next;
      end;

      FDataSetMTG.First;
    	while not FDataSetMTG.Eof do begin
        if FDataSetMTG.FieldByName('MEASURE_TYPE_ID').AsInteger = curID then begin
          if not haveSubItems then begin
            FDataSetGraph.Edit;
            FDataSetGraph.FieldByName('PLANING').AsInteger:=0;
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'JANUARY');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'FEBRUARY');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'MARCH');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'APRIL');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'MAY');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'JUNE');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'JULY');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'AUGUST');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'SEPTEMBER');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'OKTOBER');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'NOVEMBER');
            SetFieldDataSet(FDataSetGraph,FDataSetMTG,'DECEMBER');
            UpdatePeriod;
            FDataSetGraph.UpdateRecord;
          end;
          Break;
        end;
        FDataSetMTG.Next;
      end;   
    end;
    FDataSetMTG.Next;
  end;
  FDataSetGraph.First;
  FDataSetMTG.Close;
  FDataSetMTG.Free;
end;

procedure TSgtsPlanGraphForm.FillComboBoxYear;
var
	i: Integer;
  currentYear:String;
  FDataSetYearPG: TSgtsDatabaseCDS;
begin
	FDataSetYearPG:=TSgtsDatabaseCDS.Create(FCoreIntf);
  with FDataSetYearPG do begin
    ProviderName:='S_PLAN_GRAPH_YEARS';
    with SelectDefs do begin
      Add('YEAR','Год планирования');
      Add('IS_CLOSE', 'Закрыт год или нет');
    end;
    CheckProvider:=false;
    Close;
  	Orders.Add('YEAR', otAsc);
    PacketRecords:=-1;
  	Open;
  end;

  FDataSetYearPG.First;
  currentYear:=ComboBoxYear.Text;
	ComboBoxYear.Items.Clear;
  SetLength(FYearEndCycleClosed,FDataSetYearPG.RecordCount);

  while not FDataSetYearPG.Eof do begin
  	i:= ComboBoxYear.Items.Add(FDataSetYearPG.FieldByName('YEAR').AsString);
    if currentYear = FDataSetYearPG.FieldByName('YEAR').AsString then
    	ComboBoxYear.ItemIndex:=i;
    FYearEndCycleClosed[i]:=StrToBool(FDataSetYearPG.FieldByName('IS_CLOSE').AsString);
    FDataSetYearPG.Next;
  end;
  if ComboBoxYear.ItemIndex=-1 then ComboBoxYear.ItemIndex:=0;  

  FDataSetYearPG.Close;
  FDataSetYearPG.Free;
end;

procedure TSgtsPlanGraphForm.SetFieldDataSet(ADataSetChangeable: TSgtsDatabaseCDS; ADataSetConst: TSgtsDatabaseCDS; AFieldName: String);
begin
	ADataSetChangeable.FieldByName(AFieldName).AsString:=
  ADataSetConst.FieldByName(AFieldName).AsString;
end;

procedure TSgtsPlanGraphForm.Refrash;
begin
	if FDataSetGraph.Active then
  	FDataSetGraph.Free;
  CreateDataSetGraph;
  FillComboBoxYear;
  GetNewYear;
  FGridPlan.Enabled:=false;
  if FCurrentYear<>-1 then begin
		FillGridPlan;
    FGridPlan.Enabled:=true;
  end;
  if (ComboBoxYear.ItemIndex=-1) or FYearEndCycleClosed[ComboBoxYear.ItemIndex] then FReadOnly:=true
  else	FReadOnly:=false;

  UpdateButtons;
  FGridPlan.Refresh;
  FCoreIntf.DatabaseConfig.Write('Year',Format('%s',['Year']),FCurrentYear);
end;

procedure TSgtsPlanGraphForm.UpdateButtons;
begin
  ToolButtonOk.Enabled:=CanOk;
  ToolButtonRefrash.Enabled:=CanRefrash;
  ToolButtonAddYear.Enabled:=CanAdd;
  ToolButtonDeleteYear.Enabled:=CanDelete;

  ToolButtonHome.Enabled:=CanHome;
  ToolButtonUp.Enabled:=CanHome;
  ToolButtonDown.Enabled:=CanEnd;
  ToolButtonEnd.Enabled:=CanEnd;
end;

procedure TSgtsPlanGraphForm.UpdatePeriod;
var
	countPeriod: Integer;
begin
	countPeriod:=0;
  if FDataSetGraph.FieldByName('JANUARY').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('FEBRUARY').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('MARCH').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('APRIL').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('MAY').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('JUNE').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('JULY').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('AUGUST').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('SEPTEMBER').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('OKTOBER').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('NOVEMBER').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if FDataSetGraph.FieldByName('DECEMBER').AsInteger=1 then
  	countPeriod:=countPeriod+1;
  if countPeriod=12 then begin
  	FDataSetGraph.FieldByName('PERIOD').AsString:= 'Ежемесячно';
  end else begin
	  if countPeriod=0 then begin
  		FDataSetGraph.FieldByName('PERIOD').AsString:= 'Ни разу за год';
    end else begin
  		FDataSetGraph.FieldByName('PERIOD').AsString:=IntToStr(countPeriod) +' раз в год';
     end;
  end; 
end;

function TSgtsPlanGraphForm.GetNewYear;
begin
	FCurrentYear:=-1;
  if ComboBoxYear.Text='' then begin
  	Result:=false;
    Exit;
  end;

	try
  	StrToInt(ComboBoxYear.Text);
  except
    on E: Exception do begin
      Result:=false;
      Exit;
    end;
  end;
  FCurrentYear:= StrToInt(ComboBoxYear.Text);
  if FCurrentYear<0 then begin
  	FCurrentYear:=-1;
    Result:=false;
    Exit;
  end;
  Result:=true;
end;

procedure TSgtsPlanGraphForm.AddNewYear;
var
	FDataSet: TSgtsDatabaseCDS;
begin
	if GetNewYear then begin
  	FDataSet:= TSgtsDatabaseCDS.Create(FCoreIntf);
    with FDataSet do begin
      ProviderName:='I_PLAN_GRAPH';
      with ExecuteDefs do begin
        AddValue('YEAR',FCurrentYear);
      end;
      CheckProvider:=false;
      Execute;
      if not ExecuteSuccess then
      ShowError('Невозможно добавить год планирования')
    end;
    FDataSet.Close;
    FDataSet.Free;
  end else begin
  	ShowError('Введите год');
  end;
end;

procedure TSgtsPlanGraphForm.SaveYear;
var
  i: Integer;
  FDataSetInsertPG: TSgtsDatabaseCDS;
begin
	if CanNewYear then begin
  	AddNewYear;
  end;

  if FCurrentYear<>-1 then begin
  	FDataSetInsertPG:= TSgtsDatabaseCDS.Create(FCoreIntf);
    with FDataSetInsertPG do begin
      ProviderName:='U_PLAN_GRAPH';
      FDataSetGraph.First;
      for i := 0 to FDataSetGraph.RecordCount - 1 do begin
        with ExecuteDefs do begin
          AddValue('YEAR',FCurrentYear);
          AddValue('MEASURE_TYPE_ID',FDataSetGraph.FieldByName('MEASURE_TYPE_ID').AsInteger);
          AddValue('JANUARY',FDataSetGraph.FieldByName('JANUARY').AsInteger);
          AddValue('FEBRUARY',FDataSetGraph.FieldByName('FEBRUARY').AsInteger);
          AddValue('MARCH',FDataSetGraph.FieldByName('MARCH').AsInteger);
          AddValue('APRIL',FDataSetGraph.FieldByName('APRIL').AsInteger);
          AddValue('MAY',FDataSetGraph.FieldByName('MAY').AsInteger);
          AddValue('JUNE',FDataSetGraph.FieldByName('JUNE').AsInteger);
          AddValue('JULY',FDataSetGraph.FieldByName('JULY').AsInteger);
          AddValue('AUGUST',FDataSetGraph.FieldByName('AUGUST').AsInteger);
          AddValue('SEPTEMBER',FDataSetGraph.FieldByName('SEPTEMBER').AsInteger);
          AddValue('OKTOBER',FDataSetGraph.FieldByName('OKTOBER').AsInteger);
          AddValue('NOVEMBER',FDataSetGraph.FieldByName('NOVEMBER').AsInteger);
          AddValue('DECEMBER',FDataSetGraph.FieldByName('DECEMBER').AsInteger);
        end;
        CheckProvider:=false;
        Execute;
        ExecuteDefs.Clear;
        if not ExecuteSuccess then
          ShowError('Невозможно изменить данные');
        FDataSetGraph.Next;
      end;
    end;
    if FDataSetInsertPG.ExecuteSuccess then
          ShowInfo('Данные сохранены');
    Refrash;
  end else begin
  	ShowError('Данные не сохранены');
  end;
  FGridPlan.SetFocus;
end;

procedure TSgtsPlanGraphForm.DeleteYear;
var
	FDataSetInsertPG: TSgtsDatabaseCDS; 
begin
  inherited;
  if not CanNewYear then begin
    FDataSetInsertPG:= TSgtsDatabaseCDS.Create(FCoreIntf);
    with FDataSetInsertPG do begin
      ProviderName:='D_PLAN_GRAPH';
      ExecuteDefs.AddValue('YEAR',FCurrentYear);
      CheckProvider:=false;
      Execute;
      ExecuteDefs.Clear;
      if not ExecuteSuccess then
        ShowError('Невозможно изменить данные');
    end;
  end;
end;


function TSgtsPlanGraphForm.CanNewYear;
var
	i: Integer;
begin
	Result:=true;
  for i := 0 to ComboBoxYear.Items.Count do begin
  	if ComboBoxYear.Items[i]=ComboBoxYear.Text then
      Result:=false;
  end;
end;

function TSgtsPlanGraphForm.CanRefrash;
begin
  Result:=Assigned(FDataSetGraph) and FDataSetGraph.CheckProvider;
end;

function TSgtsPlanGraphForm.CanOk;
begin
  Result:=not FReadOnly;
  if Result then Result:=CanRefrash;
end;

function TSgtsPlanGraphForm.CanDelete;
begin
  Result:=not FReadOnly;
  if Result then Result:=CanRefrash;
end;

function TSgtsPlanGraphForm.CanAdd;
begin
	Result:=false;
  if ComboBoxYear.Items.Count=0 then
  	Result:=true;
end;

function TSgtsPlanGraphForm.CanHome;
begin
	Result:=Assigned(FDataSetGraph) and FDataSetGraph.CheckProvider;
  if FDataSetGraph.RecNo=1 then Result:=false;
end;

function TSgtsPlanGraphForm.CanEnd;
begin
	Result:=Assigned(FDataSetGraph) and FDataSetGraph.CheckProvider;
  if FDataSetGraph.RecNo=FDataSetGraph.RecordCount then Result:=false;
end;


procedure TSgtsPlanGraphForm.MoveHome;
begin
	if CanHome then
    FDataSetGraph.First;
  UpdateButtons;
end;

procedure TSgtsPlanGraphForm.MoveUp;
begin
	if CanHome then
    FDataSetGraph.Prior;
  UpdateButtons;
end;

procedure TSgtsPlanGraphForm.MoveEnd;
begin
	if CanEnd then
    FDataSetGraph.Last;
  UpdateButtons;
end;

procedure TSgtsPlanGraphForm.MoveDown;
begin
	if CanEnd then
    FDataSetGraph.Next;
  UpdateButtons;
end;


procedure TSgtsPlanGraphForm.ToolButtonRefrashClick(Sender: TObject);
begin
  inherited;
  Refrash;
end;

procedure TSgtsPlanGraphForm.ToolButtonAddYearClick(Sender: TObject);
begin
  inherited;
	AddNewYear;
  Refrash;
end;

procedure TSgtsPlanGraphForm.ToolButtonDeleteYearClick(Sender: TObject);
begin
  inherited;
  DeleteYear;
  Refrash;
end;


procedure TSgtsPlanGraphForm.ToolButtonOkClick(Sender: TObject);
begin
  inherited;
  SaveYear;
end;

procedure TSgtsPlanGraphForm.ToolButtonHomeClick(Sender: TObject);
begin
  inherited;
	MoveHome;
end;

procedure TSgtsPlanGraphForm.ToolButtonUpClick(Sender: TObject);
begin
  inherited;
	MoveUp;
end;

procedure TSgtsPlanGraphForm.ToolButtonDownClick(Sender: TObject);
begin
  inherited;
	MoveDown;
end;

procedure TSgtsPlanGraphForm.ToolButtonEndClick(Sender: TObject);
begin
  inherited;
	MoveEnd;
end;

procedure TSgtsPlanGraphForm.ComboBoxYearSelect(Sender: TObject);
begin
  inherited;
  Refrash;
end;

procedure TSgtsPlanGraphForm.ClearClick(Sender: TObject);
begin
  inherited;
  if FDataSetGraph.FieldByName('PLANING').AsInteger = 0 then begin
    FDataSetGraph.Edit;
    FDataSetGraph.FieldByName('JANUARY').AsInteger:=0;
    FDataSetGraph.FieldByName('FEBRUARY').AsInteger:=0;
    FDataSetGraph.FieldByName('MARCH').AsInteger:=0;
    FDataSetGraph.FieldByName('APRIL').AsInteger:=0;
    FDataSetGraph.FieldByName('MAY').AsInteger:=0;
    FDataSetGraph.FieldByName('JUNE').AsInteger:=0;
    FDataSetGraph.FieldByName('JULY').AsInteger:=0;
    FDataSetGraph.FieldByName('AUGUST').AsInteger:=0;
    FDataSetGraph.FieldByName('SEPTEMBER').AsInteger:=0;
    FDataSetGraph.FieldByName('OKTOBER').AsInteger:=0;
    FDataSetGraph.FieldByName('NOVEMBER').AsInteger:=0;
    FDataSetGraph.FieldByName('DECEMBER').AsInteger:=0;
    UpdatePeriod;
    FDataSetGraph.UpdateRecord;
  end;
end;

procedure TSgtsPlanGraphForm.AllMonthClick(Sender: TObject);
begin
  inherited;
  if FDataSetGraph.FieldByName('PLANING').AsInteger = 0 then begin
    FDataSetGraph.Edit;
    FDataSetGraph.FieldByName('JANUARY').AsInteger:=1;
    FDataSetGraph.FieldByName('FEBRUARY').AsInteger:=1;
    FDataSetGraph.FieldByName('MARCH').AsInteger:=1;
    FDataSetGraph.FieldByName('APRIL').AsInteger:=1;
    FDataSetGraph.FieldByName('MAY').AsInteger:=1;
    FDataSetGraph.FieldByName('JUNE').AsInteger:=1;
    FDataSetGraph.FieldByName('JULY').AsInteger:=1;
    FDataSetGraph.FieldByName('AUGUST').AsInteger:=1;
    FDataSetGraph.FieldByName('SEPTEMBER').AsInteger:=1;
    FDataSetGraph.FieldByName('OKTOBER').AsInteger:=1;
    FDataSetGraph.FieldByName('NOVEMBER').AsInteger:=1;
    FDataSetGraph.FieldByName('DECEMBER').AsInteger:=1;
    UpdatePeriod;
    FDataSetGraph.UpdateRecord;
  end;
end;

procedure TSgtsPlanGraphForm.GridPatternCellClick(Column: TColumn);
var
  FieldName: String;
begin
  inherited;
  if FReadOnly then Exit;
  case Column.Field.Index of
    4: FieldName:='JANUARY';
    5: FieldName:='FEBRUARY';
    6: FieldName:='MARCH';
    7: FieldName:='APRIL';
    8: FieldName:='MAY';
    9: FieldName:='JUNE';
    10: FieldName:='JULY';
    11: FieldName:='AUGUST';
    12: FieldName:='SEPTEMBER';
    13: FieldName:='OKTOBER';
    14: FieldName:='NOVEMBER';
    15: FieldName:='DECEMBER';
   end;
  if (Column.Field.Index>=4) then begin
  	if FDataSetGraph.FieldByName('PLANING').AsInteger = 0 then begin
      FDataSetGraph.Edit;
    	if FDataSetGraph.FieldByName(FieldName).AsInteger = 1 then begin
      	FDataSetGraph.FieldByName(FieldName).AsInteger:=0;
    	end else begin
      	FDataSetGraph.FieldByName(FieldName).AsInteger:=1;
    	end;
      UpdatePeriod;
      FDataSetGraph.UpdateRecord;
  	end;
  end;

  if Column.Field.Index=1 then begin
   if FDataSetGraph.FieldByName('PLANING').AsInteger = 0 then begin
    	if FDataSetGraph.FieldByName('JANUARY').AsInteger = 1 then begin
      	ClearClick(nil);
    	end else begin
      	AllMonthClick(nil);
    	end;
  	end;
  end;      
  UpdateButtons;
end;         

procedure TSgtsPlanGraphForm.GridPatternDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  FieldName: String;
  NewRect: TRect;
begin
  inherited;
  		NewRect.Right:=Rect.Right;
      NewRect.Left:=Rect.Left;
      NewRect.Top:=Rect.Top+2;
      NewRect.Bottom:=Rect.Bottom-2;
   case Column.Field.Index of
    4: FieldName:='JANUARY';
    5: FieldName:='FEBRUARY';
    6: FieldName:='MARCH';
    7: FieldName:='APRIL';
    8: FieldName:='MAY';
    9: FieldName:='JUNE';
    10: FieldName:='JULY';
    11: FieldName:='AUGUST';
    12: FieldName:='SEPTEMBER';
    13: FieldName:='OKTOBER';
    14: FieldName:='NOVEMBER';
    15: FieldName:='DECEMBER';
   end;
   if Column.Field.Index>=4 then begin
     if FDataSetGraph.FieldByName('PLANING').AsInteger <> 1 then begin
     	if FDataSetGraph.FieldByName(FieldName).AsInteger = 1 then

        DrawFrameControl(FGridPlan.Canvas.Handle,NewRect,DFC_BUTTON,DFCS_CHECKED)
      else
        DrawFrameControl(FGridPlan.Canvas.Handle,NewRect,DFC_BUTTON,DFCS_BUTTONCHECK);
     end;
   end;
end;

procedure TSgtsPlanGraphForm.ComboBoxYearChange(Sender: TObject);
begin
  inherited;
    if (StrToInt(ComboBoxYear.Text)<> FCurrentYear) AND FReadOnly then begin
      ToolButtonOk.Enabled:=true;
    end
end;

procedure TSgtsPlanGraphForm.ComboBoxYearKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then SaveYear;
  if ((Key<'0') or (Key>'9')) and  (Key<>#8) and (Key<>#13)  then Key:=#0;

end;

procedure TSgtsPlanGraphForm.GridPatternKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (chr(Key)=' ') AND not FReadOnly then begin
  	GridPatternCellClick(FGridPlan.Columns[FGridPlan.SelectedIndex]);
  end;
end;

end.
