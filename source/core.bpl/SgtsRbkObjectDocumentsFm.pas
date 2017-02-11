unit SgtsRbkObjectDocumentsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkObjectDocumentsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkObjectDocumentsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkObjectDocumentsForm: TSgtsRbkObjectDocumentsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkObjectDocumentEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkObjectDocumentsIface }

procedure TSgtsRbkObjectDocumentsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkObjectDocumentsForm;
  InterfaceName:=SInterfaceObjectDocuments;
  InsertClass:=TSgtsRbkObjectDocumentInsertIface;
  UpdateClass:=TSgtsRbkObjectDocumentUpdateIface;
  DeleteClass:=TSgtsRbkObjectDocumentDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectObjectDocuments;
    with SelectDefs do begin
      AddInvisible('OBJECT_ID');
      AddInvisible('DOCUMENT_ID');
      Add('OBJECT_NAME','Объект',150);
      Add('DOCUMENT_NAME','Документ',150);
      Add('PRIORITY','Порядок',30);
    end;
  end;
end;

{ TSgtsRbkObjectDocumentsForm }

constructor TSgtsRbkObjectDocumentsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
