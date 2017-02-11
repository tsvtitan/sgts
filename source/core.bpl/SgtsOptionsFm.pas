unit SgtsOptionsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ImgList,
  SgtsDialogFm, SgtsFm,
  SgtsOptionsFmIntf, SgtsCoreIntf, SgtsControls;

type
  TSgtsOptionsForm = class(TSgtsDialogForm)
    PanelTree: TPanel;
    PanelDetail: TPanel;
    TreeView: TTreeView;
    PageControl: TPageControl;
    TabSheetGeneral: TTabSheet;
    ImageList: TImageList;
    PanelTop: TPanel;
    PanelCaption: TPanel;
    LabelCaption: TLabel;
    CheckBoxRunMaximized: TCheckBox;
    RadioGroupWindowsOpen: TRadioGroup;
    CheckBoxOpenFunSourceData: TCheckBox;
    TabSheetCatalogs: TTabSheet;
    LabelDocumentCatalog: TLabel;
    EditDocumentCatalog: TEdit;
    ButtonDocumentCatalog: TButton;
    LabelDrawingCatalog: TLabel;
    EditDrawingCatalog: TEdit;
    ButtonDrawingCatalog: TButton;
    LabelReportCatalog: TLabel;
    EditReportCatalog: TEdit;
    ButtonReportCatalog: TButton;
    CheckBoxSaveSizes: TCheckBox;
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure ButtonDocumentCatalogClick(Sender: TObject);
    procedure ButtonDrawingCatalogClick(Sender: TObject);
    procedure ButtonReportCatalogClick(Sender: TObject);
  private
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsOptionsIface=class(TSgtsDialogIface,ISgtsOptionsForm)
  private
    FWindowOpen: TSgtsOptionsWindowOpen;
    FOpenFunSourceData: Boolean;
    FSaveSizes: Boolean;
    FDocumentCatalog: String;
    FDrawingCatalog: String;
    FReportCatalog: String;
    function GetForm: TSgtsOptionsForm;
    function _GetWindowOpen: TSgtsOptionsWindowOpen;
    procedure _SetWindowOpen(Value: TSgtsOptionsWindowOpen);
    function _GetOpenFunSourceData: Boolean;
    procedure _SetOpenFunSourceData(Value: Boolean);
    function _GetSaveSizes: Boolean;
    procedure _SetSaveSizes(Value: Boolean);
    function _GetDocumentCatalog: String;
    function _GetDrawingCatalog: String;
    function _GetReportCatalog: String;
  protected
    function GetFormClass: TSgtsFormClass; override;
  public
    procedure Init; override;
    procedure Done; override;
    function CanShow: Boolean; override;
    procedure BeforeShowModal; override;
    procedure AfterShowModal(ModalResult: TModalResult); override;
    procedure ReadParams(DatabaseConfig: Boolean=true); override;
    procedure WriteParams(DatabaseConfig: Boolean=true); override;

    property Form: TSgtsOptionsForm read GetForm;
  end;

var
  SgtsOptionsForm: TSgtsOptionsForm;

implementation

uses rxFileUtil,
     SgtsCoreObj, SgtsMainFmIntf, SgtsIface, SgtsConsts, SgtsUtils;

{$R *.dfm}

{ TSgtsOptionsIface }

procedure TSgtsOptionsIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceOptions;
  StoredInConfig:=true;
  with Permissions do begin
    AddDefault(SPermissionNameShow);
    AddDefault(SPermissionNameSetCatalog);
  end;
end;

function TSgtsOptionsIface.GetForm: TSgtsOptionsForm;
begin
  Result:=TSgtsOptionsForm(inherited Form);
end;

function TSgtsOptionsIface.GetFormClass: TSgtsFormClass;
begin
  Result:=TSgtsOptionsForm;
end;

procedure TSgtsOptionsIface.Done;
begin
  inherited Done;
end;

function TSgtsOptionsIface.CanShow: Boolean;
begin
  Result:=inherited CanShow and
          PermissionExists(SPermissionNameShow);
end;

procedure TSgtsOptionsIface.BeforeShowModal;
begin
  inherited BeforeShowModal;
  with CoreIntf,Form do begin
    CheckBoxRunMaximized.Checked:=MainForm.WindowMaximized;
    RadioGroupWindowsOpen.ItemIndex:=Integer(FWindowOpen);
    CheckBoxOpenFunSourceData.Checked:=FOpenFunSourceData;
    CheckBoxSaveSizes.Checked:=FSaveSizes;

    EditDocumentCatalog.Text:=FDocumentCatalog;
    LabelDocumentCatalog.Enabled:=PermissionExists(SPermissionNameSetCatalog);
    EditDocumentCatalog.ReadOnly:=not LabelDocumentCatalog.Enabled;
    EditDocumentCatalog.Color:=iff(EditDocumentCatalog.ReadOnly,clBtnFace,clWindow);
    EditDocumentCatalog.Enabled:=LabelDocumentCatalog.Enabled;
    ButtonDocumentCatalog.Enabled:=LabelDocumentCatalog.Enabled;

    EditDrawingCatalog.Text:=FDrawingCatalog;
    LabelDrawingCatalog.Enabled:=PermissionExists(SPermissionNameSetCatalog);
    EditDrawingCatalog.ReadOnly:=not LabelDrawingCatalog.Enabled;
    EditDrawingCatalog.Color:=iff(EditDrawingCatalog.ReadOnly,clBtnFace,clWindow);
    EditDrawingCatalog.Enabled:=LabelDrawingCatalog.Enabled;
    ButtonDrawingCatalog.Enabled:=LabelDrawingCatalog.Enabled;

    EditReportCatalog.Text:=FReportCatalog;
    LabelReportCatalog.Enabled:=PermissionExists(SPermissionNameSetCatalog);
    EditReportCatalog.ReadOnly:=not LabelReportCatalog.Enabled;
    EditReportCatalog.Color:=iff(EditReportCatalog.ReadOnly,clBtnFace,clWindow);
    EditReportCatalog.Enabled:=LabelReportCatalog.Enabled;
    ButtonReportCatalog.Enabled:=LabelReportCatalog.Enabled;
  end;
