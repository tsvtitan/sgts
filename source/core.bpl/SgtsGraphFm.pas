unit SgtsGraphFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,  ExtCtrls, ToolWin, ImgList, Menus, Contnrs,
  SgtsChildFm, SgtsFm, SgtsGraphRefreshFm, SgtsGraphAdjustFm, SgtsBaseReportFm,
  SgtsCDS, SgtsDatabaseCDS,
  SgtsGraphIfaceIntf, SgtsCoreIntf,
  SgtsMenus;

type
  TSgtsGraphIface=class;

  TSgtsGraphForm = class(TSgtsChildForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    MenuGraph: TMenuItem;
    ImageList: TImageList;
    ToolBar: TToolBar;
    ToolButtonRefresh: TToolButton;
    ToolButtonReport: TToolButton;
    ToolButtonSave: TToolButton;
    ToolButtonAdjust: TToolButton;
    PanelView: TPanel;
    PopupMenuView: TPopupMenu;
    PopupMenuReport: TPopupMenu;
    procedure ToolButtonRefreshClick(Sender: TObject);
    procedure ToolButtonReportClick(Sender: TObject);
    procedure ToolButtonSaveClick(Sender: TObject);
    procedure ToolButtonAdjustClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PopupMenuViewPopup(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetIface: TSgtsGraphIface;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  protected
    function GetAdjustPersistent: TPersistent; virtual;
    function GetAdjustControl: TControl; virtual;
  public
    destructor Destroy; override;
    property AdjustPersistent: TPersistent read GetAdjustPersistent;
    property AdjustControl: TControl read GetAdjustControl;
    property Iface: TSgtsGraphIface read GetIface;
  end;

  TSgtsGraphIfaces=class(TObjectList)
  end;

  TSgtsGraphIface=class(TSgtsChildIface,ISgtsGraphIface)
  private
    FIfaces: TSgtsGraphIfaces;
    FRefreshIface: TSgtsGraphRefreshIface;
    FRefreshClass: TSgtsGraphRefreshIfaceClass;
    FReportClassInfos: TSgtsBaseReportIfaceClassInfos;
    FAdjustIface: TSgtsGraphAdjustIface;
    FRefreshSelected: Boolean;
    FDataSets: TSgtsDatabaseCDSs;
    FCancelProgress: Boolean;
    FInProgress: Boolean;

    function GetForm: TSgtsGraphForm;
    procedure SetRefreshClass(Value: TSgtsGraphRefreshIfaceClass);
    procedure CreatePopupMenuReport(MenuParent: TMenuItem);
    procedure UpdatePopupMenuReport(MenuParent: TMenuItem);
    procedure MenuItemReportClick(Sender: TObject);
    procedure DataSetProgressProc(Min,Max,Position: Integer; var Breaked: Boolean);
  protected
    function GetFormClass: TSgtsFormClass; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;

    property Ifaces: TSgtsGraphIfaces read FIfaces;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure InitByCore(ACoreIntf: ISgtsCore); override;
    procedure DatabaseLink; override;
    function CanShow: Boolean; override;
    procedure Show; override;
    procedure Hide; override;
    procedure UpdateContents; override;
    function NeedShow: Boolean; override;
    procedure BeforeNeedShow(AForm: TSgtsForm); override;

    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;

    procedure BeforeReadParams; override;
    procedure BeforeWriteParams; override;

    procedure UpdateButtons; virtual;
    procedure UpdateStatusbar; virtual;

    procedure CloseDataSets; virtual;
    procedure OpenDataSets; virtual;

    function CanRefresh: Boolean; virtual;
    procedure Refresh; virtual;
    function CanReport: Boolean; virtual;
    procedure Report; virtual;
    function CanSave: Boolean; virtual;
    procedure Save; virtual;
    function CanAdjust: Boolean; virtual;
    procedure Adjust; virtual;

    function CreateDataSet(ProviderName: String=''): TSgtsDatabaseCDS;

    property Form: TSgtsGraphForm read GetForm;
    property RefreshIface: TSgtsGraphRefreshIface read FRefreshIface; 
    property RefreshClass: TSgtsGraphRefreshIfaceClass read FRefreshClass write SetRefreshClass;
    property RefreshSelected: Boolean read FRefreshSelected; 
    property ReportClassInfos: TSgtsBaseReportIfaceClassInfos read FReportClassInfos;
    property AdjustIface: TSgtsGraphAdjustIface read FAdjustIface;
    property DataSets: TSgtsDatabaseCDSs read FDataSets;
    property CancelProgress: Boolean read FCancelProgress write FCancelProgress;
    property InProgress: Boolean read FInProgress write FInProgress;
  end;

var
  SgtsGraphForm: TSgtsGraphForm;

implementation

uses SgtsConsts, SgtsIface, SgtsUtils;

{$R *.dfm}

type
  TSgtsMenuItemReport=class(TMenuItem)
  private
    FReportClassInfo: TSgtsBaseReportIfaceClassInfo;
  public
    property ReportClassInfo: TSgtsBaseReportIfaceClassInfo read FReportClassInfo write FReportClassInfo;
  end;

{ TSgtsGraphIface }

constructor TSgtsGraphIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDataSets:=TSgtsDatabaseCDSs.Create;
  FIfaces:=TSgtsGraphIfaces.Create;
  FReportClassInfos:=TSgtsBaseReportIfaceClassInfos.Create;
  FAdjustIface:=TSgtsGraphAdjustIface.Create(ACoreIntf);
  FAdjustIface.Init;
end;

destructor TSgtsGraphIface.Destroy;
begin
  FreeAndNil(FAdjustIface);
  FReportClassInfos.Free;
  FIfaces.Free;
  FDataSets.Free;
  inherited Destroy;
end;

function TSgtsGraphIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsGraphForm;
end;

function TSgtsGraphIface.GetForm: TSgtsGraphForm;
begin
  Result:=TSgtsGraphForm(inherited Form);
end;

procedure TSgtsGraphIface.SetRefreshClass(Value: TSgtsGraphRefreshIfaceClass);
begin
  if Assigned(FRefreshIface) then begin
    FIfaces.Remove(FRefreshIface);
    FRefreshIface:=nil;
  end;  
  FRefreshClass:=Value;
  if Assigned(Value) then begin
    if not Assigned(FRefreshIface) then begin
      FRefreshIface:=FRefreshClass.Create(CoreIntf,Self);
      FIfaces.Add(FRefreshIface);
      FRefreshIface.Init;
    end;
  end;
end;

procedure TSgtsGraphIface.Init;
begin
  inherited Init;
  with Permissions do begin
    AddDefault(SPermissionNameShow);
  end;
end;

procedure TSgtsGraphIface.InitByCore(ACoreIntf: ISgtsCore);
var
  i: Integer; 
begin
  inherited InitByCore(ACoreIntf);
  for i:=0 to FDataSets.Count-1 do begin
     FDataSets.Items[i].InitByCore(ACoreIntf);
  end;
end;

procedure TSgtsGraphIface.DatabaseLink;
var
  AIface: TSgtsBaseReportIface;
  Str: TStringList;
  i: Integer;
  Index: Integer;
begin
  inherited DatabaseLink;
  Str:=TStringList.Create;
  try
    FReportClassInfos.Clear;
    Str.Sorted:=false;
    CoreIntf.GetInterfaceNames(Str,TSgtsBaseReportIface);
    for i:=0 to Str.Count-1 do begin
      AIface:=TSgtsBaseReportIface(Str.Objects[i]);
      if Assigned(AIface) and
         AIface.ReportExists then begin
        Index:=AIface.Interfaces.IndexOf(InterfaceName);
        if Index<>-1 then
          FReportClassInfos.AddByIface(AIface);
      end;
    end;
  finally
    Str.Free;
  end;
end;

procedure TSgtsGraphIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  Form.MenuGraph.Caption:=AForm.Caption;

end;

function TSgtsGraphIface.NeedShow: Boolean;
begin
  Result:=inherited NeedShow and
          FRefreshSelected;
end;

procedure TSgtsGraphIface.BeforeNeedShow(AForm: TSgtsForm);
var
  OldCursor: TCursor;
begin
  inherited BeforeNeedShow(AForm);
  FRefreshSelected:=false;
  if Assigned(FRefreshIface) then begin
    if FRefreshIface.ShowModal=mrOk then begin
      OldCursor:=Screen.Cursor;
      Screen.Cursor:=crHourGlass;
      try
        FRefreshSelected:=true;
        CloseDataSets;
        OpenDataSets;
        UpdateContents;
      finally
        Screen.Cursor:=OldCursor;
      end;
    end;
  end;
end;

function TSgtsGraphIface.CanShow: Boolean;
begin
  Result:=Assigned(CoreIntf) and
          PermissionExists(SPermissionNameShow);
end;

procedure TSgtsGraphIface.Show;
begin
  inherited Show;
end;

procedure TSgtsGraphIface.Hide;
begin
  inherited Hide;
end;

procedure TSgtsGraphIface.UpdateContents;
begin
  inherited UpdateContents;

  if Assigned(Form) then begin
    with Form do begin
      CreatePopupMenuReport(TMenuItem(PopupMenuReport.Items));
      MenuGraph.Clear;
      CreateMenuByToolBar(MenuGraph,ToolBar);
      PopupMenuView.Items.Clear;
      CreateMenuByToolBar(TMenuItem(PopupMenuView.Items),ToolBar);
    end;
  end;

  UpdateButtons;
  UpdateStatusbar;
end;

procedure TSgtsGraphIface.UpdateButtons;
begin
  if Assigned(Form) then begin
    with Form do begin
      ToolButtonRefresh.Enabled:=CanRefresh;

      UpdatePopupMenuReport(TMenuItem(PopupMenuReport.Items));
      ToolButtonReport.Enabled:=CanReport;
      if FReportClassInfos.Count>1 then
        ToolButtonReport.DropdownMenu:=PopupMenuReport
      else ToolButtonReport.DropdownMenu:=nil;

      ToolButtonSave.Enabled:=CanSave;
      ToolButtonAdjust.Enabled:=CanAdjust;

      UpdateMenuByButtons(MenuGraph);
      UpdateMenuByButtons(TMenuItem(PopupMenuView.Items));
    end;
  end;
end;

procedure TSgtsGraphIface.UpdateStatusbar;
begin
end;

function TSgtsGraphIface.CanRefresh: Boolean;
begin
  Result:=Assigned(Form) and
          CanShow and
          Assigned(FRefreshIface);
end;

procedure TSgtsGraphIface.CloseDataSets;
var
  i: Integer; 
begin
  for i:=0 to FDataSets.Count-1 do
    FDataSets.Items[i].Close;
end;

procedure TSgtsGraphIface.OpenDataSets;
var
  i: Integer; 
begin
  if not FInProgress then begin
    FInProgress:=true;
    FCancelProgress:=false;
    DataSetProgressProc(0,0,0,FCancelProgress);
    try
      if Assigned(Form) then
        Form.Update;
      for i:=0 to FDataSets.Count-1 do
        FDataSets.Items[i].Open;
    finally
      FInProgress:=false;
      FCancelProgress:=false;
      DataSetProgressProc(0,0,0,FCancelProgress);
    end;
  end;  
end;

procedure TSgtsGraphIface.Refresh;
var
  OldCursor: TCursor;
begin
  if CanRefresh then begin
    if FRefreshIface.ShowModal=mrOk then begin
      OldCursor:=Screen.Cursor;
      Screen.Cursor:=crHourGlass;
      try
        FAdjustIface.Hide;
        CloseDataSets;
        OpenDataSets;
        UpdateContents;
      finally
        Screen.Cursor:=OldCursor;
      end;
    end;
  end;
end;

function TSgtsGraphIface.CanReport: Boolean;
begin
  Result:=Assigned(Form) and
          Assigned(GetFirstDefaultMenu(TMenuItem(Form.PopupMenuReport.Items))) and
          not AsModal;
end;

procedure TSgtsGraphIface.Report;
var
  MenuItem: Menus.TMenuItem;
begin
  if CanReport then begin
    MenuItem:=GetFirstDefaultMenu(TMenuItem(Form.PopupMenuReport.Items));
    if Assigned(MenuItem) then
      MenuItemReportClick(MenuItem);
  end;
end;

function TSgtsGraphIface.CanSave: Boolean;
begin
  Result:=Assigned(Form);
end;

procedure TSgtsGraphIface.Save;
begin
  if CanSave then begin
  end;
end;

function TSgtsGraphIface.CanAdjust: Boolean;
begin
  Result:=Assigned(Form) and
          Assigned(Form.AdjustPersistent);
end;

procedure TSgtsGraphIface.Adjust;
begin
  if CanAdjust then begin
    FAdjustIface.Persistent:=Form.AdjustPersistent;
    FAdjustIface.Caption:=Form.Caption;
    FAdjustIface.UpdateContents;
    FAdjustIface.Show;
  end;
end;

procedure TSgtsGraphIface.CreatePopupMenuReport(MenuParent: TMenuItem);
var
  i: Integer;
  AClassInfo: TSgtsBaseReportIfaceClassInfo;
  AIface: TSgtsBaseReportIface;
  MenuItem: TSgtsMenuItemReport;
  Flag: Boolean;
begin
  MenuParent.Clear;
  Flag:=false;
  for i:=0 to FReportClassInfos.Count-1 do begin
    AClassInfo:=FReportClassInfos.Items[i];
    AIface:=AClassInfo.ReportClass.Create(CoreIntf);
    try
      AIface.Init(AClassInfo.ReportId,AClassInfo.Name,AClassInfo.Description,'','',true);
      AIface.BeforeReadParams;
      AIface.ReadParams;
      AIface.DatabaseLink;
      MenuItem:=TSgtsMenuItemReport.Create(MenuParent);
      MenuItem.Caption:=AIface.Caption;
      MenuItem.Hint:=MenuItem.Caption;
      MenuItem.Enabled:=AIface.CanShow;
      MenuItem.OnClick:=MenuItemReportClick;
      MenuItem.ReportClassInfo:=AClassInfo;
      if not Flag and MenuItem.Enabled then begin
        MenuItem.Default:=true;
        Flag:=true;
      end;
      MenuParent.Add(MenuItem);
    finally
      AIface.Free;
    end;
  end;
end;

procedure TSgtsGraphIface.UpdatePopupMenuReport(MenuParent: TMenuItem);
var
  i: Integer;
  AClassInfo: TSgtsBaseReportIfaceClassInfo;
  AIface: TSgtsBaseReportIface;
  MenuItem: TSgtsMenuItemReport;
  Flag: Boolean;
begin
  Flag:=false;
  for i:=0 to MenuParent.Count-1 do begin
    if MenuParent.Items[i] is TSgtsMenuItemReport then begin
      MenuItem:=TSgtsMenuItemReport(MenuParent.Items[i]);
      AClassInfo:=MenuItem.ReportClassInfo;
      if Assigned(AClassInfo) then begin
        AIface:=AClassInfo.ReportClass.Create(CoreIntf);
        try
          AIface.Init(AClassInfo.ReportId,AClassInfo.Name,AClassInfo.Description,'','',true);
          AIface.BeforeReadParams;
          AIface.ReadParams;
          AIface.DatabaseLink;
          MenuItem.Enabled:=AIface.CanShow;
          if not Flag and MenuItem.Enabled then begin
            MenuItem.Default:=true;
            Flag:=true;
          end;
        finally
          AIface.Free;
        end;
      end;
    end;
  end;
end;

procedure TSgtsGraphIface.MenuItemReportClick(Sender: TObject);
var
  MenuItem: TSgtsMenuItemReport;
  AClassInfo: TSgtsBaseReportIfaceClassInfo;
  AIface: TSgtsBaseReportIface;
begin
  MenuItem:=nil;
  if Assigned(Sender) then
    if Sender is TSgtsMenuItemReport then
      MenuItem:=TSgtsMenuItemReport(Sender)
    else begin
      MenuItem:=TSgtsMenuItemReport(Pointer(TMenuItem(Sender).Tag));
    end;
  if Assigned(MenuItem) then begin
    AClassInfo:=MenuItem.ReportClassInfo;
    if Assigned(AClassInfo) then begin
      AIface:=AClassInfo.ReportClass.Create(CoreIntf);
      FIfaces.Add(AIface);
      AIface.Init(AClassInfo.ReportId,AClassInfo.Name,AClassInfo.Description,'','',true,nil,Form.GetAdjustControl);
      AIface.BeforeReadParams;
      AIface.ReadParams;
      AIface.DatabaseLink;
      AIface.Show;
      MenuItem.Default:=true;
    end;
  end;
end;

function TSgtsGraphIface.CreateDataSet(ProviderName: String=''): TSgtsDatabaseCDS;
begin
  Result:=TSgtsDatabaseCDS.Create(CoreIntf);
  Result.ProviderName:=ProviderName;
  Result.ProgressProc:=DataSetProgressProc;
  FDataSets.Add(Result);
end;

procedure TSgtsGraphIface.DataSetProgressProc(Min,Max,Position: Integer; var Breaked: Boolean);
begin
  if Assigned(CoreIntf) then begin
    CoreIntf.MainForm.Progress(Min,Max,Position);
    Application.ProcessMessages;
    Breaked:=FCancelProgress;
  end;
end;

procedure TSgtsGraphIface.ReadParams(DatabaseConfig: Boolean=true);
begin
  inherited ReadParams(DatabaseConfig);
  if Assigned(RefreshIface) then
    RefreshIface.ReadParams(DatabaseConfig);
end;

procedure TSgtsGraphIface.WriteParams(DatabaseConfig: Boolean=true);
begin
  inherited WriteParams(DatabaseConfig);
  if Assigned(RefreshIface) then
    RefreshIface.WriteParams(DatabaseConfig);
end;

procedure TSgtsGraphIface.BeforeReadParams;
begin
  inherited BeforeReadParams;
  if Assigned(RefreshIface) then
    RefreshIface.BeforeReadParams;
end;

procedure TSgtsGraphIface.BeforeWriteParams;
begin
  inherited BeforeWriteParams;
  if Assigned(RefreshIface) then
    RefreshIface.BeforeWriteParams;
end;

{ TSgtsGraphForm }

destructor TSgtsGraphForm.Destroy;
begin
  if Assigned(Iface.AdjustIface) then
    Iface.AdjustIface.Hide;
  inherited Destroy;
end;

function TSgtsGraphForm.GetIface: TSgtsGraphIface;
begin
  Result:=TSgtsGraphIface(inherited Iface);
end;

procedure TSgtsGraphForm.WMSysCommand(var Message: TWMSysCommand);
begin
  with Message do begin
    case CmdType of
      SC_MINIMIZE: begin
        if Assigned(Iface) and
           Assigned(Iface.AdjustIface) and
           Assigned(Iface.AdjustIface.Form) and
           Iface.AdjustIface.Form.HandleAllocated then
          ShowWindow(Iface.AdjustIface.Form.Handle,SW_HIDE);
      end;
      SC_RESTORE, SC_MAXIMIZE: begin
        if Assigned(Iface) and
           Assigned(Iface.AdjustIface) and
           Assigned(Iface.AdjustIface.Form) and
           Iface.AdjustIface.Form.Visible and
           Iface.AdjustIface.Form.HandleAllocated then
          ShowWindow(Iface.AdjustIface.Form.Handle,SW_SHOW);
      end;
    end;
  end;
  inherited;
end;

function TSgtsGraphForm.GetAdjustPersistent: TPersistent;
begin
  Result:=nil;
end;

function TSgtsGraphForm.GetAdjustControl: TControl;
begin
  Result:=nil;
end;

procedure TSgtsGraphForm.ToolButtonRefreshClick(Sender: TObject);
begin
  Iface.Refresh;
end;

procedure TSgtsGraphForm.ToolButtonReportClick(Sender: TObject);
begin
  Iface.Report;
end;

procedure TSgtsGraphForm.ToolButtonSaveClick(Sender: TObject);
begin
  Iface.Save;
end;

procedure TSgtsGraphForm.ToolButtonAdjustClick(Sender: TObject);
begin
  Iface.Adjust;
end;

procedure TSgtsGraphForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift=[] then begin
    case Key of
      VK_F5: begin
        Iface.Refresh;
        Key:=0;
      end;
    end;
  end;
  if ssCtrl in Shift then begin
    case Key of
      Byte('p'),Byte('P'),Byte('ç'),Byte('Ç'): Iface.Report;
      Byte('s'),Byte('S'),Byte('û'),Byte('Û'): Iface.Save;
    end;
  end;
end;

procedure TSgtsGraphForm.PopupMenuViewPopup(Sender: TObject);
begin
  Iface.UpdateButtons;
end;

procedure TSgtsGraphForm.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if (CharCode = VK_ESCAPE) and
       (KeyDataToShiftState(Message.KeyData) = [])  then  begin
      if not Iface.InProgress then begin
        Result:=1;
      end else
        Iface.CancelProgress:=true;
    end else
      inherited;
end;

procedure TSgtsGraphForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=not Iface.InProgress;
end;

end.
