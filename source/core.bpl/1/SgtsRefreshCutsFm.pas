unit SgtsRefreshCutsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, StdCtrls, DBGrids, DBClient, Menus,
  SgtsChildFm, SgtsCDS, SgtsSelectDefs, SgtsDatabaseIntf,
  SgtsCoreIntf, SgtsControls, SgtsDBGrid, SgtsDatabaseCDS;

type
  TSgtsRefreshCutsForm = class(TSgtsChildForm)
    PanelGrid: TPanel;
    PanelBottom: TPanel;
    ButtonRefresh: TButton;
    ButtonClose: TButton;
    GroupBoxOption: TGroupBox;
    PanelOption: TPanel;
    DataSource: TDataSource;
    PopupMenu: TPopupMenu;
    MenuItemRefreshCurrent: TMenuItem;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonRefreshClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PopupMenuPopup(Sender: TObject);
    procedure MenuItemRefreshCurrentClick(Sender: TObject);
  private
    FDataSet: TSgtsCDS;
    FGrid: TSgtsDBGrid;
    FSelectDefs: TSgtsSelectDefs;
    FCheckDef: TSgtsSelectDef;
    FBreaked: Boolean;
    FInProcess: Boolean;
    procedure ButtonBreakClick(Sender: TObject);
    procedure LoadData;
    function Refresh: Boolean;
    function RefreshCurrent: Boolean;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRefreshCutsIface=class(TSgtsChildIface)
  public
    procedure Init; override;
    function CanShow: Boolean; override;
  end;

var
  SgtsRefreshCutsForm: TSgtsRefreshCutsForm;

implementation

uses SgtsFm, SgtsIface, SgtsConsts, SgtsUtils, SgtsDialogs,
     SgtsDatabaseModulesIntf, SgtsProviderConsts, SgtsGetRecordsConfig,
     SgtsProviders;

{$R *.dfm}

{ TSgtsRefreshCutsIface }

procedure TSgtsRefreshCutsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRefreshCutsForm;
  InterfaceName:=SInterfaceRefreshCuts;
  with Permissions do begin
    AddDefault(SPermissionNameShow);
  end;
end;

function TSgtsRefreshCutsIface.CanShow: Boolean; 
begin
  Result:=PermissionExists(SPermissionNameShow)
end;

{ TSgtsRefreshCutsForm }

constructor TSgtsRefreshCutsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDataSet:=TSgtsCDS.Create(Self);
  with FDataSet do begin
    FieldDefs.Clear;
    FieldDefs.Add('CUT_ID',ftInteger);
    FieldDefs.Add(SDb_Description,ftString,250);
    FieldDefs.Add(SDb_ProcName,ftString,100);
    FieldDefs.Add(SDb_Flag,ftInteger);
    CreateDataSet;
  end;
  DataSource.DataSet:=FDataSet;

  FSelectDefs:=TSgtsSelectDefs.Create;
  with FSelectDefs do begin
    Add(SDb_Description,'Описание',250);
    FCheckDef:=AddDrawCheck(SDb_Flag_Ex,'Обновлен',SDb_Flag,30);
    Find(FCheckDef.CalcName).Field:=FDataSet.FieldByName(SDb_Flag);
  end;

  FGrid:=TSgtsDBGrid.Create(Self);
  with FGrid do begin
    Align:=alClient;
    Parent:=PanelOption;
    ColumnSortEnabled:=false;
    VisibleRowNumber:=true;
    DataSource:=Self.DataSource;
    Options:=Options-[dgEditing,dgTabs];
    OnDblClick:=nil;
    LocateEnabled:=true;
    ColMoving:=false;
    AutoFit:=true;
  end;
  FGrid.PopupMenu:=PopupMenu;

  CreateGridColumnsBySelectDefs(FGrid,FSelectDefs);

  LoadData;
end;

procedure TSgtsRefreshCutsForm.LoadData;
var
  DS: TSgtsDatabaseCDS;
begin
  DS:=TSgtsDatabaseCDS.Create(CoreIntf);
  try
    DS.ProviderName:=SProviderSelectCuts;
    with DS.SelectDefs do begin
      AddInvisible('CUT_ID');
      AddInvisible('NAME');
      AddInvisible('PROC_NAME');
    end;
    DS.FilterGroups.Add.Filters.Add('PROC_NAME',fcIsNotNull,Null);
    DS.Orders.Add('PRIORITY',otAsc);
    DS.Open;
    if DS.Active and
       not DS.IsEmpty then begin
      DS.First;
      while not DS.Eof do begin
        FDataSet.Append;
        FDataSet.FieldByName('CUT_ID').Value:=DS.FieldByName('CUT_ID').Value;
        FDataSet.FieldByName(SDb_Description).Value:=DS.FieldByName('NAME').Value;
        FDataSet.FieldByName(SDb_ProcName).Value:=DS.FieldByName('PROC_NAME').Value;
        FDataSet.FieldByName(SDb_Flag).Value:=Integer(False);
        FDataSet.Post;
        DS.Next;
      end;
      FDataSet.First;
    end;   
  finally
    DS.Free;
  end;
