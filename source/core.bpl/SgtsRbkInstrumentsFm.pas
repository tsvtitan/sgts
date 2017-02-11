unit SgtsRbkInstrumentsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, 
  SgtsCoreIntf, StdCtrls, Mask, DBCtrls;

type
  TSgtsRbkInstrumentsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    DBMemoDescription: TDBMemo;
    Splitter: TSplitter;
    LabelZ: TLabel;
    DBEditInventoryNumber: TDBEdit;
    LabelDescription: TLabel;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkInstrumentsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkInstrumentsForm: TSgtsRbkInstrumentsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkInstrumentEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkInstrumentsIface }

procedure TSgtsRbkInstrumentsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentsForm;
  InterfaceName:=SInterfaceInstruments;
  InsertClass:=TSgtsRbkInstrumentInsertIface;
  UpdateClass:=TSgtsRbkInstrumentUpdateIface;
  DeleteClass:=TSgtsRbkInstrumentDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectInstruments;
    with SelectDefs do begin
      AddKey('INSTRUMENT_ID');
      Add('NAME','Наименование',100);
      Add('INSTRUMENT_TYPE_NAME','Тип',60);
      Add('SERIAL_NUMBER','Заводской номер',60);
      Add('RANGE_MEASURE','Диапазон измерений',50);
      Add('CLASS_ACCURACY','Класс точности',30);
      Add('FREQUENCY_TEST','Период калибровки',50);
      Add('DATE_ENTER','Дата ввода',70);
      Add('DATE_END','Дата окончания',70);
      AddInvisible('INSTRUMENT_TYPE_ID');
      AddInvisible('DESCRIPTION');
      AddInvisible('INVENTORY_NUMBER');
    end;
  end;
end;

{ TSgtsRbkInstrumentsForm }

constructor TSgtsRbkInstrumentsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
