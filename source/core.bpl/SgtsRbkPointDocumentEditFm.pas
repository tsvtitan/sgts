unit SgtsRbkPointDocumentEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkPointDocumentEditForm = class(TSgtsDataEditForm)
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
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

  TSgtsRbkPointDocumentInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointDocumentUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPointDocumentDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPointDocumentRoleEditForm: TSgtsRbkPointDocumentEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkDocumentsFm, SgtsRbkPointsFm;

{$R *.dfm}

{ TSgtsRbkPointDocumentInsertIface }

procedure TSgtsRbkPointDocumentInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointDocumentEditForm;
  InterfaceName:=SInterfacePointDocumentInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPointDocument;
    with ExecuteDefs do begin
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEditLink('DOCUMENT_ID','EditDocument','LabelDocument','ButtonDocument',
                  TSgtsRbkDocumentsIface,'DOCUMENT_NAME','NAME','DOCUMENT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkPointDocumentUpdateIface }

procedure TSgtsRbkPointDocumentUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointDocumentEditForm;
  InterfaceName:=SInterfacePointDocumentUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePointDocument;
    with ExecuteDefs do begin
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true,true);
      AddEditLink('DOCUMENT_ID','EditDocument','LabelDocument','ButtonDocument',
                  TSgtsRbkDocumentsIface,'DOCUMENT_NAME','NAME','DOCUMENT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkPointDocumentDeleteIface }

procedure TSgtsRbkPointDocumentDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePointDocumentDelete;
  DeleteQuestion:='Удалить документ: %DOCUMENT_NAME у точки: %POINT_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePointDocument;
    with ExecuteDefs do begin
      AddKeyLink('POINT_ID');
      AddKeyLink('DOCUMENT_ID');
      AddInvisible('POINT_NAME');
      AddInvisible('DOCUMENT_NAME');
    end;
  end;
end;

end.
