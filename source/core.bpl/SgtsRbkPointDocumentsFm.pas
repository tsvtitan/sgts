unit SgtsRbkPointDocumentsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkPointDocumentsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPointDocumentsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPointDocumentsForm: TSgtsRbkPointDocumentsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkPointDocumentEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkPointDocumentsIface }

procedure TSgtsRbkPointDocumentsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPointDocumentsForm;
  InterfaceName:=SInterfacePointDocuments;
  InsertClass:=TSgtsRbkPointDocumentInsertIface;
  UpdateClass:=TSgtsRbkPointDocumentUpdateIface;
  DeleteClass:=TSgtsRbkPointDocumentDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPointDocuments;
    with SelectDefs do begin
      AddInvisible('POINT_ID');
      AddInvisible('DOCUMENT_ID');
      Add('POINT_NAME','Точка',150);
      Add('DOCUMENT_NAME','Документ',150);
      Add('PRIORITY','Порядок',30);
    end;
  end;
end;

{ TSgtsRbkPointDocumentsForm }

constructor TSgtsRbkPointDocumentsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
