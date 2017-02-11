unit SgtsRbkInstrumentPassportsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsSelectDefs,
  SgtsCoreIntf;

type
  TSgtsRbkInstrumentPassportsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkInstrumentPassportsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkInstrumentPassportsForm: TSgtsRbkInstrumentPassportsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsRbkInstrumentPassportEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkInstrumentPassportsIface }

procedure TSgtsRbkInstrumentPassportsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentPassportsForm;
  InterfaceName:=SInterfaceInstrumentPassports;
  InsertClass:=TSgtsRbkInstrumentPassportInsertIface;
  UpdateClass:=TSgtsRbkInstrumentPassportUpdateIface;
  DeleteClass:=TSgtsRbkInstrumentPassportDeleteIface;  
  with DataSet do begin
    ProviderName:=SProviderSelectInstrumentPassports;
    with SelectDefs do begin
      AddKey('INSTRUMENT_PASSPORT_ID');
      Add('INSTRUMENT_NAME','Прибор',150);
      Add('DATE_TEST','Дата калибровки',80);
      Add('RATIO','Коэффициент',50);
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkInstrumentPassportsForm }

constructor TSgtsRbkInstrumentPassportsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
