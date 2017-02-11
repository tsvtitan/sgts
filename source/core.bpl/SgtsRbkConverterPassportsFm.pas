unit SgtsRbkConverterPassportsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkConverterPassportsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkConverterPassportsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkConverterPassportsForm: TSgtsRbkConverterPassportsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkConverterPassportEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkConverterPassportsIface }

procedure TSgtsRbkConverterPassportsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkConverterPassportsForm;
  InterfaceName:=SInterfaceConverterPassports;
  InsertClass:=TSgtsRbkConverterPassportInsertIface;
  UpdateClass:=TSgtsRbkConverterPassportUpdateIface;
  DeleteClass:=TSgtsRbkConverterPassportDeleteIface;  
  with DataSet do begin
    ProviderName:=SProviderSelectConverterPassports;
    with SelectDefs do begin
      AddKey('CONVERTER_PASSPORT_ID');
      Add('COMPONENT_NAME','Компонент',150);
      Add('INSTRUMENT_NAME','Прибор',100);
      Add('MEASURE_UNIT_NAME','Единица измерения',40);
      Add('DATE_BEGIN','Дата начала',60);
      Add('DATE_END','Дата окончания',60);
      Add('VALUE','Значение',50);
      AddInvisible('COMPONENT_ID');
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('MEASURE_UNIT_ID');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkConverterPassportsForm }

constructor TSgtsRbkConverterPassportsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
