unit SgtsMainFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ImgList, XPMan, AppEvnts, ExtCtrls,
  SgtsIface, SgtsFm, SgtsReportFm,
  SgtsMainFmIntf, SgtsCoreIntf, SgtsMenus;

type
  TStatusBar=class(ComCtrls.TStatusBar)
  protected
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSgtsMainFormWindowAction=(waNone,waCloseAll,waMinimize,waRestore);

  TSgtsMainIface=class;

  TSgtsMainForm = class(TSgtsForm)
    MainMenu: TMainMenu;
    MenuItemFile: TMenuItem;
    MenuItemFileExit: TMenuItem;
    StatusBar: TStatusBar;
    MenuItemRbk: TMenuItem;
    MenuItemRpt: TMenuItem;
    MenuItemFun: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemHelpAbout: TMenuItem;
    MenuItemRbkAccounts: TMenuItem;
    MenuItemFileOptions: TMenuItem;
    ImageListToolbar: TImageList;
    ToolBar: TToolBar;
    ToolButtonOptions: TToolButton;
    MenuItemRbkAdmin: TMenuItem;
    MenuItemRbkObjects: TMenuItem;
    MenuItemRbkRoles: TMenuItem;
    MenuItemRbkAccountsRoles: TMenuItem;
    MenuItemRbkObjectTrees: TMenuItem;
    MenuItemWindows: TMenuItem;
    XPManifest: TXPManifest;
    MenuItemJrn: TMenuItem;
    MenuItemRbkCycles: TMenuItem;
    MenuItemRbkInstrumentTypes: TMenuItem;
    MenuItemRbkInstruments: TMenuItem;
    MenuItemRbkPointTypes: TMenuItem;
    MenuItemRbkPoints: TMenuItem;
    MenuItemRbkMeasureTypeRoutes: TMenuItem;
    N9: TMenuItem;
    MenuItemWindowsCloseAll: TMenuItem;
    MenuItemRbkPersonnels: TMenuItem;
    MenuItemRbkRoutePoints: TMenuItem;
    MenuItemRbkRoutes: TMenuItem;
    MenuItemRbkPlans: TMenuItem;
    MenuItemRbkMeasureTypes: TMenuItem;
    MenuItemJrnJournalFields: TMenuItem;
    MenuItemFunSourceData: TMenuItem;
    MenuItemFunPointManagement: TMenuItem;
    MenuItemWindowsMinimize: TMenuItem;
    MenuItemWindowsRestore: TMenuItem;
    N12: TMenuItem;
    MenuItemWindowsCascade: TMenuItem;
    MenuItemWindowsVertical: TMenuItem;
    MenuItemWindowsHorizontal: TMenuItem;
    ToolButtonSourceData: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButtonCloseAll: TToolButton;
    Timer: TTimer;
    MenuItemRbkAccountInsert: TMenuItem;
    N16: TMenuItem;
    MenuItemRbkPermission: TMenuItem;
    MenuItemRbkDivisions: TMenuItem;
    MenuItemFunPersonnelManagement: TMenuItem;
    MenuItemRbkMeasureUnits: TMenuItem;
    MenuItemRbkInstrumentUnits: TMenuItem;
    MenuItemRbkPersonnelRoutes: TMenuItem;
    MenuItemRbkAlgorithms: TMenuItem;
    MenuItemRbkMeasureTypeAlgorithms: TMenuItem;
    MenuItemRbkLevels: TMenuItem;
    MenuItemRbkParams: TMenuItem;
    MenuItemRbkMeasureTypeParams: TMenuItem;
    MenuItemRbkParamLevels: TMenuItem;
    MenuItemJrnJournalObservations: TMenuItem;
    MenuItemRbkFileReports: TMenuItem;
    MenuItemRbkParamInstruments: TMenuItem;
    MenuItemRbkDocuments: TMenuItem;
    MenuItemRbkPointDocuments: TMenuItem;
    MenuItemRbkConverters: TMenuItem;
    MenuItemRbkComponents: TMenuItem;
    MenuItemRbkDevices: TMenuItem;
    MenuItemRbkDevicePoints: TMenuItem;
    MenuItemRbkDrawings: TMenuItem;
    MenuItemRbkObjectDrawings: TMenuItem;
    MenuItemRbkObjectDocuments: TMenuItem;
    MenuItemRbkConverterPassports: TMenuItem;
    MenuItemRbkInstrumentPassports: TMenuItem;
    MenuItemRbkDocs: TMenuItem;
    MenuItemRbkObservation: TMenuItem;
    MenuItemRbkRouteAndPoint: TMenuItem;
    MenuItemRbkEquipment: TMenuItem;
    MenuItemRbkDataFormat: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    MenuItemRbkAdminStaff: TMenuItem;
    MenuItemRbkPlanAndCycle: TMenuItem;
    MenuItemRbkObject: TMenuItem;
    ImageListMenu: TImageList;
    ProgressBar: TProgressBar;
    MenuItemRbkPointPassports: TMenuItem;
    N2: TMenuItem;
    MenuItemRbkObjectPassports: TMenuItem;
    MenuItemJrnJournalActions: TMenuItem;
    MenuItemRbkBaseReports: TMenuItem;
    N3: TMenuItem;
    MenuItemSvc: TMenuItem;
    MenuItemSvcExportSql: TMenuItem;
    ProgressBar2: TProgressBar;
    MenuItemRbkInterfaceReports: TMenuItem;
    N1: TMenuItem;
    MenuItemRbkCheckings: TMenuItem;
    MenuItemRbkCuts: TMenuItem;
    MenuItemRbkPointInstruments: TMenuItem;
    MenuItemSvcRefreshCuts: TMenuItem;
    MenuItemGrh: TMenuItem;
    MenuItemJrnJournals: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    MenuItemRbkGraphs: TMenuItem;
    MenuItemRbkGroups: TMenuItem;
    N10: TMenuItem;
    MenuItemRbkGroupObjects: TMenuItem;
    N13: TMenuItem;
    MenuItemRbkDefectViews: TMenuItem;
    ToolButtonPointmanagement: TToolButton;
    ToolButtonObjectTrees: TToolButton;
    N14: TMenuItem;
    MenuItemRbkCriterias: TMenuItem;
    MenuItemSvcRecalcJournalObservations: TMenuItem;
    N8: TMenuItem;
    procedure MenuItemFileExitClick(Sender: TObject);
    procedure MenuItemRbkAccountsClick(Sender: TObject);
    procedure MenuItemHelpAboutClick(Sender: TObject);
    procedure MenuItemFileOptionsClick(Sender: TObject);
    procedure MenuItemRbkRolesClick(Sender: TObject);
    procedure MenuItemRbkAccountsRolesClick(Sender: TObject);
    procedure MenuItemRbkObjectsClick(Sender: TObject);
    procedure MenuItemRbkObjectTreesClick(Sender: TObject);
    procedure MenuItemRbkCyclesClick(Sender: TObject);
    procedure MenuItemRbkInstrumentTypesClick(Sender: TObject);
    procedure MenuItemRbkInstrumentsClick(Sender: TObject);
    procedure MenuItemRbkPointTypesClick(Sender: TObject);
    procedure MenuItemRbkPointsClick(Sender: TObject);
    procedure MenuItemRbkMeasureTypeRoutesClick(Sender: TObject);
    procedure MenuItemWindowsCloseAllClick(Sender: TObject);
    procedure MenuItemRbkPersonnelsClick(Sender: TObject);
    procedure MenuItemRbkRoutePointsClick(Sender: TObject);
    procedure MenuItemRbkRoutesClick(Sender: TObject);
    procedure MenuItemRbkPlansClick(Sender: TObject);
    procedure MenuItemRbkMeasureTypesClick(Sender: TObject);
    procedure MenuItemFunSourceDataClick(Sender: TObject);
    procedure MenuItemFunPointManagementClick(Sender: TObject);
    procedure MenuItemWindowsMinimizeClick(Sender: TObject);
    procedure MenuItemWindowsRestoreClick(Sender: TObject);
    procedure MenuItemWindowsCascadeClick(Sender: TObject);
    procedure MenuItemWindowsVerticalClick(Sender: TObject);
    procedure MenuItemWindowsHorizontalClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItemRbkAccountInsertClick(Sender: TObject);
    procedure MenuItemRbkPermissionClick(Sender: TObject);
    procedure MenuItemRbkDivisionsClick(Sender: TObject);
    procedure MenuItemFunPersonnelManagementClick(Sender: TObject);
    procedure MenuItemRbkMeasureUnitsClick(Sender: TObject);
    procedure MenuItemRbkInstrumentUnitsClick(Sender: TObject);
    procedure MenuItemRbkPersonnelRoutesClick(Sender: TObject);
    procedure MenuItemRbkAlgorithmsClick(Sender: TObject);
    procedure MenuItemRbkMeasureTypeAlgorithmsClick(Sender: TObject);
    procedure MenuItemRbkLevelsClick(Sender: TObject);
    procedure MenuItemRbkParamsClick(Sender: TObject);
    procedure MenuItemRbkMeasureTypeParamsClick(Sender: TObject);
    procedure MenuItemRbkParamLevelsClick(Sender: TObject);
    procedure MenuItemJrnJournalFieldsClick(Sender: TObject);
    procedure MenuItemJrnJournalObservationsClick(Sender: TObject);
    procedure MenuItemRbkFileReportsClick(Sender: TObject);
    procedure MenuItemRbkParamInstrumentsClick(Sender: TObject);
    procedure MenuItemRbkDocumentsClick(Sender: TObject);
    procedure MenuItemRbkConvertersClick(Sender: TObject);
    procedure MenuItemRbkComponentsClick(Sender: TObject);
    procedure MenuItemRbkDevicesClick(Sender: TObject);
    procedure MenuItemRbkPointDocumentsClick(Sender: TObject);
    procedure MenuItemRbkDevicePointsClick(Sender: TObject);
    procedure MenuItemRbkDrawingsClick(Sender: TObject);
    procedure MenuItemRbkObjectDrawingsClick(Sender: TObject);
    procedure MenuItemRbkObjectDocumentsClick(Sender: TObject);
    procedure MenuItemRbkConverterPassportsClick(Sender: TObject);
    procedure MenuItemRbkInstrumentPassportsClick(Sender: TObject);
    procedure StatusBarResize(Sender: TObject);
    procedure MenuItemRbkPointPassportsClick(Sender: TObject);
    procedure MenuItemRbkObjectPassportsClick(Sender: TObject);
    procedure MenuItemJrnJournalActionsClick(Sender: TObject);
    procedure MenuItemRbkBaseReportsClick(Sender: TObject);
    procedure MenuItemSvcExportSqlClick(Sender: TObject);
    procedure MenuItemRbkInterfaceReportsClick(Sender: TObject);
    procedure MenuItemRbkCheckingsClick(Sender: TObject);
    procedure MenuItemRbkCutsClick(Sender: TObject);
    procedure MenuItemRbkPointInstrumentsClick(Sender: TObject);
    procedure MenuItemSvcRefreshCutsClick(Sender: TObject);
    procedure MenuItemJrnJournalsClick(Sender: TObject);
    procedure MenuItemRbkGraphsClick(Sender: TObject);
    procedure MenuItemRbkGroupsClick(Sender: TObject);
    procedure MenuItemRbkGroupObjectsClick(Sender: TObject);
    procedure MenuItemRbkDefectViewsClick(Sender: TObject);
    procedure ToolButtonPointmanagementClick(Sender: TObject);
    procedure ToolButtonObjectTreesClick(Sender: TObject);
    procedure MenuItemRbkCriteriasClick(Sender: TObject);
    procedure MenuItemSvcRecalcJournalObservationsClick(Sender: TObject);
  private
    procedure WindowAction(Action: TSgtsMainFormWindowAction);
    function GetIface: TSgtsMainIface;
    function GetMenuItem(MenuParent: TMenuItem; MenuCaption: String): TMenuItem;
    function GetIfaceMenuItem(MenuPath, MenuHint: String; var MenuCaption: String): TMenuItem;
    procedure ClearMenuIfaces;
    procedure FillMenuIfaces;
    procedure RePositionProgressBars;
    procedure MenuIfaceClick(Sender: TObject);
  public
    destructor Destroy; override;
    procedure ApplicationHint(Sender: TObject);
    procedure InitByCore(ACoreIntf: ISgtsCore); override;

    property Iface: TSgtsMainIface read GetIface;
  end;

  TSgtsMainIface=class(TSgtsFormIface,ISgtsMainForm)
  private
    FForm: TSgtsMainForm;
    FWindowMaximized: Boolean;

    function GetForm: TSgtsMainForm;

    function _GetWindowMaximized: Boolean;
    procedure _SetWindowMaximized(Value: Boolean);
    function _GetClientHandle: THandle;
    function _GetMainMenu: TMainMenu;

  protected
    function GetFormClass: TSgtsFormClass; override;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure Done; override;
    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;
    procedure Show; override;
    procedure AfterCreateForm(AForm: TSgtsForm); override;
    procedure Start;
    procedure Progress(Min, Max, Position: Integer);
    procedure Progress2(Min, Max, Position: Integer);
    procedure UpdateContents; override;

    property Form: TSgtsMainForm read GetForm;
  end;

