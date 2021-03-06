unit SgtsBaseReportFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, ToolWin, DB, ExtCtrls, Contnrs,
  frxClass, frxPreview,
  SgtsReportFm, SgtsBaseReportClasses, SgtsCoreIntf, SgtsFm,
  SgtsMenus, SgtsCDS;

type
  TSgtsBaseReportIface=class;
  
  TSgtsBaseReportForm = class(TSgtsReportForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    MenuReport: TMenuItem;
    PanelView: TPanel;
    ToolBar: TToolBar;
    ToolButtonPrint: TToolButton;
    ToolButtonExport: TToolButton;
    ToolButtonFind: TToolButton;
    ToolButtonScale: TToolButton;
    ToolButtonProperty: TToolButton;
    ToolButtonFirst: TToolButton;
    ToolButtonPrior: TToolButton;
    ToolButtonNext: TToolButton;
    ToolButtonLast: TToolButton;
    ImageList: TImageList;
    PopupMenuView: TPopupMenu;
    PopupMenuExport: TPopupMenu;
    PopupMenuScale: TPopupMenu;
    ToolButtonRefresh: TToolButton;
    ToolButtonUpdate: TToolButton;
    BevelStatus: TBevel;
    procedure ToolButtonPrintClick(Sender: TObject);
    procedure ToolButtonFindClick(Sender: TObject);
    procedure ToolButtonPropertyClick(Sender: TObject);
    procedure ToolButtonFirstClick(Sender: TObject);
    procedure ToolButtonPriorClick(Sender: TObject);
    procedure ToolButtonNextClick(Sender: TObject);
    procedure ToolButtonLastClick(Sender: TObject);
    procedure ToolButtonRefreshClick(Sender: TObject);
    procedure ToolButtonUpdateClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure PopupMenuViewPopup(Sender: TObject);
    procedure PopupMenuScalePopup(Sender: TObject);
  private
    FPreview: TSgtsBaseReportPreview;
    FReport: TSgtsBaseReport;
    FDataSet: TSgtsBaseReportDataSet;
    FReportLoaded: Boolean;
    FIsPrepared: Boolean;
    procedure UpdateButtons;
    procedure UpdateStatusBar;
    function GetIface: TSgtsBaseReportIface;
    procedure LoadReport;
    procedure ReportProgressStart(Sender: TfrxReport; ProgressType: TfrxProgressType; Progress: Integer);
    procedure ReportProgressStop(Sender: TfrxReport; ProgressType: TfrxProgressType; Progress: Integer);
    procedure ReportProgress(Sender: TfrxReport; ProgressType: TfrxProgressType; Progress: Integer);
    procedure CreatePopupMenuExport(MenuParent: TMenuItem);
    procedure MenuExportClick(Sender: TObject);
    procedure CreatePopupMenuScale(MenuParent: TMenuItem);
    procedure MenuScaleClick(Sender: TObject);
    procedure PreviewPageChanged(Sender: TfrxPreview; PageNo: Integer);
    function GetCheckedMenuCaption(MenuParent: TMenuItem): String;
  protected
    property IsPrepared: Boolean read FIsPrepared write FIsPrepared;
    property DataSet: TSgtsBaseReportDataSet read FDataSet;
    property Report: TSgtsBaseReport read FReport;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
    procedure Print;
    function CanPrint: Boolean;
    function CanExport: Boolean;
    procedure Find;
    function CanFind: Boolean;
    function CanScale: Boolean;
    procedure PropertyEdit;
    function CanPropertyEdit: Boolean;
    procedure First;
    function CanFirst: Boolean;
    procedure Prior;
    function CanPrior: Boolean;
    procedure Next;
    function CanNext: Boolean;
    procedure Last;
    function CanLast: Boolean;
    procedure Refresh;
    function CanRefresh: Boolean;
    procedure Update; reintroduce;
    function CanUpdate: Boolean;

    property Iface: TSgtsBaseReportIface read GetIface;
  end;

  TSgtsBaseReportIface=class(TSgtsReportIface)
  private
    FReportId: Variant;
    FDescription: String;
    FReportExists: Boolean;
    FInterfaces: TStringList;
    FDataSet: TSgtsCDS;
    FComponent: TComponent;
    function GetForm: TSgtsBaseReportForm;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init(AReportId: Variant; AName, ADescription, AInterfaces, AMenuPath: Variant;
                   AReportExists: Boolean; ADataSet: TSgtsCDS=nil; AComponent: TComponent=nil); reintroduce; virtual;
    procedure BeforeNeedShow(AForm: TSgtsForm); override;
    function CanShow: Boolean; override;
    procedure Show; override;
    function NeedShow: Boolean; override;

    property ReportId: Variant read FReportId;
    property Description: String read FDescription;
    property Interfaces: TStringList read FInterfaces;
    property ReportExists: Boolean read FReportExists;

    property DataSet: TSgtsCDS read FDataSet;
    property Form: TSgtsBaseReportForm read GetForm;
  end;

  TSgtsBaseReportIfaceClass=class of TSgtsBaseReportIface;

  TSgtsBaseReportIfaceClassInfo=class(TObject)
  private
    FReportClass: TSgtsBaseReportIfaceClass;
    FReportId: Variant;
    FDescription: String;
    FName: String;
  public
    property ReportClass: TSgtsBaseReportIfaceClass read FReportClass write FReportClass;
    property ReportId: Variant read FReportId write FReportId;
    property Name: String read FName write FName;
    property Description: String read FDescription write FDescription;
  end;

  TSgtsBaseReportIfaceClassInfos=class(TObjectList)
  private
    function GetItems(Index: Integer): TSgtsBaseReportIfaceClassInfo;
    procedure SetItems(Index: Integer; Value: TSgtsBaseReportIfaceClassInfo);
  public
    function AddByIface(AIface: TSgtsBaseReportIface): TSgtsBaseReportIfaceClassInfo;
    function FindIface(AName: String): TSgtsBaseReportIfaceClassInfo;
    property Items[Index: Integer]: TSgtsBaseReportIfaceClassInfo read GetItems write SetItems;
  end;

var
  SgtsBaseReportForm: TSgtsBaseReportForm;

implementation

uses TypInfo,
     frxDsgnIntf, frxUtils,
     SgtsDialogs, SgtsConsts, SgtsDatabaseCDS, SgtsGetRecordsConfig,
     SgtsProviderConsts, SgtsUtils, Math, SgtsIface;

{$R *.dfm}

{ TSgtsBaseReportIfaceClassInfos }

function TSgtsBaseReportIfaceClassInfos.GetItems(Index: Integer): TSgtsBaseReportIfaceClassInfo;
begin
  Result:=TSgtsBaseReportIfaceClassInfo(inherited Items[Index]);
end;

procedure TSgtsBaseReportIfaceClassInfos.SetItems(Index: Integer; Value: TSgtsBaseReportIfaceClassInfo);
begin
  inherited Items[Index]:=Value;
end;

function TSgtsBaseReportIfaceClassInfos.AddByIface(AIface: TSgtsBaseReportIface): TSgtsBaseReportIfaceClassInfo;
begin
  Result:=nil;
  if Assigned(AIface) then begin
    Result:=TSgtsBaseReportIfaceClassInfo.Create;
    Result.ReportClass:=TSgtsBaseReportIface;
    Result.ReportId:=AIface.ReportId;
    Result.Name:=AIface.InterfaceName;
    Result.Description:=AIface.Description;
    inherited Add(Result);
  end;
end;

function TSgtsBaseReportIfaceClassInfos.FindIface(AName: String): TSgtsBaseReportIfaceClassInfo;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if AnsiSameText(Items[i].Name,AName) then begin
      Result:=Items[i];
      exit;
    end;
  end;
end;

{ TSgtsBaseReportIface }

constructor TSgtsBaseReportIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FInterfaces:=TStringList.Create;
  FInterfaces.Sorted:=false;
end;

destructor TSgtsBaseReportIface.Destroy;
begin
  FInterfaces.Free;
  inherited Destroy;
end;

procedure TSgtsBaseReportIface.Init(AReportId: Variant; AName, ADescription, AInterfaces, AMenuPath: Variant;
                                    AReportExists: Boolean; ADataSet: TSgtsCDS=nil; AComponent: TComponent=nil);
begin
  inherited Init(VarToStrDef(AMenuPath,''));
  FormClass:=TSgtsBaseReportForm;
  InterfaceName:=VarToStrDef(AName,'');
  FDescription:=VarToStrDef(ADescription,'');
  FInterfaces.Text:=VarToStrDef(AInterfaces,'');
  FReportId:=AReportId;
  FReportExists:=AReportExists;
  FDataSet:=ADataSet;
  FComponent:=AComponent;
  with Permissions do begin
    AddDefault(SPermissionNameUpdate);
  end;
end;

function TSgtsBaseReportIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          FReportExists;
end;

procedure TSgtsBaseReportIface.Show;
begin
  inherited Show;
end;

function TSgtsBaseReportIface.GetForm: TSgtsBaseReportForm;
begin
  Result:=TSgtsBaseReportForm(inherited Form);
end;

procedure TSgtsBaseReportIface.BeforeNeedShow(AForm: TSgtsForm);
begin
  inherited BeforeNeedShow(AForm);
  Form.IsPrepared:=false;
  if Assigned(DataSet) then begin
    Form.DataSet.DataSet:=DataSet;
    Form.DataSet.Name:=DataSet.Name;
  end;
  Form.LoadReport;
  Form.Report.DeleteDataSets(Form.DataSet,True);
  Form.Report.UpdateDatabands;
  Form.Report.ReplaceByComponent(FComponent);
  Form.Refresh;
  Form.UpdateButtons;
  Form.UpdateStatusBar;
end;

function TSgtsBaseReportIface.NeedShow: Boolean;
begin
  Result:=inherited NeedShow;
  if Result then
    Result:=Form.IsPrepared;
end;

{ TSgtsBaseReportForm }

constructor TSgtsBaseReportForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FPreview:=TSgtsBaseReportPreview.Create(nil);
  FPreview.Parent:=PanelView;
  FPreview.Align:=alClient;
  FPreview.ZoomMode:=zmPageWidth;
  FPreview.PopupMenu:=PopupMenuView;
  FPreview.OnPageChanged:=PreviewPageChanged;

  FDataSet:=TSgtsBaseReportDataSet.Create(nil);

  FReport:=TSgtsBaseReport.Create(nil);
  FReport.InitByCore(ACoreIntf);
  FReport.Name:=SReport;
  FReport.Preview:=FPreview;
  FReport.OldStyleProgress:=true;
  FReport.EngineOptions.UseFileCache:=false;
  FReport.OnProgressStart:=ReportProgressStart;
  FReport.OnProgressStop:=ReportProgressStop;
  FReport.OnProgress:=ReportProgress;
  FReport.IniFile:=CoreIntf.Config.Read(SConfigSectionReportDesigner,SConfigParamIniFile,FReport.IniFile);
  if ExtractFilePath(FReport.IniFile)='' then
    FReport.IniFile:=ExtractFilePath(CoreIntf.CmdLine.FileName)+FReport.IniFile;
    
  FPreview.IniFile:=FReport.IniFile;
end;

destructor TSgtsBaseReportForm.Destroy;
begin
  FReport.Free;
  FDataSet.Free;
  FPreview.Free;
  inherited Destroy;
end;

procedure TSgtsBaseReportForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  MenuReport.Caption:=AIface.Caption;
  CreatePopupMenuExport(TMenuItem(PopupMenuExport.Items));
  CreatePopupMenuScale(TMenuItem(PopupMenuScale.Items));
  CreateMenuByToolBar(MenuReport,ToolBar);
  CreateMenuByToolBar(TMenuItem(PopupMenuView.Items),ToolBar);
end;

procedure TSgtsBaseReportForm.CreatePopupMenuExport(MenuParent: TMenuItem);
var
  i: Integer;
  Menu: TMenuItem;
  Item: TfrxExportFilterItem;
begin
  MenuParent.Clear;
  for i:=0 to frxExportFilters.Count-1 do begin
    Item:=frxExportFilters.Items[i];
    Menu:=TMenuItem.Create(MenuParent);
    Menu.Caption:=Item.Filter.GetDescription;
    Menu.Hint:=Menu.Caption;
    Menu.OnClick:=MenuExportClick;
    MenuParent.Add(Menu);
  end;
end;

procedure TSgtsBaseReportForm.MenuExportClick(Sender: TObject);
var
  Item: TfrxExportFilterItem;
begin
  if Sender is TMenuItem then begin
    with TMenuItem(Sender) do begin
      if MenuIndex in [0..frxExportFilters.Count-1] then begin
        Item:=frxExportFilters.Items[MenuIndex];
        FPreview.Export(Item.Filter);
      end;
    end;
  end;
end;

procedure TSgtsBaseReportForm.CreatePopupMenuScale(MenuParent: TMenuItem);

  procedure LocalAdd(ACaption: String; AChecked: Boolean=false; AHint: String='');
  var
    Menu: TMenuItem;
  begin
    Menu:=TMenuItem.Create(MenuParent);
    Menu.Caption:=ACaption;
    Menu.Hint:=iff(Trim(AHint)='',ACaption,AHint);
    Menu.RadioItem:=true;
    Menu.Checked:=AChecked;
    Menu.GroupIndex:=1;
    Menu.OnClick:=MenuScaleClick;
    MenuParent.Add(Menu);
  end;

begin
  MenuParent.Clear;
  LocalAdd('25%');
  LocalAdd('50%');
  LocalAdd('75%');
  LocalAdd('100%');
  LocalAdd('150%');
  LocalAdd('200%');
  LocalAdd('�������',false,'������� ��������');
  LocalAdd('�� ������',true,'�� ������ ��������');
end;

procedure TSgtsBaseReportForm.MenuScaleClick(Sender: TObject);
var
  s: String;
  Menu: TMenuItem;
  Mode: TfrxZoomMode;
begin
  if Sender is TMenuItem then begin
    Menu:=TMenuItem(Sender);
    Menu.Checked:=true;
    Mode:=zmDefault;
    case Menu.MenuIndex of
      0..5: Mode:=zmDefault;
      6: Mode:=zmWholePage;
      7: Mode:=zmPageWidth;
    end;
    case Mode of
      zmDefault: begin
        s:=Menu.Caption;
        if Pos('%', s) <> 0 then
          s[Pos('%', s)] := ' ';
        while Pos(' ', s) <> 0 do
          System.Delete(s, Pos(' ', s), 1);

        if s <> '' then
          FPreview.Zoom := frxStrToFloat(s) / 100;
      end;
    else
      FPreview.ZoomMode:=Mode;
    end;
    UpdateStatusBar;
  end;
end;

procedure TSgtsBaseReportForm.Print;
begin
  if CanPrint then begin
    FPreview.Print;
  end;
end;

function TSgtsBaseReportForm.CanPrint: Boolean;
begin
  Result:=FReportLoaded;
end;

function TSgtsBaseReportForm.CanExport: Boolean;
begin
  Result:=FReportLoaded and (PopupMenuExport.Items.Count>0);
end;

procedure TSgtsBaseReportForm.Find;
begin
  if CanFind then begin
    FPreview.Find;
  end;
end;

function TSgtsBaseReportForm.CanFind: Boolean;
begin
  Result:=FReportLoaded;
end;

function TSgtsBaseReportForm.CanScale: Boolean;
begin
  Result:=FReportLoaded and (PopupMenuScale.Items.Count>0);
end;

procedure TSgtsBaseReportForm.PropertyEdit;
begin
  if CanPropertyEdit then begin
    if Assigned(Iface.DataSet) then
      Iface.DataSet.BeginUpdate(true,true);
    try
      FPreview.PageSetupDlg;
    finally
      if Assigned(Iface.DataSet) then
        Iface.DataSet.EndUpdate;
    end;
  end;
end;

function TSgtsBaseReportForm.CanPropertyEdit: Boolean;
begin
  Result:=FReportLoaded;
end;

procedure TSgtsBaseReportForm.First;
begin
  if CanFirst then begin
    FPreview.First;
  end;
end;

function TSgtsBaseReportForm.CanFirst: Boolean;
begin
  Result:=FReportLoaded and (FPreview.PageNo>1);
end;

procedure TSgtsBaseReportForm.Prior;
begin
  if CanPrior then begin
    FPreview.Prior;
  end;
end;

function TSgtsBaseReportForm.CanPrior: Boolean;
begin
  Result:=FReportLoaded and (FPreview.PageNo>1);
end;

procedure TSgtsBaseReportForm.Next;
begin
  if CanNext then begin
    FPreview.Next;
  end;
end;

function TSgtsBaseReportForm.CanNext;
begin
  Result:=FReportLoaded and (FPreview.PageNo<FPreview.PageCount);
end;

procedure TSgtsBaseReportForm.Last;
begin
  if CanLast then begin
    FPreview.Last;
  end;
end;

function TSgtsBaseReportForm.CanLast;
begin
  Result:=FReportLoaded and (FPreview.PageNo<FPreview.PageCount);
end;

procedure TSgtsBaseReportForm.UpdateButtons;
begin
  ToolButtonRefresh.Enabled:=CanRefresh;
  ToolButtonPrint.Enabled:=CanPrint;
  ToolButtonUpdate.Enabled:=CanUpdate;
  ToolButtonExport.Enabled:=CanExport;
  ToolButtonFind.Enabled:=CanFind;
  ToolButtonScale.Enabled:=CanScale;
  ToolButtonProperty.Enabled:=CanPropertyEdit;
  ToolButtonFirst.Enabled:=CanFirst;
  ToolButtonPrior.Enabled:=CanPrior;
  ToolButtonNext.Enabled:=CanNext;
  ToolButtonLast.Enabled:=CanLast;
  UpdateMenuByButtons(MenuReport);
  UpdateMenuByButtons(TMenuItem(PopupMenuView.Items));
end;

function TSgtsBaseReportForm.GetCheckedMenuCaption(MenuParent: TMenuItem): String;
var
  i: Integer;
begin
  Result:='';
  for i:=0 to MenuParent.Count-1 do begin
    if MenuParent.Items[i].Checked then begin
      Result:=MenuParent.Items[i].Caption;
      exit;
    end;  
  end;
end;

procedure TSgtsBaseReportForm.UpdateStatusBar;
begin
  StatusBar.Panels.Items[0].Text:=Format(SPageFromPages,[FPreview.PageNo,FPreview.PageCount]);
  StatusBar.Panels.Items[1].Text:=Format(SScale,[GetCheckedMenuCaption(TMenuItem(PopupMenuScale.Items))]); 
end;

function TSgtsBaseReportForm.GetIface: TSgtsBaseReportIface;
begin
  Result:=TSgtsBaseReportIface(inherited Iface);
end;

procedure TSgtsBaseReportForm.LoadReport;
var
  DS: TSgtsDatabaseCDS;
  Stream: TMemoryStream;
  OldCursor: TCursor;
begin
  FReportLoaded:=false;
  if Iface.CanShow then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    DS:=TSgtsDatabaseCDS.Create(CoreIntf);
    try
      DS.ProviderName:=SProviderSelectBaseReports;
      DS.SelectDefs.AddInvisible(SDb_Report);
      DS.FilterGroups.Add.Filters.Add(SDb_BaseReportId,fcEqual,Iface.ReportId);
      DS.Open;
      if DS.Active and not DS.IsEmpty then begin
        Stream:=TMemoryStream.Create;
        try
          TBlobField(DS.FieldByName(SDb_Report)).SaveToStream(Stream);
          Stream.Position:=0;
          FReport.LoadFromStream(Stream);
          FReportLoaded:=true;
        finally
          Stream.Free;
        end;
      end; 
    finally
      DS.Free;
      Screen.Cursor:=OldCursor;
    end;
  end;
end;

procedure TSgtsBaseReportForm.ReportProgressStart(Sender: TfrxReport; ProgressType: TfrxProgressType; Progress: Integer);
begin
  If ProgressType<>ptRunning then
    CoreIntf.MainForm.Progress(0,FPreview.PageCount,Progress);
end;

procedure TSgtsBaseReportForm.ReportProgressStop(Sender: TfrxReport; ProgressType: TfrxProgressType; Progress: Integer);
begin
  If ProgressType<>ptRunning then
    CoreIntf.MainForm.Progress(0,FPreview.PageCount,Progress);
end;

procedure TSgtsBaseReportForm.ReportProgress(Sender: TfrxReport; ProgressType: TfrxProgressType; Progress: Integer);
begin
  If ProgressType<>ptRunning then
    CoreIntf.MainForm.Progress(0,FPreview.PageCount,Progress);
end;

procedure TSgtsBaseReportForm.ToolButtonPrintClick(Sender: TObject);
begin
  Print;
end;

procedure TSgtsBaseReportForm.ToolButtonFindClick(Sender: TObject);
begin
  Find;
end;

procedure TSgtsBaseReportForm.ToolButtonPropertyClick(Sender: TObject);
begin
  PropertyEdit;
end;

procedure TSgtsBaseReportForm.ToolButtonFirstClick(Sender: TObject);
begin
  First;
end;

procedure TSgtsBaseReportForm.ToolButtonPriorClick(Sender: TObject);
begin
  Prior;
end;

procedure TSgtsBaseReportForm.PreviewPageChanged(Sender: TfrxPreview; PageNo: Integer);
begin
  UpdateButtons;
  UpdateStatusBar;
end;

procedure TSgtsBaseReportForm.ToolButtonNextClick(Sender: TObject);
begin
  Next;
end;

procedure TSgtsBaseReportForm.ToolButtonLastClick(Sender: TObject);
begin
  Last;
end;

procedure TSgtsBaseReportForm.Refresh;
begin
  if CanRefresh then begin
    if Assigned(Iface.DataSet) then
      Iface.DataSet.BeginUpdate(true,true);
    try
      First;
      if not FIsPrepared then
        FIsPrepared:=FReport.PrepareReport(true)
      else begin
        FPreview.RefreshReport;
      end;
    finally
      if Assigned(Iface.DataSet) then
        Iface.DataSet.EndUpdate;
    end;   
  end;
end;

function TSgtsBaseReportForm.CanRefresh: Boolean;
begin
  Result:=FReportLoaded;
end;

procedure TSgtsBaseReportForm.ToolButtonRefreshClick(Sender: TObject);
begin
  Refresh;
end;

procedure TSgtsBaseReportForm.Update;
begin
  if CanUpdate then begin
    FPreview.Edit;
  end;
end;

function TSgtsBaseReportForm.CanUpdate: Boolean;
begin
  Result:=FReportLoaded and
          Iface.PermissionExists(SPermissionNameUpdate);
end;

procedure TSgtsBaseReportForm.ToolButtonUpdateClick(Sender: TObject);
begin
  Update;
end;

procedure TSgtsBaseReportForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Pt: TPoint;  
begin
  if Shift=[] then begin
    case Key of
      VK_F5: Refresh;
      VK_RETURN: Update;
      VK_PRIOR: Prior;
      VK_NEXT: Next;
      VK_UP: begin
        FPreview.MouseWheelScroll(ReportPreviewDelta);
      end;
      VK_DOWN: begin
        FPreview.MouseWheelScroll(-ReportPreviewDelta);
      end;
    end;
  end;  
  if ssCtrl in Shift then begin
    case Key of
      Byte('p'),Byte('P'),Byte('�'),Byte('�'): Print;
      Byte('f'),Byte('F'),Byte('�'),Byte('�'): Find;
      VK_HOME: First;
      VK_END: Last;
    end;
  end;
  if ssShift in Shift then begin
    case Key of
      VK_F10: begin
        Pt:=FPreview.ClientToScreen(Point(FPreview.Left,FPreview.Top));
        PopupMenuView.Popup(Pt.X,Pt.Y);
      end;  
    end;
  end;
end;

procedure TSgtsBaseReportForm.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  FPreview.MouseWheelScroll(WheelDelta, False, ssCtrl in Shift);
end;

procedure TSgtsBaseReportForm.PopupMenuViewPopup(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TSgtsBaseReportForm.PopupMenuScalePopup(Sender: TObject);
begin
  //

end;

end.
