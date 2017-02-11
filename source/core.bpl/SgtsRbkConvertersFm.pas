unit SgtsRbkConvertersFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf, StdCtrls, DBCtrls;

type
  TSgtsRbkConvertersForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkConvertersIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkConvertersForm: TSgtsRbkConvertersForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkConverterEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkConvertersIface }

procedure TSgtsRbkConvertersIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkConvertersForm;
  InterfaceName:=SInterfaceConverters;
  InsertClass:=TSgtsRbkConverterInsertIface;
  UpdateClass:=TSgtsRbkConverterUpdateIface;
  DeleteClass:=TSgtsRbkConverterDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectConverters;
    with SelectDefs do begin
      AddInvisible('CONVERTER_ID');
      Add('NAME','Наименование',150);
      Add('POINT_NAME','Точка',150);
      AddDrawCheck('NOT_OPERATION_EX','Не функционирует','NOT_OPERATION',25);
      AddInvisible('DESCRIPTION');
      AddInvisible('DATE_ENTER');
    end;
  end;
end;

{ TSgtsRbkConvertersForm }

constructor TSgtsRbkConvertersForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