var
  SgtsMainForm: TSgtsMainForm;

implementation

uses SgtsConsts, SgtsDialogFm, SgtsCoreObj, SgtsHintEx, SgtsUtils,
     SgtsFmIntf, SgtsDatabaseIntf, SgtsDatabaseCDS, SgtsProviderConsts,
     SgtsObj, SgtsBaseGraphFm;

{$R *.dfm}

{ TStatusBar }

constructor TStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csAcceptsControls];
end;

procedure TStatusBar.Resize;
begin
  inherited Resize;
end;

{ TSgtsMainIface }

constructor TSgtsMainIface.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;

destructor TSgtsMainIface.Destroy;
begin
  inherited Destroy;
end;

function TSgtsMainIface.GetForm: TSgtsMainForm;
begin
  Result:=FForm;
end;

function TSgtsMainIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsMainForm;
end;

function TSgtsMainIface._GetWindowMaximized: Boolean;
begin
  Result:=FWindowMaximized;
end;

procedure TSgtsMainIface._SetWindowMaximized(Value: Boolean);
begin
  FWindowMaximized:=Value;
end;

function TSgtsMainIface._GetClientHandle: THandle;
begin
  Result:=0;
  if Assigned(Form) then
    Result:=Form.ClientHandle;
end;

function TSgtsMainIface._GetMainMenu: TMainMenu;
begin
  Result:=nil;
  if Assigned(Form) then
    Result:=Form.MainMenu;
