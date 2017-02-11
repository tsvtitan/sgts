unit SgtsRbkObjectDocumentEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkObjectDocumentEditForm = class(TSgtsDataEditForm)
    LabelObject: TLabel;
    EditObject: TEdit;
    ButtonObject: TButton;
    LabelDocument: TLabel;
    EditDocument: TEdit;
    ButtonDocument: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkObjectDocumentInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkObjectDocumentUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkObjectDocumentDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectDocumentRoleEditForm: TSgtsRbkObjectDocumentEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkDocumentsFm, SgtsRbkObjectsFm;

{$R *.dfm}

{ TSgtsRbkObjectDocumentInsertIface }

procedure TSgtsRbkObjectDocumentInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectDocumentEditForm;
  InterfaceName:=SInterfaceObjectDocumentInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertObjectDocument;
    with ExecuteDefs do begin
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true);
      AddEditLink('DOCUMENT_ID','EditDocument','LabelDocument','ButtonDocument',
                  TSgtsRbkDocumentsIface,'DOCUMENT_NAME','NAME','DOCUMENT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkObjectDocumentUpdateIface }

procedure TSgtsRbkObjectDocumentUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectDocumentEditForm;
  InterfaceName:=SInterfaceObjectDocumentUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateObjectDocument;
    with ExecuteDefs do begin
      AddEditLink('OBJECT_ID','EditObject','LabelObject','ButtonObject',
                  TSgtsRbkObjectsIface,'OBJECT_NAME','NAME','OBJECT_ID',true,true);
      AddEditLink('DOCUMENT_ID','EditDocument','LabelDocument','ButtonDocument',
                  TSgtsRbkDocumentsIface,'DOCUMENT_NAME','NAME','DOCUMENT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkObjectDocumentDeleteIface }

procedure TSgtsRbkObjectDocumentDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceObjectDocumentDelete;
  DeleteQuestion:='Удалить документ: %DOCUMENT_NAME у объекта: %OBJECT_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteObjectDocument;
    with ExecuteDefs do begin
      AddKeyLink('OBJECT_ID');
      AddKeyLink('DOCUMENT_ID');
      AddInvisible('OBJECT_NAME');
      AddInvisible('DOCUMENT_NAME');
    end;
  end;
end;

end.