end;

procedure TSgtsRefreshCutsForm.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSgtsRefreshCutsForm.ButtonRefreshClick(Sender: TObject);
var
  OldCaption: String;
begin
  ButtonRefresh.OnClick:=ButtonBreakClick;
  OldCaption:=ButtonRefresh.Caption;
  FGrid.Enabled:=false;
  try
    ButtonRefresh.Caption:=SButtonCaptionAbort;
    if Refresh then
      ShowInfo(SRefreshCutsSuccess);
  finally
    FGrid.Enabled:=true;
    ButtonRefresh.Caption:=OldCaption;
    ButtonRefresh.OnClick:=ButtonRefreshClick;
  end;
end;

function TSgtsRefreshCutsForm.Refresh: Boolean;
var
  i: Integer;
  OldCursor: TCursor;
begin
  Result:=false;
  FBreaked:=false;
  OldCursor:=Screen.Cursor;
  CoreIntf.MainForm.Progress(0,FDataSet.RecordCount,0);
  FInProcess:=false;
  try
    FInProcess:=true;
    Screen.Cursor:=crHourGlass;
    i:=1;
    FDataSet.First;
    while not FDataSet.Eof do begin
      Application.ProcessMessages;
      if FBreaked then break;
      Result:=RefreshCurrent;
      Update;
      CoreIntf.MainForm.Progress(0,FDataSet.RecordCount,i);
      inc(i);
      FDataSet.Next;
    end;
    Result:=Result and not FBreaked;
  finally
    FInProcess:=false;
    Screen.Cursor:=OldCursor;
    CoreIntf.MainForm.Progress(0,0,0);
  end;
end;

procedure TSgtsRefreshCutsForm.ButtonBreakClick(Sender: TObject);
begin
  FBreaked:=true;
end;

procedure TSgtsRefreshCutsForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=not FInProcess;
end;

function TSgtsRefreshCutsForm.RefreshCurrent: Boolean;

  function Found(CutId: Variant; ProcName: String; var Checked: Boolean): Boolean;
  begin
    FDataSet.BeginUpdate(true);
    try
      Result:=false;
      FDataSet.First;
      while not FDataSet.Eof do begin
        if (CutId=FDataSet.FieldByName('CUT_ID').Value) then begin
          exit;
        end;
        if AnsiSameText(FDataSet.FieldByName(SDb_ProcName).AsString,ProcName) then begin
          Result:=true;
          Checked:=Boolean(FDataSet.FieldByName(SDb_Flag).AsInteger);
          exit;
        end;
        FDataSet.Next;
      end;
    finally
      FDataSet.EndUpdate(false);
    end;
  end;

var
  Database: ISgtsDatabase;
  ProcName: String;
  IsFound: Boolean;
  Flag: Boolean;
  Provider: TSgtsExecuteProvider;
  DS: TSgtsDatabaseCDS;
  OldCursor: TCursor;
begin
  Result:=false;
  Database:=nil;
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  try
    if Assigned(CoreIntf.DatabaseModules.Current) then
      Database:=CoreIntf.DatabaseModules.Current.Database;
    if Assigned(Database) then begin
      if FDataSet.Active and not FDataSet.IsEmpty then begin
        ProcName:=FDataSet.FieldByName(SDb_ProcName).Value;
        if Trim(ProcName)<>'' then begin
          IsFound:=Found(FDataSet.FieldByName('CUT_ID').Value,ProcName,Flag);
          if not IsFound then begin
            Provider:=Database.ExecuteProviders.AddDefault(ProcName);
            DS:=TSgtsDatabaseCDS.Create(CoreIntf);
            try
              DS.ProviderName:=ProcName;
              DS.StopException:=false;
              try
                DS.Execute;
                Flag:=true;
              except
                Flag:=false;
              end;
              FDataSet.Edit;
              FDataSet.FieldByName(SDb_Flag).Value:=Integer(Flag);
              FDataSet.Post;
              Result:=Flag;
            finally
              DS.Free;
              Database.GetRecordsProviders.Remove(Provider);
            end;
          end else begin
            FDataSet.Edit;
            FDataSet.FieldByName(SDb_Flag).Value:=Integer(Flag);
            FDataSet.Post;
          end;
        end;
      end;
    end;
  finally
    Screen.Cursor:=OldCursor;
  end;  
end;

procedure TSgtsRefreshCutsForm.PopupMenuPopup(Sender: TObject);
begin
  MenuItemRefreshCurrent.Visible:=FDataSet.Active and not FDataSet.IsEmpty;
  if MenuItemRefreshCurrent.Visible then begin
    MenuItemRefreshCurrent.Caption:='Обновить срез: '+FDataSet.FieldByName(SDb_Description).AsString;
  end;
end;

procedure TSgtsRefreshCutsForm.MenuItemRefreshCurrentClick(
  Sender: TObject);
begin
  RefreshCurrent;
end;

end.
