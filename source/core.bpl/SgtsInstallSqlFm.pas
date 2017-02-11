unit SgtsInstallSqlFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsDialogFm, StdCtrls, ExtCtrls, DB, DBCtrls, ComCtrls, DbGrids, Grids, Mask,
  SgtsInstallSqlFmIntf, SgtsFm, SgtsDbGrid, SgtsCDS, SgtsCoreIntf, SgtsDatabaseModulesIntf,
  SgtsDatabaseIntf, SgtsSelectDefs,
  SgtsControls, SgtsLogIntf;

type
  TSgtsInstallSqlForm = class(TSgtsDialogForm)
    PanelParams: TPanel;
    GroupBoxParams: TGroupBox;
    Splitter: TSplitter;
    PanelScript: TPanel;
    GroupBoxScript: TGroupBox;
    DataSourceParams: TDataSource;
    DataSourceScript: TDataSource;
    PanelParamsGrid: TPanel;
    PanelScriptGrid: TPanel;
    ProgressBar: TProgressBar;
    PanelTop: TPanel;
    Label2: TLabel;
    EditDbModule: TEdit;
    ProgressBar2: TProgressBar;
    procedure ButtonInfoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FGridScript: TSgtsDbGrid;
    FGridParams: TSgtsDbGrid;
    FDataScript: TSgtsCDS;
    FDataParams: TSgtsCDS;
    FBreaked: Boolean;
    FDatabase: ISgtsDatabase;
    FSelectDefs: TSgtsSelectDefs;
    FInProcess: Boolean;
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
                                 DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure LoadDatabaseParams;
    procedure LoadDatabaseScript;
    function InstallScript: Boolean;
    procedure GridParamsDblClick(Sender: TObject);
    procedure GridScriptDblClick(Sender: TObject);
    procedure ButtonInstallClick(Sender: TObject);
    procedure ButtonUnInstallClick(Sender: TObject);
    procedure InstallProgressProc(Min,Max,Progress: Integer; var Breaked: Boolean);
    procedure DataScriptAfterScroll(DataSet: TDataSet);
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
  end;

  TSgtsInstallSqlIface=class(TSgtsDialogIface,ISgtsInstallSqlForm)
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    function Install: Boolean;
    function Uninstall: Boolean;

  end;

var
  SgtsInstallSqlForm: TSgtsInstallSqlForm;

implementation

{$R *.dfm}

uses SgtsConsts, SgtsUtils, SgtsDialogs, SgtsFieldEditFm, SgtsFieldEditFmIntf,
     SgtsObj, DBClient;

{ TSgtsInstallSqlIface }

procedure TSgtsInstallSqlIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsInstallSqlForm;
end;

procedure TSgtsInstallSqlIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  with TSgtsInstallSqlForm(AForm) do begin
    if Caption=SInstallSqlScript then begin
      ButtonOk.Caption:=SButtonCaptionInstall;
      ButtonOk.OnClick:=ButtonInstallClick;
    end;
    if Caption=SUnInstallSqlScript then begin
      ButtonOk.Caption:=SButtonCaptionUnInstall;
      ButtonOk.OnClick:=ButtonUnInstallClick;
    end;
  end;
end;

function TSgtsInstallSqlIface.Install: Boolean;
begin
  Caption:=SInstallSqlScript;
  Result:=ShowModal=mrOk;
end;

function TSgtsInstallSqlIface.Uninstall: Boolean;
begin
  Caption:=SUnInstallSqlScript;
  Result:=ShowModal=mrOk;
end;

{ TSgtsInstallSqlForm }

