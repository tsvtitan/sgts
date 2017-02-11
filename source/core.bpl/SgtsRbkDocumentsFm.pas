unit SgtsRbkDocumentsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  StdCtrls, DBCtrls, Grids, DBGrids,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf;

type
  TSgtsRbkDocumentsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoNote: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkDocumentsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkDocumentsForm: TSgtsRbkDocumentsForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkDocumentEditFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkDocumentsIface }

procedure TSgtsRbkDocumentsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkDocumentsForm;
  InterfaceName:=SInterfaceDocuments;
  InsertClass:=TSgtsRbkDocumentInsertIface;
  UpdateClass:=TSgtsRbkDocumentUpdateIface;
  DeleteClass:=TSgtsRbkDocumentDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectDocuments;
    with SelectDefs do begin
      AddKey('DOCUMENT_ID');
      Add('NAME','Наименование',100);
      Add('FILE_NAME','Файл документа',250);
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkDocumentsForm }

constructor TSgtsRbkDocumentsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