end;

procedure TSgtsMainIface.Init;
begin
  inherited Init;
  Application.Initialize;
  Application.Title:=CoreIntf.Title;
end;

procedure TSgtsMainIface.Done;
begin
  inherited Done;
end;

procedure TSgtsMainIface.ReadParams;
begin
  inherited ReadParams;
  FWindowMaximized:=ReadParam(SConfigParamMaximized,false);
end;

procedure TSgtsMainIface.WriteParams;
begin
  WriteParam(SConfigParamMaximized,FWindowMaximized);
  inherited WriteParams;
end;

procedure TSgtsMainIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(AForm) then begin
    with TSgtsMainForm(AForm), CoreIntf do begin

      StatusBar.Panels[1].Text:=CoreIntf.DatabaseModules.Current.Caption;
      StatusBar.Panels[2].Text:=CoreIntf.DatabaseModules.Current.Database.Personnel;

      ProgressBar.Parent:=StatusBar;
      ProgressBar2.Parent:=StatusBar;
    end;
  end;
end;

procedure TSgtsMainIface.Show;
begin
  if not Assigned(Form) then begin
    Application.CreateForm(GetFormClass,FForm);
    LogWrite(SInterfaceFormCreate);
    FForm.InitByCore(CoreIntf);
    FForm.InitByIface(Self);
    AfterCreateForm(FForm);
    FForm.Caption:=Caption;
    FForm.WindowState:=iff(FWindowMaximized,wsMaximized,FForm.WindowState);
    if not (FForm.WindowState in [wsMaximized]) then begin
      FForm.Left:=Left;
      FForm.Top:=Top;
      FForm.Width:=Width;
      FForm.Height:=Height;
    end;
  end;
end;

procedure TSgtsMainIface.Start;
begin
  HintWindowClass:=TSgtsHintWindowEx;
  Application.OnHint:=FForm.ApplicationHint;
  LogWrite(SInterfaceShow);
  Application.Run;
  LogWrite(SInterfaceFormDestroy);
end;

procedure TSgtsMainIface.Progress(Min, Max, Position: Integer);
begin
  if Assigned(Form) then begin
    Form.StatusBar.Panels[0].Text:='';
    Form.ProgressBar.Visible:=iff((Position>Min) and ((Max-Min)>1),true,false);
    Form.ProgressBar.Min:=Min;
    Form.ProgressBar.Max:=Max;
    Form.ProgressBar.Position:=Position;
    Form.RePositionProgressBars;
    Form.ProgressBar.Update;
    Form.StatusBar.Update;
    Form.Update;
  end;
end;

procedure TSgtsMainIface.Progress2(Min, Max, Position: Integer);
begin
  if Assigned(Form) then begin
    Form.StatusBar.Panels[0].Text:='';
    Form.ProgressBar2.Visible:=iff((Position>Min) and ((Max-Min)>1) and Form.ProgressBar.Visible,true,false);
    Form.ProgressBar2.Min:=Min;
    Form.ProgressBar2.Max:=Max;
    Form.ProgressBar2.Position:=Position;
    Form.RePositionProgressBars;
    Form.ProgressBar2.Update;
    Form.StatusBar.Update;
    Form.Update;
  end;
end;

