unit SgtsRbkInstrumentTypesFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TSgtsRbkInstrumentTypesForm = class(TSgtsDataGridForm)
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

  TSgtsRbkInstrumentTypesIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkInstrumentTypesForm: TSgtsRbkInstrumentTypesForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkInstrumentTypeEditFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkInstrumentTypesIface }

procedure TSgtsRbkInstrumentTypesIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentTypesForm;
  InterfaceName:=SInterfaceInstrumentTypes;
  InsertClass:=TSgtsRbkInstrumentTypeInsertIface;
  UpdateClass:=TSgtsRbkInstrumentTypeUpdateIface;
  DeleteClass:=TSgtsRbkInstrumentTypeDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectInstrumentTypes;
    with SelectDefs do begin
      AddKey('INSTRUMENT_TYPE_ID');
      Add('NAME','Наименование');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkInstrumentTypesForm }

constructor TSgtsRbkInstrumentTypesForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
