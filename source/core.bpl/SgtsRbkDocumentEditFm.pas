unit SgtsRbkDocumentEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls, DB,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs;

type
  TSgtsRbkDocumentEditForm = class(TSgtsDataEditForm)
    LabelName: TLabel;
    EditName: TEdit;
    MemoNote: TMemo;
    LabelNote: TLabel;
    LabelFileName: TLabel;
    EditFileName: TEdit;
    ButtonFileName: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkDocumentInsertIface=class(TSgtsDataInsertIface)
  private
    FFileNameDef: TSgtsExecuteDefFileName;
    procedure FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  public
    procedure Init; override;
  end;

  TSgtsRbkDocumentUpdateIface=class(TSgtsDataUpdateIface)
  private
    FFileNameDef: TSgtsExecuteDefFileName;
    procedure FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
  public
    procedure Init; override;
  end;

  TSgtsRbkDocumentDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkDocumentEditForm: TSgtsRbkDocumentEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsCoreObj;

{$R *.dfm}

{ TSgtsRbkDocumentInsertIface }

procedure TSgtsRbkDocumentInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDocumentEditForm;
  InterfaceName:=SInterfaceDocumentInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertDocument;
    with ExecuteDefs do begin
      AddKey('DOCUMENT_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FFileNameDef:=AddFileName('FILE_NAME','EditFileName','LabelFileName','ButtonFileName',SFilterDocuments,true);
      FFileNameDef.InitialDir:=CoreIntf.OptionsForm.DocumentCatalog;
      FFileNameDef.OnCheckValue:=FileNameCheckValue;
    end;
  end;
end;

procedure TSgtsRbkDocumentInsertIface.FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  FileName: String;
  Catalog: String;
  APos: Integer;
begin
  FileName:=VarToStrDef(NewValue,'');
  Catalog:=Trim(CoreIntf.OptionsForm.DocumentCatalog);
  APos:=AnsiPos(Catalog,FileName);
  if APos=1 then begin
    FileName:=Copy(FileName,APos+Length(Catalog)+Length(PathDelim),Length(FileName));
  end;
  NewValue:=FileName;
end;

{ TSgtsRbkDocumentUpdateIface }

procedure TSgtsRbkDocumentUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDocumentEditForm;
  InterfaceName:=SInterfaceDocumentUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateDocument;
    with ExecuteDefs do begin
      AddKeyLink('Document_ID');
      AddEdit('NAME','EditName','LabelName',true);
      AddMemo('DESCRIPTION','MemoNote','LabelNote',false);
      FFileNameDef:=AddFileName('FILE_NAME','EditFileName','LabelFileName','ButtonFileName',SFilterDocuments,true);
      FFileNameDef.InitialDir:=CoreIntf.OptionsForm.DocumentCatalog;
      FFileNameDef.OnCheckValue:=FileNameCheckValue;
    end;
  end;
end;

procedure TSgtsRbkDocumentUpdateIface.FileNameCheckValue(Def: TSgtsExecuteDef; var NewValue: Variant; var CanSet: Boolean);
var
  FileName: String;
  Catalog: String;
  APos: Integer;
begin
  FileName:=VarToStrDef(NewValue,'');
  Catalog:=Trim(CoreIntf.OptionsForm.DocumentCatalog);
  APos:=AnsiPos(Catalog,FileName);
  if APos=1 then begin
    FileName:=Copy(FileName,APos+Length(Catalog)+Length(PathDelim),Length(FileName));
  end;
  NewValue:=FileName;
end;

{ TSgtsRbkDocumentDeleteIface }

procedure TSgtsRbkDocumentDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceDocumentDelete;
  DeleteQuestion:='Удалить документ %NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteDocument;
    with ExecuteDefs do begin
      AddKeyLink('DOCUMENT_ID');
      AddInvisible('NAME');
    end;
  end;
end;

end.
