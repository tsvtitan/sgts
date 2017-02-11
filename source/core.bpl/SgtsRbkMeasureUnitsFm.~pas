unit SgtsRbkMeasureUnitsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, SgtsCDS,
  SgtsCoreIntf, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TSgtsRbkMeasureUnitsForm = class(TSgtsDataGridForm)
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

  TSgtsRbkMeasureUnitsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkMeasureUnitsForm: TSgtsRbkMeasureUnitsForm;

implementation

uses SgtsProviderConsts, SgtsIface, SgtsConsts, SgtsRbkMeasureUnitEditFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkMeasureUnitsIface }

procedure TSgtsRbkMeasureUnitsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkMeasureUnitsForm;
  InterfaceName:=SInterfaceMeasureUnits;
  InsertClass:=TSgtsRbkMeasureUnitInsertIface;
  UpdateClass:=TSgtsRbkMeasureUnitUpdateIface;
  DeleteClass:=TSgtsRbkMeasureUnitDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectMeasureUnits;
    with SelectDefs do begin
      AddKey('MEASURE_UNIT_ID');
      Add('NAME','Наименование');
      AddInvisible('DESCRIPTION');
    end;
  end;
end;

{ TSgtsRbkMeasureUnitsForm }

constructor TSgtsRbkMeasureUnitsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