procedure TSgtsMainIface.UpdateContents;
begin
  inherited UpdateContents;
  if Assigned(Form) then begin
    with TSgtsMainForm(Form), CoreIntf do begin

      MenuItemFileOptions.Visible:=OptionsForm.CanShow;

      ToolButtonOptions.Enabled:=CoreIntf.OptionsForm.CanShow;

      MenuItemFunPersonnelManagement.Visible:=FunPersonnelManagementForm.CanShow;
      MenuItemFunPersonnelManagement.Caption:=FunPersonnelManagementForm.Caption;

      MenuItemFunPointManagement.Visible:=FunPointManagementForm.CanShow;
      MenuItemFunPointManagement.Caption:=FunPointManagementForm.Caption;
      ToolButtonPointmanagement.Enabled:=MenuItemFunPointManagement.Visible;

      MenuItemFunSourceData.Visible:=FunSourceDataForm.CanShow;
      MenuItemFunSourceData.Caption:=FunSourceDataForm.Caption;
      ToolButtonSourceData.Enabled:=MenuItemFunSourceData.Visible;

      MenuItemJrnJournals.Visible:=JrnJournalsForm.CanShow;
      MenuItemJrnJournals.Caption:=JrnJournalsForm.Caption;

      MenuItemJrnJournalActions.Visible:=JrnJournalActionsForm.CanShow;
      MenuItemJrnJournalActions.Caption:=JrnJournalActionsForm.Caption;

      MenuItemRbkAccounts.Visible:=RbkAccountsForm.CanShow;
      MenuItemRbkAccounts.Caption:=RbkAccountsForm.Caption;

      MenuItemRbkRoles.Visible:=RbkRolesForm.CanShow;
      MenuItemRbkRoles.Caption:=RbkRolesForm.Caption;

      MenuItemRbkPermission.Visible:=RbkPermissionForm.CanShow;
      MenuItemRbkPermission.Caption:=RbkPermissionForm.Caption;

      MenuItemRbkAccountsRoles.Visible:=RbkAccountsRolesForm.CanShow;
      MenuItemRbkAccountsRoles.Caption:=RbkAccountsRolesForm.Caption;

      MenuItemRbkFileReports.Visible:=RbkFileReportsForm.CanShow;
      MenuItemRbkFileReports.Caption:=RbkFileReportsForm.Caption;

      MenuItemRbkBaseReports.Visible:=RbkBaseReportsForm.CanShow;
      MenuItemRbkBaseReports.Caption:=RbkBaseReportsForm.Caption;

      MenuItemRbkInterfaceReports.Visible:=RbkInterfaceReportsForm.CanShow;
      MenuItemRbkInterfaceReports.Caption:=RbkInterfaceReportsForm.Caption;

      MenuItemRbkCuts.Visible:=RbkCutsForm.CanShow;
      MenuItemRbkCuts.Caption:=RbkCutsForm.Caption;

      MenuItemRbkGraphs.Visible:=RbkGraphsForm.CanShow;
      MenuItemRbkGraphs.Caption:=RbkGraphsForm.Caption;

      MenuItemRbkAdmin.Visible:=MenuItemRbkAccounts.Visible or
                                MenuItemRbkRoles.Visible or
                                MenuItemRbkAccountInsert.Visible or
                                MenuItemRbkPermission.Visible or
                                MenuItemRbkAccountsRoles.Visible or
                                MenuItemRbkFileReports.Visible or
                                MenuItemRbkBaseReports.Visible or
                                MenuItemRbkInterfaceReports.Visible or
                                MenuItemRbkCuts.Visible or
                                MenuItemRbkGraphs.Visible;

      MenuItemRbkPersonnels.Visible:=RbkPersonnelsForm.CanShow;
      MenuItemRbkPersonnels.Caption:=RbkPersonnelsForm.Caption;

      MenuItemRbkDivisions.Visible:=RbkDivisionsForm.CanShow;
      MenuItemRbkDivisions.Caption:=RbkDivisionsForm.Caption;

      MenuItemRbkAdminStaff.Visible:=MenuItemRbkPersonnels.Visible or
                                     MenuItemRbkDivisions.Visible;


      MenuItemRbkDrawings.Visible:=RbkDrawingsForm.CanShow;
      MenuItemRbkDrawings.Caption:=RbkDrawingsForm.Caption;

      MenuItemRbkDocuments.Visible:=RbkDocumentsForm.CanShow;
      MenuItemRbkDocuments.Caption:=RbkDocumentsForm.Caption;

      MenuItemRbkObjectDrawings.Visible:=RbkObjectDrawingsForm.CanShow;
      MenuItemRbkObjectDrawings.Caption:=RbkObjectDrawingsForm.Caption;

      MenuItemRbkObjectDocuments.Visible:=RbkObjectDocumentsForm.CanShow;
      MenuItemRbkObjectDocuments.Caption:=RbkObjectDocumentsForm.Caption;

      MenuItemRbkPointDocuments.Visible:=RbkPointDocumentsForm.CanShow;
      MenuItemRbkPointDocuments.Caption:=RbkPointDocumentsForm.Caption;

      MenuItemRbkDocs.Visible:=MenuItemRbkDrawings.Visible or
                               MenuItemRbkDocuments.Visible or
                               MenuItemRbkObjectDrawings.Visible or
                               MenuItemRbkObjectDocuments.Visible or
                               MenuItemRbkPointDocuments.Visible;


      MenuItemRbkMeasureTypes.Visible:=RbkMeasureTypesForm.CanShow;
      MenuItemRbkMeasureTypes.Caption:=RbkMeasureTypesForm.Caption;

      MenuItemRbkMeasureTypeAlgorithms.Visible:=RbkMeasureTypeAlgorithmsForm.CanShow;
      MenuItemRbkMeasureTypeAlgorithms.Caption:=RbkMeasureTypeAlgorithmsForm.Caption;

      MenuItemRbkMeasureTypeParams.Visible:=RbkMeasureTypeParamsForm.CanShow;
      MenuItemRbkMeasureTypeParams.Caption:=RbkMeasureTypeParamsForm.Caption;

      MenuItemRbkMeasureTypeRoutes.Visible:=RbkMeasureTypeRoutesForm.CanShow;
      MenuItemRbkMeasureTypeRoutes.Caption:=RbkMeasureTypeRoutesForm.Caption;

      MenuItemRbkDefectViews.Visible:=RbkDefectViewsForm.CanShow;
      MenuItemRbkDefectViews.Caption:=RbkDefectViewsForm.Caption;

      MenuItemRbkCriterias.Visible:=RbkCriteriasForm.CanShow;
      MenuItemRbkCriterias.Caption:=RbkCriteriasForm.Caption;

      MenuItemRbkObservation.Visible:=MenuItemRbkMeasureTypes.Visible or
                                      MenuItemRbkMeasureTypeAlgorithms.Visible or
                                      MenuItemRbkMeasureTypeParams.Visible or
                                      MenuItemRbkMeasureTypeRoutes.Visible or
                                      MenuItemRbkDefectViews.Visible or
                                      MenuItemRbkCriterias.Visible;

      MenuItemRbkPoints.Visible:=RbkPointsForm.CanShow;
      MenuItemRbkPoints.Caption:=RbkPointsForm.Caption;

      MenuItemRbkRoutes.Visible:=RbkRoutesForm.CanShow;
      MenuItemRbkRoutes.Caption:=RbkRoutesForm.Caption;

      MenuItemRbkPointTypes.Visible:=RbkPointTypesForm.CanShow;
      MenuItemRbkPointTypes.Caption:=RbkPointTypesForm.Caption;

      MenuItemRbkRoutePoints.Visible:=RbkRoutePointsForm.CanShow;
      MenuItemRbkRoutePoints.Caption:=RbkRoutePointsForm.Caption;

      MenuItemRbkDevicePoints.Visible:=RbkDevicePointsForm.CanShow;
      MenuItemRbkDevicePoints.Caption:=RbkDevicePointsForm.Caption;

      MenuItemRbkPersonnelRoutes.Visible:=RbkPersonnelRoutesForm.CanShow;
      MenuItemRbkPersonnelRoutes.Caption:=RbkPersonnelRoutesForm.Caption;

      MenuItemRbkPointPassports.Visible:=RbkPointPassportsForm.CanShow;
      MenuItemRbkPointPassports.Caption:=RbkPointPassportsForm.Caption;

      MenuItemRbkPointInstruments.Visible:=RbkPointInstrumentsForm.CanShow;
      MenuItemRbkPointInstruments.Caption:=RbkPointInstrumentsForm.Caption;

      MenuItemRbkRouteAndPoint.Visible:=MenuItemRbkPoints.Visible or
                                        MenuItemRbkRoutes.Visible or
                                        MenuItemRbkPointTypes.Visible or
                                        MenuItemRbkRoutePoints.Visible or
                                        MenuItemRbkDevicePoints.Visible or
                                        MenuItemRbkPersonnelRoutes.Visible or
                                        MenuItemRbkPointPassports.Visible or
                                        MenuItemRbkPointInstruments.Visible;

      MenuItemRbkInstruments.Visible:=RbkInstrumentsForm.CanShow;
      MenuItemRbkInstruments.Caption:=RbkInstrumentsForm.Caption;

      MenuItemRbkConverters.Visible:=RbkConvertersForm.CanShow;
      MenuItemRbkConverters.Caption:=RbkConvertersForm.Caption;

      MenuItemRbkComponents.Visible:=RbkComponentsForm.CanShow;
      MenuItemRbkComponents.Caption:=RbkComponentsForm.Caption;

      MenuItemRbkDevices.Visible:=RbkDevicesForm.CanShow;
      MenuItemRbkDevices.Caption:=RbkDevicesForm.Caption;

      MenuItemRbkInstrumentTypes.Visible:=RbkInstrumentTypesForm.CanShow;
      MenuItemRbkInstrumentTypes.Caption:=RbkInstrumentTypesForm.Caption;

      MenuItemRbkInstrumentUnits.Visible:=RbkInstrumentUnitsForm.CanShow;
      MenuItemRbkInstrumentUnits.Caption:=RbkInstrumentUnitsForm.Caption;

      MenuItemRbkConverterPassports.Visible:=RbkConverterPassportsForm.CanShow;
      MenuItemRbkConverterPassports.Caption:=RbkConverterPassportsForm.Caption;

      MenuItemRbkInstrumentPassports.Visible:=RbkInstrumentPassportsForm.CanShow;
      MenuItemRbkInstrumentPassports.Caption:=RbkInstrumentPassportsForm.Caption;

      MenuItemRbkEquipment.Visible:=MenuItemRbkInstruments.Visible or
                                    MenuItemRbkConverters.Visible or
                                    MenuItemRbkComponents.Visible or
                                    MenuItemRbkDevices.Visible or
                                    MenuItemRbkInstrumentTypes.Visible or
                                    MenuItemRbkInstrumentUnits.Visible or
                                    MenuItemRbkConverterPassports.Visible or
                                    MenuItemRbkInstrumentPassports.Visible;
                                  
      MenuItemRbkParams.Visible:=RbkParamsForm.CanShow;
      MenuItemRbkParams.Caption:=RbkParamsForm.Caption;

      MenuItemRbkAlgorithms.Visible:=RbkAlgorithmsForm.CanShow;
      MenuItemRbkAlgorithms.Caption:=RbkAlgorithmsForm.Caption;

      MenuItemRbkMeasureUnits.Visible:=RbkMeasureUnitsForm.CanShow;
      MenuItemRbkMeasureUnits.Caption:=RbkMeasureUnitsForm.Caption;

      MenuItemRbkLevels.Visible:=false;
{      MenuItemRbkLevels.Visible:=RbkLevelsForm.CanShow;
      MenuItemRbkLevels.Caption:=RbkLevelsForm.Caption;}

      MenuItemRbkParamLevels.Visible:=false;
{      MenuItemRbkParamLevels.Visible:=RbkParamLevelsForm.CanShow;
      MenuItemRbkParamLevels.Caption:=RbkParamLevelsForm.Caption;}

      MenuItemRbkParamInstruments.Visible:=RbkParamInstrumentsForm.CanShow;
      MenuItemRbkParamInstruments.Caption:=RbkParamInstrumentsForm.Caption;

      MenuItemRbkCheckings.Visible:=RbkCheckingsForm.CanShow;
      MenuItemRbkCheckings.Caption:=RbkCheckingsForm.Caption;

      MenuItemRbkDataFormat.Visible:=MenuItemRbkParams.Visible or
                                     MenuItemRbkAlgorithms.Visible or
                                     MenuItemRbkMeasureUnits.Visible or
                                     MenuItemRbkLevels.Visible or
                                     MenuItemRbkParamLevels.Visible or
                                     MenuItemRbkParamInstruments.Visible or
                                     MenuItemRbkCheckings.Visible;

      MenuItemRbkCycles.Visible:=RbkCyclesForm.CanShow;
      MenuItemRbkCycles.Caption:=RbkCyclesForm.Caption;

      MenuItemRbkPlans.Visible:=RbkPlansForm.CanShow;
      MenuItemRbkPlans.Caption:=RbkPlansForm.Caption;

      MenuItemRbkPlanAndCycle.Visible:=MenuItemRbkCycles.Visible or
                                       MenuItemRbkPlans.Visible;

      MenuItemRbkObjects.Visible:=RbkObjectsForm.CanShow;
      MenuItemRbkObjects.Caption:=RbkObjectsForm.Caption;

      MenuItemRbkObjectTrees.Visible:=RbkObjectTreesForm.CanShow;
      MenuItemRbkObjectTrees.Caption:=RbkObjectTreesForm.Caption;
      ToolButtonObjectTrees.Enabled:=MenuItemRbkObjectTrees.Visible;

      MenuItemRbkObjectPassports.Visible:=RbkObjectPassportsForm.CanShow;
      MenuItemRbkObjectPassports.Caption:=RbkObjectPassportsForm.Caption;

      MenuItemRbkGroups.Visible:=RbkGroupsForm.CanShow;
      MenuItemRbkGroups.Caption:=RbkGroupsForm.Caption;

      MenuItemRbkGroupObjects.Visible:=RbkGroupObjectsForm.CanShow;
      MenuItemRbkGroupObjects.Caption:=RbkGroupObjectsForm.Caption;

      MenuItemRbkObject.Visible:=MenuItemRbkObjects.Visible or
                                 MenuItemRbkObjectTrees.Visible or
                                 MenuItemRbkObjectPassports.Visible or
                                 MenuItemRbkGroups.Visible or
                                 MenuItemRbkGroupObjects.Visible;

      MenuItemSvcExportSql.Visible:=ExportSqlForm.CanShow;
      MenuItemSvcExportSql.Caption:=ExportSqlForm.Caption;

      MenuItemSvcRefreshCuts.Visible:=RefreshCutsForm.CanShow;
      MenuItemSvcRefreshCuts.Caption:=RefreshCutsForm.Caption;

      MenuItemSvcRecalcJournalObservations.Visible:=RecalcJournalObservationsForm.CanShow;
      MenuItemSvcRecalcJournalObservations.Caption:=RecalcJournalObservationsForm.Caption;

      ClearMenuIfaces;
      FillMenuIfaces;

      MenuItemFile.Visible:=GetMenuVisibleCount(MenuItemFile)>0;
      MenuItemFun.Visible:=GetMenuVisibleCount(MenuItemFun)>0;
      MenuItemJrn.Visible:=GetMenuVisibleCount(MenuItemJrn)>0;
      MenuItemRbk.Visible:=GetMenuVisibleCount(MenuItemRbk)>0;
      MenuItemSvc.Visible:=GetMenuVisibleCount(MenuItemSvc)>0;
      MenuItemRpt.Visible:=GetMenuVisibleCount(MenuItemRpt)>0;
      MenuItemGrh.Visible:=GetMenuVisibleCount(MenuItemGrh)>0;
      MenuItemWindows.Visible:=GetMenuVisibleCount(MenuItemWindows)>0;
      MenuItemHelp.Visible:=GetMenuVisibleCount(MenuItemHelp)>0;

    end;
  end;
