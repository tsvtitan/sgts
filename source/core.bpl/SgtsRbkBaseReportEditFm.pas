unit SgtsRbkBaseReportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB, Contnrs,
  frxClass,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf, SgtsExecuteDefs, SgtsBaseReportClasses;

type
  TSgtsRbkBaseReportEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    ButtonReport: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
    LabelMenu: TLabel;
    EditMenu: TEdit;
    procedure ButtonReportClick(Sender: TObject);
  private
    FReport: TSgtsBaseReport;
    FDataSets: TObjectList; 
    procedure FillDataSets;
    function GetReportDef: TSgtsExecuteDefInvisible;
    function GetReportIdDef: TSgtsExecuteDef;
    procedure DesignReport;
    function GetNameByDef: String;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    destructor Destroy; override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
  end;

  TSgtsRbkBaseReportInsertIface=class(TSgtsDataInsertIface)
  private
    FBaseReportIdDef: TSgtsExecuteDefKey;
    FNameDef: TSgtsExecuteDefEdit;
    FReportDef: TSgtsExecuteDefInvisible;
    FDescriptionDef: TSgtsExecuteDefMemo;
    FMenuDef: TSgtsExecuteDefEdit;
  protected
    property ReportDef: TSgtsExecuteDefInvisible read FReportDef;
    property NameDef: TSgtsExecuteDefEdit read FNameDef;
    property BaseReportIdDef: TSgtsExecuteDefKey read FBaseReportIdDef;
  public
    procedure Init; override;
    procedure Insert; override;
  end;

  TSgtsRbkBaseReportUpdateIface=class(TSgtsDataUpdateIface)
  private
    FBaseReportIdDef: TSgtsExecuteDefKeyLink;
    FNameDef: TSgtsExecuteDefEdit;
    FReportDef: TSgtsExecuteDefInvisible;
    FDescriptionDef: TSgtsExecuteDefMemo;
    FMenuDef: TSgtsExecuteDefEdit;
  protected
    property ReportDef: TSgtsExecuteDefInvisible read FReportDef;
    property NameDef: TSgtsExecuteDefEdit read FNameDef;
    property BaseReportIdDef: TSgtsExecuteDefKeyLink read FBaseReportIdDef;
  public
    procedure Init; override;
    procedure Update; override;
  end;

  TSgtsRbkBaseReportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
    procedure Delete; override;
  end;

var
  SgtsRbkBaseReportEditForm: TSgtsRbkBaseReportEditForm;

implementation

uses DBClient, TypInfo,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsOptionsFmIntf, SgtsCDS,
     SgtsConfigIntf, SgtsCoreObj, SgtsDataFm, SgtsFunSourceDataFm, SgtsBaseReportFm;

{$R *.dfm}

{ TSgtsRbkBaseReportInsertIface }

procedure TSgtsRbkBaseReportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkBaseReportEditForm;
  InterfaceName:=SInterfaceBaseReportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertBaseReport;
    with ExecuteDefs do begin
      FBaseReportIdDef:=AddKey('BASE_REPORT_ID');
      FNameDef:=AddEdit('NAME','EditName','LabelName',true);
      FReportDef:=AddInvisible('REPORT');
      FDescriptionDef:=AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FMenuDef:=AddEdit('MENU','EditMenu','LabelMenu',false);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',false);
    end;
  end;
end;

procedure TSgtsRbkBaseReportInsertIface.Insert;
begin
  inherited Insert;
  CoreIntf.RefreshReports;
end;

{ TSgtsRbkBaseReportUpdateIface }

procedure TSgtsRbkBaseReportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkBaseReportEditForm;
  InterfaceName:=SInterfaceBaseReportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateBaseReport;
    with ExecuteDefs do begin
      FBaseReportIdDef:=AddKeyLink('BASE_REPORT_ID');
      FNameDef:=AddEdit('NAME','EditName','LabelName',true);
      FReportDef:=AddInvisible('REPORT');
      FDescriptionDef:=AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FMenuDef:=AddEdit('MENU','EditMenu','LabelMenu',false);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',false);
    end;
  end;
end;

procedure TSgtsRbkBaseReportUpdateIface.Update;
begin
  inherited Update;
  CoreIntf.RefreshReports;
end;

{ TSgtsRbkBaseReportDeleteIface }

procedure TSgtsRbkBaseReportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceBaseReportDelete;
  DeleteQuestion:='������� ����� %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteBaseReport;
    with ExecuteDefs do begin
      AddKeyLink('BASE_REPORT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

procedure TSgtsRbkBaseReportDeleteIface.Delete;
begin
  inherited Delete;
  CoreIntf.RefreshReports;
end; 

{ TSgtsRbkBaseReportEditForm }

constructor TSgtsRbkBaseReportEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  FDataSets:=TObjectList.Create;
  FReport:=TSgtsBaseReport.Create(nil);
  FReport.InitByCore(ACoreIntf);
  FReport.Name:=SReport;
  FReport.PreviewOptions.Buttons:=FReport.PreviewOptions.Buttons-[pbEdit,pbExportQuick];
  FReport.PreviewOptions.ZoomMode:=zmPageWidth;
  FReport.IniFile:=CoreIntf.Config.Read(SConfigSectionReportDesigner,SConfigParamIniFile,FReport.IniFile);
  if ExtractFilePath(FReport.IniFile)='' then
    FReport.IniFile:=ExtractFilePath(CoreIntf.CmdLine.FileName)+FReport.IniFile;
end;

destructor TSgtsRbkBaseReportEditForm.Destroy;
begin
  FReport.Free;
  FDataSets.Free;
  inherited Destroy;
end;

procedure TSgtsRbkBaseReportEditForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
end;

function TSgtsRbkBaseReportEditForm.GetNameByDef: String;
begin
  Result:='';
  if Iface is TSgtsRbkBaseReportInsertIface then
    Result:=VarToStrDef(TSgtsRbkBaseReportInsertIface(Iface).NameDef.Value,'');
  if Iface is TSgtsRbkBaseReportUpdateIface then
    Result:=VarToStrDef(TSgtsRbkBaseReportUpdateIface(Iface).NameDef.Value,'');
end;

procedure TSgtsRbkBaseReportEditForm.FillDataSets;
var
  ADataIface: TSgtsDataIface;
  ASourceIface: TSgtsFunSourceDataIface;
  Str: TStringList;
  i: Integer;
  ReportDS: TSgtsBaseReportDataSet;
  DatabaseDS: TSgtsDatabaseCDS;
  LocalDS: TSgtsCDS;
  RInfo: TSgtsBaseReportIfaceClassInfo;
begin
  Str:=TStringList.Create;
  try
    FDataSets.Clear;

    CoreIntf.GetInterfaceNames(Str,TSgtsDataIface);
    for i:=0 to Str.Count-1 do begin
      ADataIface:=TSgtsDataIface(Str.Objects[i]);
      if Assigned(ADataIface) and ADataIface.CanShow and
        (ADataIface.ReportClassInfos.Count>0) and Assigned(ADataIface.DataSet) then begin
        RInfo:=ADataIface.ReportClassInfos.FindIface(GetNameByDef);
        if Assigned(RInfo) then begin
          DatabaseDS:=TSgtsDatabaseCDS.Create(CoreIntf);
          DatabaseDS.Assign(ADataIface.DataSet);
          DatabaseDS.PacketRecords:=100;
          FDataSets.Add(DatabaseDS);

          ReportDS:=TSgtsBaseReportDataSet.Create(nil);
          ReportDS.Name:=ADataIface.DataSet.Name;
          ReportDS.DataSet:=DatabaseDS;
          FDataSets.Add(ReportDS);

          FReport.DeleteDataSets(ReportDS);
        end;
      end;
    end;

    Str.Clear;
    CoreIntf.GetInterfaceNames(Str,TSgtsFunSourceDataIface);
    for i:=0 to Str.Count-1 do begin
      ASourceIface:=TSgtsFunSourceDataIface(Str.Objects[i]);
      if Assigned(ASourceIface) and ASourceIface.CanShow and
        (ASourceIface.ReportClassInfos.Count>0) and Assigned(ASourceIface.DataSet) then begin
        RInfo:=ASourceIface.ReportClassInfos.FindIface(GetNameByDef);
        if Assigned(RInfo) then begin
          LocalDS:=TSgtsCDS.Create(nil);
          //LocalDS.Assign(ASourceIface.DataSet);
          FDataSets.Add(LocalDS);

          ReportDS:=TSgtsBaseReportDataSet.Create(nil);
          ReportDS.Name:=ASourceIface.DataSet.Name;
          ReportDS.DataSet:=LocalDS;
          FDataSets.Add(ReportDS);

          FReport.DeleteDataSets(ReportDS);
        end;
      end;
    end;

    FReport.UpdateDatabands;
  finally
    Str.Free;
  end;
end;

function TSgtsRbkBaseReportEditForm.GetReportDef: TSgtsExecuteDefInvisible;
begin
  Result:=nil;
  if Iface is TSgtsRbkBaseReportInsertIface then
    Result:=TSgtsRbkBaseReportInsertIface(Iface).ReportDef;
  if Iface is TSgtsRbkBaseReportUpdateIface then
    Result:=TSgtsRbkBaseReportUpdateIface(Iface).ReportDef;
end;

function TSgtsRbkBaseReportEditForm.GetReportIdDef: TSgtsExecuteDef;
begin
  Result:=nil;
  if Iface is TSgtsRbkBaseReportInsertIface then
    Result:=TSgtsRbkBaseReportInsertIface(Iface).BaseReportIdDef;
  if Iface is TSgtsRbkBaseReportUpdateIface then
    Result:=TSgtsRbkBaseReportUpdateIface(Iface).BaseReportIdDef;
end;

procedure TSgtsRbkBaseReportEditForm.ButtonReportClick(Sender: TObject);
begin
  DesignReport;
end;

procedure TSgtsRbkBaseReportEditForm.DesignReport;
var
  ReportDef: TSgtsExecuteDefInvisible;
  ReportIdDef: TSgtsExecuteDef;
  Stream: TMemoryStream;
  OldCursor: TCursor;
begin
  ReportDef:=GetReportDef;
  ReportIdDef:=GetReportIdDef;
  if Assigned(ReportDef) and
     Assigned(ReportIdDef) then begin
    Stream:=TMemoryStream.Create;
    try

      OldCursor:=Screen.Cursor;
      try
        Screen.Cursor:=crHourGlass;
        ReportDef.SaveValueToStream(Stream);
        Stream.Position:=0;
        if Stream.Size>0 then begin
          try
            FReport.LoadFromStream(Stream);
            FillDataSets;
          except
            on E: Exception do
              ShowError(E.Message);
          end;
        end;
      finally
        Screen.Cursor:=OldCursor;
      end;

      FReport.ReportOptions.Name:=Format(SReportNameFormat,[VarToStrDef(ReportIdDef.Value,'')]);
      
      if FReport.DesignReportAsModal then begin
        OldCursor:=Screen.Cursor;
        try
          Screen.Cursor:=crHourGlass;
          Stream.Clear;
          FReport.SaveToStream(Stream);
          Stream.Position:=0;
          ReportDef.LoadValueFromStream(Stream);
          ReportDef.Change(ButtonReport);
        finally
          Screen.Cursor:=OldCursor;
        end;
      end;
    finally
      Stream.Free;
    end;  
  end;
end;

end.
