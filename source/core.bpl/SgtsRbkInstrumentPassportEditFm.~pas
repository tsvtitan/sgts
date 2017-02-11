unit SgtsRbkInstrumentPassportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs, SgtsCoreIntf;

type
  TSgtsRbkInstrumentPassportEditForm = class(TSgtsDataEditForm)
    LabelDescription: TLabel;
    MemoDescription: TMemo;
    LabelInstrument: TLabel;
    EditInstrument: TEdit;
    ButtonInstrument: TButton;
    LabelDateTest: TLabel;
    DateTimePickerTest: TDateTimePicker;
    LabelRatio: TLabel;
    EditRatio: TEdit;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkInstrumentPassportInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkInstrumentPassportUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkInstrumentPassportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkInstrumentPassportEditForm: TSgtsRbkInstrumentPassportEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkInstrumentsFm;

{$R *.dfm}

{ TSgtsRbkInstrumentPassportInsertIface }

procedure TSgtsRbkInstrumentPassportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentPassportEditForm;
  InterfaceName:=SInterfaceInstrumentPassportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertInstrumentPassport;
    with ExecuteDefs do begin
      AddKey('INSTRUMENT_PASSPORT_ID');
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',true);
      AddDate('DATE_TEST','DateTimePickerTest','LabelDateTest',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEditFloat('RATIO','EditRatio','LabelRatio',true);
    end;
  end;
end;

{ TSgtsRbkInstrumentPassportUpdateIface }

procedure TSgtsRbkInstrumentPassportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInstrumentPassportEditForm;
  InterfaceName:=SInterfaceInstrumentPassportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateInstrumentPassport;
    with ExecuteDefs do begin
      AddKeyLink('INSTRUMENT_PASSPORT_ID');
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',true);
      AddDate('DATE_TEST','DateTimePickerTest','LabelDateTest',true);
      AddMemo('DESCRIPTION','MemoDescription','LabelDescription',false);
      AddEditFloat('RATIO','EditRatio','LabelRatio',true);
    end;
  end;
end;

{ TSgtsRbkInstrumentPassportDeleteIface }

procedure TSgtsRbkInstrumentPassportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceInstrumentPassportDelete;
  DeleteQuestion:='Удалить текущую запись в паспорте?';
  with DataSet do begin
    ProviderName:=SProviderDeleteInstrumentPassport;
    with ExecuteDefs do begin
      AddKeyLink('INSTRUMENT_PASSPORT_ID');
    end;
  end;
end;

{ TSgtsRbkInstrumentPassportEditForm }

constructor TSgtsRbkInstrumentPassportEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerTest.Date:=DateOf(Date);
end;

end.
