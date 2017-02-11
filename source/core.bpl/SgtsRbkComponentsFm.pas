unit SgtsRbkComponentsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkComponentsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkComponentsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkComponentsForm: TSgtsRbkComponentsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkComponentEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkComponentsIface }

procedure TSgtsRbkComponentsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkComponentsForm;
  InterfaceName:=SInterfaceComponents;
  InsertClass:=TSgtsRbkComponentInsertIface;
  UpdateClass:=TSgtsRbkComponentUpdateIface;
  DeleteClass:=TSgtsRbkComponentDeleteIface;  
  with DataSet do begin
    ProviderName:=SProviderSelectComponents;
    with SelectDefs do begin
      AddKey('COMPONENT_ID');
      Add('NAME','Наименование',120);
      Add('CONVERTER_NAME','Преобразователь',120);
      Add('PARAM_NAME','Параметр',120);
      AddInvisible('CONVERTER_ID');
      AddInvisible('PARAM_ID');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkComponentsForm }

constructor TSgtsRbkComponentsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
