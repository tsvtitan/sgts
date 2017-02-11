unit SgtsRbkInstrumentUnitEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls;

type
  TSgtsRbkInstrumentUnitEditForm = class(TSgtsDataEditForm)
    LabelInstrument: TLabel;
    EditInstrument: TEdit;
    ButtonInstrument: TButton;
    LabelMeasureUnit: TLabel;
    EditMeasureUnit: TEdit;
    ButtonMeasureUnit: TButton;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsRbkInstrumentUnitInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkInstrumentUnitUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkInstrumentUnitDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;
  
var
  SgtsRbkInstrumentUnitRoleEditForm: TSgtsRbkInstrumentUnitEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkInstrumentsFm, SgtsRbkMeasureUnitsFm;

{$R *.dfm}

{ TSgtsRbkInstrumentUnitInsertIface }

procedure TSgtsRbkInstrumentUnitInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentUnitEditForm;
  InterfaceName:=SInterfaceInstrumentUnitInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertInstrumentUnit;
    with ExecuteDefs do begin
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','',true);
      AddEditLink('MEASURE_UNIT_ID','EditMeasureUnit','LabelMeasureUnit','ButtonMeasureUnit',
                  TSgtsRbkMeasureUnitsIface,'MEASURE_UNIT_NAME','NAME','MEASURE_UNIT_ID',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkInstrumentUnitUpdateIface }

procedure TSgtsRbkInstrumentUnitUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentUnitEditForm;
  InterfaceName:=SInterfaceInstrumentUnitUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateInstrumentUnit;
    with ExecuteDefs do begin
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','',true,true);
      AddEditLink('MEASURE_UNIT_ID','EditMeasureUnit','LabelMeasureUnit','ButtonMeasureUnit',
                  TSgtsRbkMeasureUnitsIface,'MEASURE_UNIT_NAME','NAME','MEASURE_UNIT_ID',true,true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

{ TSgtsRbkInstrumentUnitDeleteIface }

procedure TSgtsRbkInstrumentUnitDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceInstrumentUnitDelete;
  DeleteQuestion:='Удалить единицу измерения: %MEASURE_UNIT_NAME у прибора %INSTRUMENT_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeleteInstrumentUnit;
    with ExecuteDefs do begin
      AddKeyLink('INSTRUMENT_ID');
      AddKeyLink('MEASURE_UNIT_ID');
      AddInvisible('MEASURE_UNIT_NAME');
      AddInvisible('INSTRUMENT_NAME');
    end;
  end;
end;

end.