end;

{ TSgtsMainForm }

destructor TSgtsMainForm.Destroy;
begin
  ClearMenuIfaces;
  inherited Destroy;
end;

procedure TSgtsMainForm.InitByCore(ACoreIntf: ISgtsCore);
begin
   inherited InitByCore(ACoreIntf);
end;

function TSgtsMainForm.GetIface: TSgtsMainIface;
begin
  Result:=TSgtsMainIface(inherited Iface);
end;

function TSgtsMainForm.GetMenuItem(MenuParent: TMenuItem; MenuCaption: String): TMenuItem;
var
  i: integer;
  MenuItem: Menus.TMenuItem;
begin
  Result:=nil;
  for i:=0 to MenuParent.Count-1 do begin
    MenuItem:=MenuParent.Items[i];
    if AnsiSametext(MenuItem.Caption,MenuCaption) then begin
      Result:=TMenuItem(MenuItem);
      exit;
    end;
  end;
end;

function TSgtsMainForm.GetIfaceMenuItem(MenuPath, MenuHint: String; var MenuCaption: String): TMenuItem;
var
  Str: TStringList;
  i: Integer;
  S: String;
  MenuItem: TMenuItem;
  MenuParent: TMenuItem;
begin
  Result:=nil;
  Str:=TStringList.Create;
  try
    MenuParent:=TMenuItem(MainMenu.Items);
    GetStringsByString(MenuPath,SMenuDelim,Str);
    for i:=0 to Str.Count-1 do begin
      S:=Trim(Str.Strings[i]);
      if i<(Str.Count-1) then begin
        MenuItem:=GetMenuItem(MenuParent,S);
        if not Assigned(MenuItem) then begin
          MenuItem:=TMenuItem.Create(Self);
          MenuItem.Caption:=S;
          MenuItem.Hint:=iff(Trim(MenuHint)<>'',MenuHint,S);
          MenuParent.Add(MenuItem);
        end;
        MenuParent:=MenuItem;
      end else begin
        Result:=TMenuItem.Create(Self);
        MenuCaption:=S;
        MenuParent.Add(Result);
      end;
    end;
  finally
    Str.Free;
  end;
