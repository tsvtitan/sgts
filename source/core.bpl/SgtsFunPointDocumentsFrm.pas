unit SgtsFunPointDocumentsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SgtsDataGridOleFrm, Menus, DB, ImgList, StdCtrls, Grids,
  DBGrids, ExtCtrls, ComCtrls, ToolWin, OleCtnrs;

type
  TSgtsFunPointDocumentsFrame = class(TSgtsDataGridOleFrame)
  private
    { Private declarations }
  protected
    function GetCatalog: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  SgtsFunPointDocumentsFrame: TSgtsFunPointDocumentsFrame;

implementation

{$R *.dfm}

uses SgtsDialogs, SgtsConsts, SgtsUtils, SgtsProviderConsts,
     SgtsGetRecordsConfig, SgtsFunPointDocumentIfaces, SgtsDataGridFrm,
     SgtsCoreIntf;

{ TSgtsRbkPointDocumentsFrame }

constructor TSgtsFunPointDocumentsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InsertClass:=TSgtsFunPointDocumentInsertIface;
  UpdateClass:=TSgtsFunPointDocumentUpdateIface;
  DeleteClass:=TSgtsFunPointDocumentDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPointDocuments;
    with SelectDefs do begin
      Add('DOCUMENT_NAME','Документ',70);
      AddInvisible('DOCUMENT_ID');
      AddInvisible('DOCUMENT_DESCRIPTION');
      AddInvisible('FILE_NAME');
      AddInvisible('POINT_ID');
      AddInvisible('POINT_NAME');
      AddInvisible('PRIORITY');
    end;
    Orders.Add('PRIORITY',otAsc);
  end;
  FieldFileName:='FILE_NAME';
end;

destructor TSgtsFunPointDocumentsFrame.Destroy;
begin
  inherited Destroy;
end;

function TSgtsFunPointDocumentsFrame.GetCatalog: String;
begin
  Result:=inherited GetCatalog;
  if Assigned(CoreIntf) then
    Result:=CoreIntf.OptionsForm.DocumentCatalog;
end;

end.
