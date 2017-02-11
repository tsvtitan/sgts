unit SgtsRbkInstrumentUnitsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  SgtsDataGridFm, SgtsDataFm, SgtsFm, 
  SgtsCoreIntf, StdCtrls;

type
  TSgtsRbkInstrumentUnitsForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkInstrumentUnitsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkInstrumentUnitsForm: TSgtsRbkInstrumentUnitsForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkInstrumentUnitEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkInstrumentUnitsIface }

procedure TSgtsRbkInstrumentUnitsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentUnitsForm;
  InterfaceName:=SInterfaceInstrumentUnits;
  InsertClass:=TSgtsRbkInstrumentUnitInsertIface;
  UpdateClass:=TSgtsRbkInstrumentUnitUpdateIface;
  DeleteClass:=TSgtsRbkInstrumentUnitDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectInstrumentUnits;
    with SelectDefs do begin
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('MEASURE_UNIT_ID');
      Add('INSTRUMENT_NAME','Прибор',150);
      Add('MEASURE_UNIT_NAME','Единица измерения',150);
      Add('PRIORITY','Порядок',30);
    end;
  end;
end;

{ TSgtsRbkInstrumentUnitsForm }

constructor TSgtsRbkInstrumentUnitsForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
