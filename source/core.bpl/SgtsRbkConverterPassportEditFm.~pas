unit SgtsRbkConverterPassportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs, SgtsCoreIntf, SgtsDataGridFm,
  SgtsRbkInstrumentUnitsFm;

type
  TSgtsRbkConverterPassportEditForm = class(TSgtsDataEditForm)
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelComponent: TLabel;
    EditComponent: TEdit;
    ButtonComponent: TButton;
    LabelValue: TLabel;
    EditValue: TEdit;
    LabelInstrument: TLabel;
    LabelMeasureUnit: TLabel;
    LabelDateBegin: TLabel;
    DateTimePickerBegin: TDateTimePicker;
    LabelDateEnd: TLabel;
    DateTimePickerEnd: TDateTimePicker;
    EditInstrument: TEdit;
    ButtonInstrument: TButton;
    EditMeasureUnit: TEdit;
    ButtonMeasureUnit: TButton;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkConverterPassportInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkConverterPassportUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkConverterPassportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkConverterPassportEditForm: TSgtsRbkConverterPassportEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsGetRecordsConfig,
     SgtsRbkComponentsFm, SgtsRbkInstrumentsFm, SgtsRbkMeasureUnitsFm,
     SgtsSelectDefs;

{$R *.dfm}

{ TSgtsRbkConverterPassportInsertIface }

procedure TSgtsRbkConverterPassportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkConverterPassportEditForm;
  InterfaceName:=SInterfaceConverterPassportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertConverterPassport;
    with ExecuteDefs do begin
      AddKey('CONVERTER_PASSPORT_ID');
      AddEditLink('COMPONENT_ID','EditComponent','LabelComponent','ButtonComponent',
                  TSgtsRbkComponentsIface,'COMPONENT_NAME','NAME','COMPONENT_ID',true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',false);
      AddEditLink('MEASURE_UNIT_ID','EditMeasureUnit','LabelMeasureUnit','ButtonMeasureUnit',
                  TSgtsRbkMeasureUnitsIface,'MEASURE_UNIT_NAME','NAME','MEASURE_UNIT_ID',false);
      AddDate('DATE_BEGIN','DateTimePickerBegin','LabelDateBegin',true);
      AddDate('DATE_END','DateTimePickerEnd','LabelDateEnd',false).DefaultValue:=NullDate;
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEdit('VALUE','EditValue','LabelValue',true);
    end;
  end;
end;

{ TSgtsRbkConverterPassportUpdateIface }

procedure TSgtsRbkConverterPassportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkConverterPassportEditForm;
  InterfaceName:=SInterfaceConverterPassportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateConverterPassport;
    with ExecuteDefs do begin
      AddKeyLink('CONVERTER_PASSPORT_ID');
      AddEditLink('COMPONENT_ID','EditComponent','LabelComponent','ButtonComponent',
                  TSgtsRbkComponentsIface,'COMPONENT_NAME','NAME','COMPONENT_ID',true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',false);
      AddEditLink('MEASURE_UNIT_ID','EditMeasureUnit','LabelMeasureUnit','ButtonMeasureUnit',
                  TSgtsRbkMeasureUnitsIface,'MEASURE_UNIT_NAME','NAME','MEASURE_UNIT_ID',false);
      AddDate('DATE_BEGIN','DateTimePickerBegin','LabelDateBegin',true);
      AddDate('DATE_END','DateTimePickerEnd','LabelDateEnd',false);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEdit('VALUE','EditValue','LabelValue',true);
    end;
  end;
end;

{ TSgtsRbkConverterPassportDeleteIface }

procedure TSgtsRbkConverterPassportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceConverterPassportDelete;
  DeleteQuestion:='Удалить текущую запись в паспорте?';
  with DataSet do begin
    ProviderName:=SProviderDeleteConverterPassport;
    with ExecuteDefs do begin
      AddKeyLink('CONVERTER_PASSPORT_ID');
    end;
  end;
end;

{ TSgtsRbkConverterPassportEditForm }

constructor TSgtsRbkConverterPassportEditForm.Create(ACoreIntf: ISgtsCore); 
begin
  inherited Create(ACoreIntf);
  DateTimePickerBegin.Date:=DateOf(Date);
end;

end.