constructor TSgtsInstallSqlForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDataParams:=TSgtsCDS.Create(Self);
  with FDataParams do begin
    FieldDefs.Clear;
    FieldDefs.Add(SDb_Name,ftString,150);
    FieldDefs.Add(SDb_Description,ftString,250);
    FieldDefs.Add(SDb_Value,ftString,250);
    CreateDataSet;
  end;
  DataSourceParams.DataSet:=FDataParams;

  FGridParams:=TSgtsDbGrid.Create(Self);
  with FGridParams do begin
    Align:=alClient;
    Parent:=PanelParamsGrid;
    ColumnSortEnabled:=false;
    VisibleRowNumber:=true;
    Options:=Options-[dgTabs];
    DataSource:=DataSourceParams;
    OnDblClick:=GridParamsDblClick;
    ReadOnly:=false;
    with Columns.Add do begin
      FieldName:=SDb_Description;
      Title.Caption:='Описание';
      Width:=300;
      ReadOnly:=true;
    end;
    with Columns.Add do begin
      FieldName:=SDb_Value;
      Title.Caption:='Значение';
      Width:=150;
      ReadOnly:=false;
    end;
    TabOrder:=0;
  end;

  FDataScript:=TSgtsCDS.Create(Self);
  with FDataScript do begin
    FieldDefs.Clear;
    FieldDefs.Add(SDb_Type,ftInteger);
    FieldDefs.Add(SDb_Description,ftString,250);
    FieldDefs.Add(SDb_Value,ftBlob);
    FieldDefs.Add(SDb_Params,ftBlob);
    FieldDefs.Add(SDb_Info,ftBlob);
    FieldDefs.Add(SDb_Flag,ftInteger);
    CreateDataSet;
    AfterScroll:=DataScriptAfterScroll;
  end;
  DataSourceScript.DataSet:=FDataScript;

  FSelectDefs:=TSgtsSelectDefs.Create;
  with FSelectDefs do begin
    Add(SDb_Description,'Описание',380);
    Add(SDb_Flag_Ex,'Установлен',30);
  end;

  FGridScript:=TSgtsDbGrid.Create(Self);
  with FGridScript do begin
    Align:=alClient;
    Parent:=PanelScriptGrid;
    ColumnSortEnabled:=false;
    VisibleRowNumber:=true;
    DataSource:=DataSourceScript;
    Options:=Options-[dgEditing,dgTabs];
    OnDrawColumnCell:=GridDrawColumnCell;
    OnDblClick:=GridScriptDblClick;
    TabOrder:=0;
    LocateEnabled:=true;
    AutoFit:=true;
  end;
  CreateGridColumnsBySelectDefs(FGridScript,FSelectDefs);

  LoadDatabaseParams;
  LoadDatabaseScript;
end;

destructor TSgtsInstallSqlForm.Destroy;
begin
  FSelectDefs.Free;
  inherited Destroy;
end;

procedure TSgtsInstallSqlForm.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
                                                    DataCol: Integer; Column: TColumn; State: TGridDrawState);
   procedure DrawChecked(rt: TRect; isCheck: Boolean);
   begin
     if not isCheck then Begin
       DrawFrameControl(FGridScript.Canvas.Handle,Rt,DFC_BUTTON,DFCS_BUTTONCHECK);
     end else begin
       DrawFrameControl(FGridScript.Canvas.Handle,Rt,DFC_BUTTON,DFCS_CHECKED);
     end;
   end;
   
var
  rt: TRect;
begin
  if FDataScript.Active and not FDataScript.IsEmpty then begin
    rt.Right:=rect.Right;
    rt.Left:=rect.Left;
    rt.Top:=rect.Top+2;
    rt.Bottom:=rect.Bottom-2;
    if Column.FieldName=SDb_Flag_Ex then
      DrawChecked(rt,Boolean(FDataScript.FieldByName(SDb_Flag).AsInteger));
  end;
end;

procedure TSgtsInstallSqlForm.LoadDatabaseParams;
var
  i: Integer;
  DBModule: ISgtsDatabaseModule;
  DBParams: TSgtsCDS;
begin
  with CoreIntf do begin
    for i:=0 to DatabaseModules.Count-1 do begin
      DBModule:=DatabaseModules.Items[i];
      if Assigned(DBModule) then begin
        if AnsiSameText(DBModule.Name,CoreIntf.InstallSqlDBModule) then begin
          if Assigned(DBModule.Database) then begin
            EditDbModule.Text:=DBModule.Caption;
            FDatabase:=DBModule.Database;
            DBParams:=TSgtsCDS.Create(nil);
            FDataParams.DisableControls;
            try
              DBParams.XMLData:=DBModule.Database.GetConnectionParams;
              if DBParams.Active then begin
                FDataParams.EmptyDataSet;
                DBParams.First;
                while not DBParams.Eof do begin
                  FDataParams.FieldValuesBySource(DBParams);
                  DBParams.Next;
                end;
                FDataParams.First;
              end;
            finally
              FDataParams.EnableControls;
              DBParams.Free;
            end;
          end;
          break;
        end;
      end;
    end;
  end;
end;

procedure TSgtsInstallSqlForm.LoadDatabaseScript;
var
  DBScript: TSgtsCDS;
begin
  DBScript:=TSgtsCDS.Create(nil);
  FDataScript.DisableControls;
  try
    DBScript.LoadFromFile(CoreIntf.InstallSqlFile);
    if DBScript.Active then begin
      FDataScript.EmptyDataSet;
      DBScript.First;
      while not DBScript.Eof do begin
        FDataScript.Append;
        FDataScript.FieldValuesBySource(DBScript,true,false);
        FDataScript.Post;
        DBScript.Next;
      end;
      FDataScript.First;
    end;
  finally
    FDataScript.EnableControls;
    DBScript.Free;
  end;
