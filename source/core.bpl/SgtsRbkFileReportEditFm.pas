unit SgtsRbkFileReportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsCoreIntf, SgtsExecuteDefs;

type
  TSgtsRbkFileReportEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    LabelFileName: TLabel;
    EditFileName: TEdit;
    ButtonFileName: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
    LabelModule: TLabel;
    ComboBoxModule: TComboBox;
    LabelMenu: TLabel;
    EditMenu: TEdit;
    procedure ComboBoxModuleChange(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
  end;

  TSgtsRbkFileReportInsertIface=class(TSgtsDataInsertIface)
  private
    FFileNameDef: TSgtsExecuteDefFileName;
    procedure FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  protected
    property FileNameDef: TSgtsExecuteDefFileName read FFileNameDef;
  public
    procedure Init; override;
  end;

  TSgtsRbkFileReportUpdateIface=class(TSgtsDataUpdateIface)
  private
    FFileNameDef: TSgtsExecuteDefFileName;
    procedure FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  protected
    property FileNameDef: TSgtsExecuteDefFileName read FFileNameDef;
  public
    procedure Init; override;
  end;

  TSgtsRbkFileReportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkFileReportEditForm: TSgtsRbkFileReportEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsReportModules, SgtsOptionsFmIntf;

{$R *.dfm}

{ TSgtsRbkFileReportInsertIface }

procedure TSgtsRbkFileReportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkFileReportEditForm;
  InterfaceName:=SInterfaceFileReportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertFileReport;
    with ExecuteDefs do begin
      AddKey('FILE_REPORT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      AddCombo('MODULE_NAME','ComboBoxModule','LabelModule',true);
      FFileNameDef:=AddFileName('FILE_NAME','EditFileName','LabelFileName','ButtonFileName',SFilterReports,true);
      FFileNameDef.InitialDir:=CoreIntf.OptionsForm.ReportCatalog;
      FFileNameDef.OnCheckValue:=FileNameCheckValue;
      AddEdit('MENU','EditMenu','LabelMenu',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkFileReportInsertIface.FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  FileName: String;
  Catalog: String;
  APos: Integer;
begin
  FileName:=VarToStrDef(NewValue,'');
  Catalog:=Trim(CoreIntf.OptionsForm.ReportCatalog);
  APos:=AnsiPos(Catalog,FileName);
  if APos=1 then begin
    FileName:=Copy(FileName,APos+Length(Catalog)+Length(PathDelim),Length(FileName));
  end;
  NewValue:=FileName;
end;

{ TSgtsRbkFileReportUpdateIface }

procedure TSgtsRbkFileReportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkFileReportEditForm;
  InterfaceName:=SInterfaceFileReportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateFileReport;
    with ExecuteDefs do begin
      AddKeyLink('FILE_REPORT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      AddCombo('MODULE_NAME','ComboBoxModule','LabelModule',true);
      FFileNameDef:=AddFileName('FILE_NAME','EditFileName','LabelFileName','ButtonFileName',SFilterReports,true);
      FFileNameDef.InitialDir:=CoreIntf.OptionsForm.ReportCatalog;
      FFileNameDef.OnCheckValue:=FileNameCheckValue;
      AddEdit('MENU','EditMenu','LabelMenu',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkFileReportUpdateIface.FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  FileName: String;
  Catalog: String;
  APos: Integer;
begin
  FileName:=VarToStrDef(NewValue,'');
  Catalog:=Trim(CoreIntf.OptionsForm.ReportCatalog);
  APos:=AnsiPos(Catalog,FileName);
  if APos=1 then begin
    FileName:=Copy(FileName,APos+Length(Catalog)+Length(PathDelim),Length(FileName));
  end;
  NewValue:=FileName;
end;

{ TSgtsRbkFileReportDeleteIface }

procedure TSgtsRbkFileReportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceFileReportDelete;
  DeleteQuestion:='Удалить отчет %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteFileReport;
    with ExecuteDefs do begin
      AddKeyLink('FILE_REPORT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

{ TSgtsRbkFileReportEditForm }

constructor TSgtsRbkFileReportEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  with ACoreIntf do begin
    GetReportModules(ComboBoxModule.Items);
  end;
end;

procedure TSgtsRbkFileReportEditForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  if ComboBoxModule.Items.Count>0 then begin
    ComboBoxModule.ItemIndex:=0;
    ComboBoxModuleChange(ComboBoxModule);
  end;
end;

procedure TSgtsRbkFileReportEditForm.ComboBoxModuleChange(Sender: TObject);
var
  Index: Integer;
  Module: TSgtsReportModule;
begin
  Index:=ComboBoxModule.ItemIndex;
  if Index<>-1 then begin
    Module:=TSgtsReportModule(ComboBoxModule.Items.Objects[Index]);
    if Assigned(Module) then begin
      if Iface is TSgtsRbkFileReportInsertIface then begin
        with TSgtsRbkFileReportInsertIface(Iface) do begin
          FileNameDef.Filter:=Module.Filter;
        end;
      end;
      if Iface is TSgtsRbkFileReportUpdateIface then begin
        with TSgtsRbkFileReportUpdateIface(Iface) do begin
          FileNameDef.Filter:=Module.Filter;
        end;
      end;
    end;
  end else begin
    if Iface is TSgtsRbkFileReportInsertIface then begin
      with TSgtsRbkFileReportInsertIface(Iface) do begin
        FileNameDef.Filter:=SFilterReports;
      end;
    end;
    if Iface is TSgtsRbkFileReportUpdateIface then begin
      with TSgtsRbkFileReportUpdateIface(Iface) do begin
        FileNameDef.Filter:=SFilterReports;
      end;
    end;
  end;
end;

end.