end;

procedure TSgtsMainForm.ClearMenuIfaces;

  procedure ClearMenu(MenuParent: TMenuItem);
  var
    i: Integer;
    MenuItem: TMenuItem;
  begin
    for i:=MenuParent.Count-1 downto 0 do begin
      MenuItem:=TMenuItem(MenuParent.Items[i]);
      if MenuItem.Count>0 then
        ClearMenu(MenuItem);
      if Assigned(Pointer(MenuItem.Tag)) then begin
        MenuParent.Remove(MenuItem);
      end;
    end;
  end;

begin
  ClearMenu(TMenuItem(MainMenu.Items));
end;

procedure TSgtsMainForm.FillMenuIfaces;
var
  Menu: TMenuItem;
  i: Integer;
  Obj: TObject;
  Ifaces: TStringList;
  AIface: TSgtsIface;
  MenuCaption: String;
begin
  Ifaces:=TStringList.Create;
  try
    Ifaces.Sorted:=false;
    CoreIntf.GetInterfaceNames(Ifaces,TSgtsIface);
    for i:=0 to Ifaces.Count-1 do begin
      Obj:=Ifaces.Objects[i];
      if Assigned(Obj) and (Obj is TSgtsIface) then begin
        AIface:=TSgtsIface(Obj);
        if AIface.CanShow then begin
          if Trim(AIface.MenuPath)<>'' then begin
            Menu:=GetIfaceMenuItem(AIface.MenuPath,AIface.MenuHint,MenuCaption);
            if Assigned(Menu) then begin
              Menu.Caption:=MenuCaption;
              Menu.Hint:=iff(Trim(AIface.MenuHint)<>'',AIface.MenuHint,MenuCaption);
              Menu.Tag:=Integer(AIface);
              if (AIface is TSgtsReportIface) or
                 (AIface is TSgtsBaseGraphIface) then begin
                Menu.MenuIndex:=Menu.Parent.Count;
              end else begin
                Menu.MenuIndex:=AIface.MenuIndex;
              end;
              AIface.MenuItem:=Menu;
              Menu.OnClick:=MenuIfaceClick;
            end;
          end;
        end;
      end;
    end;
  finally
    Ifaces.Free;
  end;