end;

procedure TSgtsInstallSqlForm.ButtonInstallClick(Sender: TObject);
begin
  if ButtonOk.Caption=SButtonCaptionInstall then begin
    try
      ButtonOk.Caption:=SButtonCaptionAbort;
      FBreaked:=false;
      if InstallScript then begin
        if not FBreaked then begin
          ShowInfo(SInstallScriptSuccess);
          ModalResult:=mrOk
        end else
          ShowWarning(SActionBreaked);
      end else begin
        if not FBreaked then begin
          ShowWarning(SInstallScriptFailed,false);
        end else
          ShowWarning(SActionBreaked);
      end;
    finally
      ButtonOk.Caption:=SButtonCaptionInstall;
    end;
  end else
    FBreaked:=true;
end;

procedure TSgtsInstallSqlForm.ButtonUnInstallClick(Sender: TObject);
begin
  if ButtonOk.Caption=SButtonCaptionUnInstall then begin
    try
      ButtonOk.Caption:=SButtonCaptionAbort;
      FBreaked:=false;
      if InstallScript then begin
        if not FBreaked then begin
          ShowInfo(SUnInstallScriptSuccess);
          ModalResult:=mrOk;
        end else
          ShowWarning(SActionBreaked);
      end else
        if not FBreaked then begin
          ShowWarning(SUnInstallScriptFailed,false);
        end else
          ShowWarning(SActionBreaked);
    finally
      ButtonOk.Caption:=SButtonCaptionUnInstall;
    end;
  end else
    FBreaked:=true;
end;

procedure TSgtsInstallSqlForm.InstallProgressProc(Min,Max,Progress: Integer; var Breaked: Boolean);
begin
  ProgressBar2.Visible:=Progress>ProgressBar2.Min;
  ProgressBar2.Min:=Min;
  ProgressBar2.Max:=Max;
  ProgressBar2.Position:=Progress;
  ProgressBar2.Update;
  Application.ProcessMessages;
  Breaked:=FBreaked;
end;

function TSgtsInstallSqlForm.InstallScript: Boolean;

  function PrepareFileName(FileName: String): String;
  var
    Dir: String;
    FS: String;
  begin
    Result:=FileName;
    if FileExists(Result) then
      exit
    else begin
      Dir:=ExtractFileDir(Result);
      FS:=ExtractFileName(Result);
      if (Trim(Dir)='') and (Trim(FS)<>'') then begin
        Result:=ExtractFilePath(CoreIntf.CmdLine.FileName)+FS;
        if not FileExists(Result) then
          Result:=FileName;
      end;
    end;  
  end;

var
  Flag: Boolean;
  InstallType: TSgtsDatabaseInstallType;
  Position: Integer;
  Info: String;
  OldCursor: TCursor;
  FileDS: TSgtsCDS;
  Flag2: Boolean;
  S: String;
  i: Integer;