end;

procedure TSgtsOptionsIface.AfterShowModal(ModalResult: TModalResult);
begin
  inherited AfterShowModal(ModalResult);
  if ModalResult=mrOk then begin
    with CoreIntf,Form do begin
      MainForm.WindowMaximized:=CheckBoxRunMaximized.Checked;
      FWindowOpen:=TSgtsOptionsWindowOpen(RadioGroupWindowsOpen.ItemIndex);
      FOpenFunSourceData:=CheckBoxOpenFunSourceData.Checked;
      FSaveSizes:=CheckBoxSaveSizes.Checked;
      FDocumentCatalog:=EditDocumentCatalog.Text;
      FDrawingCatalog:=EditDrawingCatalog.Text;
      FReportCatalog:=EditReportCatalog.Text;
      WriteParams;
      Config.UpdateFile;
    end;
  end;
end;

function TSgtsOptionsIface._GetWindowOpen: TSgtsOptionsWindowOpen;
begin
  Result:=FWindowOpen;
end;

procedure TSgtsOptionsIface._SetWindowOpen(Value: TSgtsOptionsWindowOpen);
begin
  FWindowOpen:=Value;
end;

function TSgtsOptionsIface._GetOpenFunSourceData: Boolean;
begin
  Result:=FOpenFunSourceData;
end;

procedure TSgtsOptionsIface._SetOpenFunSourceData(Value: Boolean);
begin
  FOpenFunSourceData:=Value;
end;

function TSgtsOptionsIface._GetSaveSizes: Boolean;
begin
  Result:=FSaveSizes;
end;

procedure TSgtsOptionsIface._SetSaveSizes(Value: Boolean);
begin
  FSaveSizes:=Value;
end;

function TSgtsOptionsIface._GetDocumentCatalog: String;
begin
  Result:=FDocumentCatalog;
end;

function TSgtsOptionsIface._GetDrawingCatalog: String;
begin
  Result:=FDrawingCatalog;
end;

function TSgtsOptionsIface._GetReportCatalog: String;
begin
  Result:=FReportCatalog;
end;

procedure TSgtsOptionsIface.ReadParams; 
begin
  FWindowOpen:=ReadParam(SConfigParamWindowOpen,woTopLeft);
  FOpenFunSourceData:=ReadParam(SConfigParamOpenFunSourceData,true);
  FSaveSizes:=ReadParam(SConfigParamSaveSizes,true);
  FDocumentCatalog:=ReadParam(SConfigParamDocumentCatalog,FDocumentCatalog);
  FDrawingCatalog:=ReadParam(SConfigParamDrawingCatalog,FDrawingCatalog);
  FReportCatalog:=ReadParam(SConfigParamReportCatalog,FReportCatalog);
end;

procedure TSgtsOptionsIface.WriteParams;
begin
  WriteParam(SConfigParamWindowOpen,FWindowOpen);
  WriteParam(SConfigParamOpenFunSourceData,FOpenFunSourceData);
  WriteParam(SConfigParamSaveSizes,FSaveSizes);
  WriteParam(SConfigParamDocumentCatalog,FDocumentCatalog);
  WriteParam(SConfigParamDrawingCatalog,FDrawingCatalog);
  WriteParam(SConfigParamReportCatalog,FReportCatalog);
end;

{ TSgtsOptionsForm }

constructor TSgtsOptionsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  PageControl.ActivePage:=TabSheetGeneral;
end;

procedure TSgtsOptionsForm.TreeViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(Node) then begin
    case Node.Index of
      0: PageControl.ActivePage:=TabSheetGeneral;
      1: PageControl.ActivePage:=TabSheetCatalogs;
    end;
    LabelCaption.Caption:=PageControl.ActivePage.Caption;
  end;
end;

procedure TSgtsOptionsForm.ButtonDocumentCatalogClick(Sender: TObject);
var
  Directory: string;
begin
  Directory:=EditDocumentCatalog.Text;
  if BrowseDirectory(Directory,SSelectDirectory,0) then begin
    EditDocumentCatalog.Text:=Directory;
  end;
end;

procedure TSgtsOptionsForm.ButtonDrawingCatalogClick(Sender: TObject);
var
  Directory: string;
begin
  Directory:=EditDrawingCatalog.Text;
  if BrowseDirectory(Directory,SSelectDirectory,0) then begin
    EditDrawingCatalog.Text:=Directory;
  end;
end;

procedure TSgtsOptionsForm.ButtonReportCatalogClick(Sender: TObject);
var
  Directory: string;
begin
  Directory:=EditReportCatalog.Text;
  if BrowseDirectory(Directory,SSelectDirectory,0) then begin
    EditReportCatalog.Text:=Directory;
  end;
end;

end.