end;

procedure TSgtsMainForm.MenuIfaceClick(Sender: TObject);
var
  MenuItem: TMenuItem;
  AIface: TSgtsIface;
begin
  if Assigned(Sender) and (Sender is TMenuItem) then begin
    MenuItem:=TMenuItem(Sender);
    if Assigned(Pointer(MenuItem.Tag)) then begin
      AIface:=TSgtsIface(Pointer(MenuItem.Tag));
      AIface.Show;
    end;  
  end;  
end;

procedure TSgtsMainForm.MenuItemFileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSgtsMainForm.ApplicationHint(Sender: TObject);
var
  S: String;
begin
  S:='';
  if not ProgressBar.Visible and
     not ProgressBar2.Visible then
    S:=Application.Hint;
  StatusBar.Panels[0].Text:=S;
end;

procedure TSgtsMainForm.WindowAction(Action: TSgtsMainFormWindowAction);

  function InMDIChildren(Form: TCustomForm): Boolean;
  var
    i: Integer;
    FormCurrent: TCustomForm;
  begin
    Result:=false;
    for i:=MDIChildCount-1 downto 0 do begin
      FormCurrent:=MDIChildren[i];
      if FormCurrent=Form then begin
        Result:=true;
        exit;
      end;
    end;
  end;

var
  i: Integer;
  Form: TCustomForm;
  List: Tlist;
begin
  List:=TList.Create;
  try
   for i:=MDIChildCount-1 downto 0 do begin
    Form:=MDIChildren[i];
    List.Add(Form);
   end;
   for i:=List.Count-1 downto 0 do begin
    Form:=List.Items[i];
    if InMDIChildren(Form) then begin
      case Action of
        waCloseAll: Form.Close;
        waMinimize: ShowWindow(Form.Handle,SW_MINIMIZE);
        waRestore: ShowWindow(Form.Handle,SW_RESTORE);
      end;
    end;
   end;
  finally
   List.Free;
  end;
end;

procedure TSgtsMainForm.MenuItemWindowsCloseAllClick(Sender: TObject);
begin
  WindowAction(waCloseAll);
end;

procedure TSgtsMainForm.MenuItemWindowsMinimizeClick(Sender: TObject);
begin
  WindowAction(waMinimize);
end;

procedure TSgtsMainForm.MenuItemWindowsRestoreClick(Sender: TObject);
begin
  WindowAction(waRestore);
end;

procedure TSgtsMainForm.MenuItemWindowsCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TSgtsMainForm.MenuItemWindowsVerticalClick(Sender: TObject);
begin
  TileMode:=tbVertical;
  Tile;
end;

procedure TSgtsMainForm.MenuItemWindowsHorizontalClick(Sender: TObject);
begin
  TileMode:=tbHorizontal;
  Tile;
end;

procedure TSgtsMainForm.MenuItemRbkAccountsClick(Sender: TObject);
begin
  CoreIntf.RbkAccountsForm.Show;
end;

procedure TSgtsMainForm.MenuItemHelpAboutClick(Sender: TObject);
begin
  CoreIntf.AboutForm.Show;
end;

procedure TSgtsMainForm.MenuItemFileOptionsClick(Sender: TObject);
begin
  CoreIntf.OptionsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkRolesClick(Sender: TObject);
begin
  CoreIntf.RbkRolesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkAccountsRolesClick(Sender: TObject);
begin
  CoreIntf.RbkAccountsRolesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkObjectsClick(Sender: TObject);
begin
   CoreIntf.RbkObjectsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkObjectTreesClick(Sender: TObject);
begin
  CoreIntf.RbkObjectTreesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkCyclesClick(Sender: TObject);
begin
  CoreIntf.RbkCyclesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkInstrumentTypesClick(Sender: TObject);
begin
  CoreIntf.RbkInstrumentTypesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkInstrumentsClick(Sender: TObject);
begin
  CoreIntf.RbkInstrumentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPointTypesClick(Sender: TObject);
begin
  CoreIntf.RbkPointTypesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPointsClick(Sender: TObject);
begin
  CoreIntf.RbkPointsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkMeasureTypeRoutesClick(Sender: TObject);
begin
  CoreIntf.RbkMeasureTypeRoutesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPersonnelsClick(Sender: TObject);
begin
  CoreIntf.RbkPersonnelsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkRoutePointsClick(Sender: TObject);
begin
  CoreIntf.RbkRoutePointsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkRoutesClick(Sender: TObject);
begin
  CoreIntf.RbkRoutesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPlansClick(Sender: TObject);
begin
  CoreIntf.RbkPlansForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkMeasureTypesClick(Sender: TObject);
begin
  CoreIntf.RbkMeasureTypesForm.Show;
end;

procedure TSgtsMainForm.MenuItemFunSourceDataClick(Sender: TObject);
begin
  CoreIntf.FunSourceDataForm.Show;
end;

procedure TSgtsMainForm.MenuItemFunPointManagementClick(Sender: TObject);
begin
  CoreIntf.FunPointManagementForm.Show;
end;

procedure TSgtsMainForm.TimerTimer(Sender: TObject);
begin
  Timer.Enabled:=false;
  MenuItemFunSourceData.Click;
end;

procedure TSgtsMainForm.ToolButtonObjectTreesClick(Sender: TObject);
begin
  CoreIntf.RbkObjectTreesForm.Show;
end;

procedure TSgtsMainForm.ToolButtonPointmanagementClick(Sender: TObject);
begin
  CoreIntf.FunPointManagementForm.Show;
end;

procedure TSgtsMainForm.FormShow(Sender: TObject);
begin
  if CoreIntf.OptionsForm.OpenFunSourceData then begin
    Timer.Interval:=1000;
    Timer.Enabled:=true;
  end;
end;

procedure TSgtsMainForm.MenuItemRbkAccountInsertClick(Sender: TObject);
begin
//  CoreIntf.RbkAccountInsertForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPermissionClick(Sender: TObject);
begin
  CoreIntf.RbkPermissionForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkDivisionsClick(Sender: TObject);