begin
  Result:=true;
  Iface.LogWrite(Format(SInstallSqlInstallScriptStart,[EditDbModule.Text]));
  if FDataScript.Active and not FDataScript.IsEmpty then begin
    FGridScript.Enabled:=false;
    FGridParams.Enabled:=false;
    FInProcess:=false;
    OldCursor:=Screen.Cursor;
    ProgressBar.Min:=0;
    ProgressBar.Max:=FDataScript.RecordCount;
    ProgressBar.Position:=0;
    ProgressBar2.Min:=0;
    ProgressBar2.Max:=0;
    ProgressBar2.Position:=0;
    try
      Screen.Cursor:=crHourGlass;
      if Assigned(FDatabase) then begin
        if FDatabase.LoginDefault(FDataParams.XMLData) then begin
          try
            FInProcess:=true;
            Position:=1;
            Flag:=true;
            FDataScript.First;
            while not FDataScript.Eof do begin
              Application.ProcessMessages;
              if FBreaked then break;


              Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentStart,[Position,FDataScript.FieldByName(SDb_Description).AsString]));

              InstallType:=TSgtsDatabaseInstallType(FDataScript.FieldByName(SDb_Type).AsInteger);
              case InstallType of
                itScript,itTable: begin
                  try
                    Info:='';
                    Flag:=FDatabase.Install(FDataScript.FieldByName(SDb_Value).AsString,InstallType,InstallProgressProc) and not FBreaked;
                    Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentSuccess,[Position,FDataScript.FieldByName(SDb_Description).AsString]));
                  except
                    On E: Exception do begin
                      Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentFailed,
                                           [Position,FDataScript.FieldByName(SDb_Description).AsString,E.Message]),ltError);
                      Info:=E.Message;
                      Flag:=false;
                    end;
                  end;
                end;

                itFile: begin
                  FileDS:=TSgtsCDS.Create(nil);
                  try
                    try
                      Info:='';
                      i:=1;
                      Flag:=true;
                      S:=PrepareFileName(FDataScript.FieldByName(SDb_Value).AsString);
                      Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentAsFileStart,[S]));
                      FileDS.LoadFromFile(S);
                      if FileDS.Active and
                         not FileDS.IsEmpty then begin
                        FileDS.First;
                        while not FileDS.Eof do begin
                          Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentAsFileCurrentStart,
                                                [S,i,FileDS.FieldByName(SDb_Description).AsString]));
                          InstallType:=TSgtsDatabaseInstallType(FileDS.FieldByName(SDb_Type).AsInteger);
                          try
                            Flag2:=FDatabase.Install(FileDS.FieldByName(SDb_Value).AsString,InstallType,InstallProgressProc) and not FBreaked;
                            Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentAsFileCurrentSuccess,
                                                  [S,i,FileDS.FieldByName(SDb_Description).AsString]));
                          except
                            on E: Exception do begin
                              Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentAsFileCurrentFailed,
                                                    [S,i,FileDS.FieldByName(SDb_Description).AsString,E.Message]),ltError);
                              raise;
                            end;  
                          end;
                          Flag:=Flag and Flag2;
                          Inc(i);
                          FileDS.Next;
                        end;
                        Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentSuccess,[Position,FDataScript.FieldByName(SDb_Description).AsString]));
                      end;
                    except
                      on E: Exception do begin
                        Iface.LogWrite(Format(SInstallSqlInstallScriptCurrentFailed,
                                              [Position,FDataScript.FieldByName(SDb_Description).AsString,E.Message]),ltError);
                        Info:=E.Message;
                        Flag:=false;
                      end;
                    end;
                  finally
                    FileDS.Free;
                  end;
                end;
              end;

              FDataScript.Edit;
              FDataScript.FieldByName(SDb_Info).AsString:=Info;
              FDataScript.FieldByName(SDb_Flag).AsInteger:=Integer(Flag);
              FDataScript.Post;

              Result:=Result and Flag;

              ProgressBar.Position:=Position;
              ProgressBar.Visible:=Position>ProgressBar.Min;
              ProgressBar.Update;

              Inc(Position);
              FDataScript.Next;
            end;
          finally
            FDatabase.LogoutDefault;
          end;
        end;
      end;
    finally
      FInProcess:=false;
      Screen.Cursor:=OldCursor;
      ProgressBar2.Position:=0;
      ProgressBar2.Visible:=false;
      ProgressBar.Position:=0;
      ProgressBar.Visible:=false;
      FGridParams.Enabled:=true;
      FGridScript.Enabled:=true;
    end;
  end;
end;

procedure TSgtsInstallSqlForm.GridScriptDblClick(Sender: TObject);
var
  AIface: TSgtsFieldEditIface;
  Value: Variant;
  OldCursor: TCursor;
begin
  if FDataScript.Active and not FDataScript.IsEmpty then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    AIface:=TSgtsFieldEditIface.Create(CoreIntf);
    try
      AIface.Init;
      AIface.Caption:=FDataScript.FieldByName(SDb_Description).AsString;
      AIface.Show(Format(SErrorInstallFormat,[FDataScript.FieldByName(SDb_Value).AsString,
                                              FDataScript.FieldByName(SDb_Info).AsString]),Value,etDefault);
      AIface.Done;
    finally
      AIface.Free;
      Screen.Cursor:=OldCursor;
    end;
  end;
end;

procedure TSgtsInstallSqlForm.GridParamsDblClick(Sender: TObject);
begin
  ButtonInfoClick(nil);
end;

procedure TSgtsInstallSqlForm.ButtonInfoClick(Sender: TObject);
var
  AIface: TSgtsFieldEditIface;
  Value: Variant;
begin
  if FDataParams.Active and not FDataParams.IsEmpty then begin
    AIface:=TSgtsFieldEditIface.Create(CoreIntf);
    try
      AIface.Init;
      AIface.Caption:=FDataParams.FieldByName(SDb_Description).AsString;
      if AIface.Show(FDataParams.FieldByName(SDb_Value).Value,Value,etDefault) then begin
        FDataParams.Edit;
        FDataParams.FieldByName(SDb_Value).Value:=Value;
        FDataParams.Post;
      end;
      AIface.Done;
    finally
      AIface.Free;
    end;
  end;
end;

procedure TSgtsInstallSqlForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=not FInProcess;
end;

procedure TSgtsInstallSqlForm.DataScriptAfterScroll(DataSet: TDataSet);
begin
  if Assigned(FGridScript) then
    FGridScript.UpdateRowNumber;
end;

end.