begin
  CoreIntf.RbkDivisionsForm.Show;
end;

procedure TSgtsMainForm.MenuItemFunPersonnelManagementClick(
  Sender: TObject);
begin
  CoreIntf.FunPersonnelManagementForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkMeasureUnitsClick(Sender: TObject);
begin
  CoreIntf.RbkMeasureUnitsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkInstrumentUnitsClick(Sender: TObject);
begin
  CoreIntf.RbkInstrumentUnitsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPersonnelRoutesClick(Sender: TObject);
begin
  CoreIntf.RbkPersonnelRoutesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkAlgorithmsClick(Sender: TObject);
begin
  CoreIntf.RbkAlgorithmsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkMeasureTypeAlgorithmsClick(
  Sender: TObject);
begin
  CoreIntf.RbkMeasureTypeAlgorithmsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkLevelsClick(Sender: TObject);
begin
  CoreIntf.RbkLevelsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkParamsClick(Sender: TObject);
begin
  CoreIntf.RbkParamsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkMeasureTypeParamsClick(Sender: TObject);
begin
  CoreIntf.RbkMeasureTypeParamsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkParamLevelsClick(Sender: TObject);
begin
  CoreIntf.RbkParamLevelsForm.Show;
end;

procedure TSgtsMainForm.MenuItemJrnJournalFieldsClick(Sender: TObject);
begin
  CoreIntf.JrnJournalFieldsForm.Show;
end;

procedure TSgtsMainForm.MenuItemJrnJournalObservationsClick(
  Sender: TObject);
begin
  CoreIntf.JrnJournalObservationsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkFileReportsClick(Sender: TObject);
begin
  CoreIntf.RbkFileReportsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkParamInstrumentsClick(Sender: TObject);
begin
  CoreIntf.RbkParamInstrumentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkDocumentsClick(Sender: TObject);
begin
  CoreIntf.RbkDocumentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkConvertersClick(Sender: TObject);
begin
  CoreIntf.RbkConvertersForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkCriteriasClick(Sender: TObject);
begin
  CoreIntf.RbkCriteriasForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkComponentsClick(Sender: TObject);
begin
  CoreIntf.RbkComponentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkDevicesClick(Sender: TObject);
begin
  CoreIntf.RbkDevicesForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPointDocumentsClick(Sender: TObject);
begin
  CoreIntf.RbkPointDocumentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkDefectViewsClick(Sender: TObject);
begin
  CoreIntf.RbkDefectViewsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkDevicePointsClick(Sender: TObject);
begin
  CoreIntf.RbkDevicePointsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkDrawingsClick(Sender: TObject);
begin
  CoreIntf.RbkDrawingsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkObjectDrawingsClick(Sender: TObject);
begin
  CoreIntf.RbkObjectDrawingsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkObjectDocumentsClick(Sender: TObject);
begin
  CoreIntf.RbkObjectDocumentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkConverterPassportsClick(
  Sender: TObject);
begin
  CoreIntf.RbkConverterPassportsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkInstrumentPassportsClick(
  Sender: TObject);
begin
  CoreIntf.RbkInstrumentPassportsForm.Show;
end;

procedure TSgtsMainForm.RePositionProgressBars;
begin
  if ProgressBar.Visible and
     not ProgressBar2.Visible then begin
    ProgressBar.Left:=1;
    ProgressBar.Width:=StatusBar.Panels.Items[0].Width-1;
    ProgressBar.Top:=2;
    ProgressBar.Height:=StatusBar.Height-2;
  end;
  if not ProgressBar.Visible and
     ProgressBar2.Visible then begin
    ProgressBar2.Left:=1;
    ProgressBar2.Width:=StatusBar.Panels.Items[0].Width-1;
    ProgressBar2.Top:=2;
    ProgressBar2.Height:=StatusBar.Height-2;
  end;
  if ProgressBar.Visible and
     ProgressBar2.Visible then begin
    ProgressBar.Left:=1;
    ProgressBar.Width:=StatusBar.Panels.Items[0].Width-1;
    ProgressBar.Top:=2;
    ProgressBar.Height:=StatusBar.Height div 2 -1;
    ProgressBar2.Left:=1;
    ProgressBar2.Width:=ProgressBar.Width;
    ProgressBar2.Top:=ProgressBar.Height+3;
    ProgressBar2.Height:=ProgressBar.Height;
  end;
end;

procedure TSgtsMainForm.StatusBarResize(Sender: TObject);
begin
  RePositionProgressBars;
end;

procedure TSgtsMainForm.MenuItemRbkPointPassportsClick(Sender: TObject);
begin
  CoreIntf.RbkPointPassportsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkObjectPassportsClick(Sender: TObject);
begin
  CoreIntf.RbkObjectPassportsForm.Show;
end;

procedure TSgtsMainForm.MenuItemJrnJournalActionsClick(Sender: TObject);
begin
  CoreIntf.JrnJournalActionsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkBaseReportsClick(Sender: TObject);
begin
  CoreIntf.RbkBaseReportsForm.Show;
end;

procedure TSgtsMainForm.MenuItemSvcExportSqlClick(Sender: TObject);
begin
  CoreIntf.ExportSqlForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkInterfaceReportsClick(Sender: TObject);
begin
  CoreIntf.RbkInterfaceReportsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkCheckingsClick(Sender: TObject);
begin
  CoreIntf.RbkCheckingsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkCutsClick(Sender: TObject);
begin
  CoreIntf.RbkCutsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkPointInstrumentsClick(Sender: TObject);
begin
  CoreIntf.RbkPointInstrumentsForm.Show;
end;

procedure TSgtsMainForm.MenuItemSvcRecalcJournalObservationsClick(
  Sender: TObject);
begin
  CoreIntf.RecalcJournalObservationsForm.Show;
end;

procedure TSgtsMainForm.MenuItemSvcRefreshCutsClick(Sender: TObject);
begin
  CoreIntf.RefreshCutsForm.Show;
end;

procedure TSgtsMainForm.MenuItemJrnJournalsClick(Sender: TObject);
begin
  CoreIntf.JrnJournalsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkGraphsClick(Sender: TObject);
begin
  CoreIntf.RbkGraphsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkGroupsClick(Sender: TObject);
begin
  CoreIntf.RbkGroupsForm.Show;
end;

procedure TSgtsMainForm.MenuItemRbkGroupObjectsClick(Sender: TObject);
begin
  CoreIntf.RbkGroupObjectsForm.Show;
end;

end.