unit SgtsJrnJournalFieldEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs, SgtsCoreIntf;

type
  TSgtsJrnJournalFieldEditForm = class(TSgtsDataEditForm)
    LabelCycle: TLabel;
    EditCycle: TEdit;
    ButtonCycle: TButton;
    LabelPoint: TLabel;
    EditPoint: TEdit;
    ButtonPoint: TButton;
    LabelParam: TLabel;
    EditParam: TEdit;
    ButtonParam: TButton;
    LabelValue: TLabel;
    EditValue: TEdit;
    LabelWhoEnter: TLabel;
    EditWhoEnter: TEdit;
    ButtonWhoEnter: TButton;
    LabelDateEnter: TLabel;
    DateTimePickerEnter: TDateTimePicker;
    LabelWhoConfirm: TLabel;
    EditWhoConfirm: TEdit;
    ButtonWhoConfirm: TButton;
    LabelDateConfirm: TLabel;
    DateTimePickerConfirm: TDateTimePicker;
    LabelDateObservation: TLabel;
    DateTimePickerObservation: TDateTimePicker;
    LabelInstrument: TLabel;
    EditInstrument: TEdit;
    ButtonInstrument: TButton;
    LabelMeasureUnit: TLabel;
    EditMeasureUnit: TEdit;
    ButtonMeasureUnit: TButton;
    LabelMeasureType: TLabel;
    EditMeasureType: TEdit;
    ButtonMeasureType: TButton;
    LabelGroupId: TLabel;
    EditGroupId: TEdit;
    LabelPriority: TLabel;
    EditPriority: TEdit;
    CheckBoxIsBase: TCheckBox;
    LabelJournalNum: TLabel;
    EditJournalNum: TEdit;
    LabelNote: TLabel;
    MemoNote: TMemo;
    CheckBoxIsCheck: TCheckBox;
    procedure EditWhoConfirmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonWhoConfirmClick(Sender: TObject);
  private
    function GetWhoConfirm: TSgtsExecuteDefEditLink;
    function GetDateConfirm: TSgtsExecuteDefDate;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsJrnJournalFieldInsertIface=class(TSgtsDataInsertIface)
  private
    FWhoEnterd: TSgtsExecuteDefEditLink;
    FWhoConfirm: TSgtsExecuteDefEditLink;
    FDateConfirm: TSgtsExecuteDefDate;
    FGroupId: TSgtsExecuteDefEdit;
    FPriority: TSgtsExecuteDefEditInteger;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;
    procedure SetDefValues; override;

  end;

  TSgtsJrnJournalFieldUpdateIface=class(TSgtsDataUpdateIface)
  private
    FWhoConfirm: TSgtsExecuteDefEditLink;
    FDateConfirm: TSgtsExecuteDefDate;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;

  end;

  TSgtsJrnJournalFieldDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsJrnJournalFieldEditForm: TSgtsJrnJournalFieldEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsUtils,
     SgtsRbkCyclesFm, SgtsRbkPointsFm, SgtsRbkParamsFm, SgtsRbkPersonnelsFm,
     SgtsRbkInstrumentsFm, SgtsRbkMeasureUnitsFm, SgtsRbkMeasureTypesFm,
     SgtsCoreObj, SgtsDatabaseIntf;

{$R *.dfm}

{ TSgtsJrnJournalFieldInsertIface }

procedure TSgtsJrnJournalFieldInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalFieldEditForm;
  InterfaceName:=SInterfaceJournalFieldInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertJournalField;
    with ExecuteDefs do begin
      AddKey('JOURNAL_FIELD_ID');
      AddDate('DATE_OBSERVATION','DateTimePickerObservation','LabelDateObservation',true);
      AddEditLink('CYCLE_ID','EditCycle','LabelCycle','ButtonCycle',
                  TSgtsRbkCyclesIface,'CYCLE_NUM','CYCLE_NUM','CYCLE_ID',true);
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',false);
      AddEditLink('MEASURE_UNIT_ID','EditMeasureUnit','LabelMeasureUnit','ButtonMeasureUnit',
                  TSgtsRbkMeasureUnitsIface,'MEASURE_UNIT_NAME','NAME','MEASURE_UNIT_ID',false);
      AddEditFloat('VALUE','EditValue','LabelValue',true);
      AddCheck('IS_BASE','CheckBoxIsBase');
      FGroupId:=AddEdit('GROUP_ID','EditGroupId','LabelGroupId',true);
      FPriority:=AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
      AddCheck('IS_CHECK','CheckBoxIsCheck');
      AddEdit('JOURNAL_NUM','EditJournalNum','LabelJournalNum',false);
      FWhoEnterd:=AddEditLink('WHO_ENTER','EditWhoEnter','LabelWhoEnter','ButtonWhoEnter',
                              TSgtsRbkPersonnelsIface,'WHO_ENTER_NAME','PERSONNEL_NAME','PERSONNEL_ID',true);
      AddDate('DATE_ENTER','DateTimePickerEnter','LabelDateEnter',true);
      FWhoConfirm:=AddEditLink('WHO_CONFIRM','EditWhoConfirm','LabelWhoConfirm','ButtonWhoConfirm',
                               TSgtsRbkPersonnelsIface,'WHO_CONFIRM_NAME','PERSONNEL_NAME','PERSONNEL_ID');
      FDateConfirm:=AddDate('DATE_CONFIRM','DateTimePickerConfirm','LabelDateConfirm');
      AddMemo('NOTE','MemoNote','LabelNote',false);
    end;
  end;
end;

procedure TSgtsJrnJournalFieldInsertIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(Database) then begin

    FWhoEnterd.DefaultValue:=Database.PersonnelId;
    FWhoEnterd.SetDefault;

    FWhoEnterd.Link.DefaultValue:=Database.Personnel;
    FWhoEnterd.Link.SetDefault;

    FGroupId.DefaultValue:=CreateUniqueId;
    FGroupId.SetDefault;

    FPriority.DefaultValue:=1;
    FPriority.SetDefault;
  end;
end;

procedure TSgtsJrnJournalFieldInsertIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  with TSgtsJrnJournalFieldEditForm(AForm) do begin
    LabelWhoConfirm.Enabled:=IfaceIntf.PermissionExists(SPermissionNameConfirm);
    EditWhoConfirm.Enabled:=LabelWhoConfirm.Enabled;
    ButtonWhoConfirm.Enabled:=LabelWhoConfirm.Enabled;
    LabelDateConfirm.Enabled:=LabelWhoConfirm.Enabled;
    DateTimePickerConfirm.Enabled:=LabelWhoConfirm.Enabled;
  end;
end;

{ TSgtsJrnJournalFieldUpdateIface }

procedure TSgtsJrnJournalFieldUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalFieldEditForm;
  InterfaceName:=SInterfaceJournalFieldUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateJournalField;
    with ExecuteDefs do begin
      AddKeyLink('JOURNAL_FIELD_ID');
      AddDate('DATE_OBSERVATION','DateTimePickerObservation','LabelDateObservation',true);
      AddEditLink('CYCLE_ID','EditCycle','LabelCycle','ButtonCycle',
                  TSgtsRbkCyclesIface,'CYCLE_NUM','CYCLE_NUM','CYCLE_ID',true);
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','MEASURE_TYPE_ID',true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',true);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditLink('INSTRUMENT_ID','EditInstrument','LabelInstrument','ButtonInstrument',
                  TSgtsRbkInstrumentsIface,'INSTRUMENT_NAME','NAME','INSTRUMENT_ID',false);
      AddEditLink('MEASURE_UNIT_ID','EditMeasureUnit','LabelMeasureUnit','ButtonMeasureUnit',
                  TSgtsRbkMeasureUnitsIface,'MEASURE_UNIT_NAME','NAME','MEASURE_UNIT_ID',false);
      AddEditFloat('VALUE','EditValue','LabelValue',true);
      AddCheck('IS_BASE','CheckBoxIsBase');
      AddEdit('GROUP_ID','EditGroupId','LabelGroupId',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
      AddCheck('IS_CHECK','CheckBoxIsCheck');
      AddEdit('JOURNAL_NUM','EditJournalNum','LabelJournalNum',false);
      AddEditLink('WHO_ENTER','EditWhoEnter','LabelWhoEnter','ButtonWhoEnter',
                  TSgtsRbkPersonnelsIface,'WHO_ENTER_NAME','PERSONNEL_NAME','PERSONNEL_ID',true);
      AddDate('DATE_ENTER','DateTimePickerEnter','LabelDateEnter',true);
      FWhoConfirm:=AddEditLink('WHO_CONFIRM','EditWhoConfirm','LabelWhoConfirm','ButtonWhoConfirm',
                               TSgtsRbkPersonnelsIface,'WHO_CONFIRM_NAME','PERSONNEL_NAME','PERSONNEL_ID');
      FDateConfirm:=AddDate('DATE_CONFIRM','DateTimePickerConfirm','LabelDateConfirm');
      AddMemo('NOTE','MemoNote','LabelNote',false);
    end;
  end;
end;

procedure TSgtsJrnJournalFieldUpdateIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  with TSgtsJrnJournalFieldEditForm(AForm) do begin
    LabelWhoConfirm.Enabled:=IfaceIntf.PermissionExists(SPermissionNameConfirm);
    EditWhoConfirm.Enabled:=LabelWhoConfirm.Enabled;
    ButtonWhoConfirm.Enabled:=LabelWhoConfirm.Enabled;
    LabelDateConfirm.Enabled:=LabelWhoConfirm.Enabled;
    DateTimePickerConfirm.Enabled:=LabelWhoConfirm.Enabled;
  end;
end;

{ TSgtsJrnJournalFieldDeleteIface }

procedure TSgtsJrnJournalFieldDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceJournalFieldDelete;
  DeleteQuestion:='Удалить запись в полевом журнале?';
  with DataSet do begin
    ProviderName:=SProviderDeleteJournalField;
    with ExecuteDefs do begin
      AddKeyLink('JOURNAL_FIELD_ID');
    end;
  end;
end;

{ TSgtsJrnJournalFieldEditForm }

constructor TSgtsJrnJournalFieldEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerEnter.Date:=Date;
  DateTimePickerObservation.Date:=Date;
end;

function TSgtsJrnJournalFieldEditForm.GetWhoConfirm: TSgtsExecuteDefEditLink;
begin
  Result:=nil;
  if Iface is TSgtsJrnJournalFieldInsertIface then begin
    Result:=TSgtsJrnJournalFieldInsertIface(Iface).FWhoConfirm;
  end;
  if Iface is TSgtsJrnJournalFieldUpdateIface then begin
    Result:=TSgtsJrnJournalFieldUpdateIface(Iface).FWhoConfirm;
  end;
end;

function TSgtsJrnJournalFieldEditForm.GetDateConfirm: TSgtsExecuteDefDate;
begin
  Result:=nil;
  if Iface is TSgtsJrnJournalFieldInsertIface then begin
    Result:=TSgtsJrnJournalFieldInsertIface(Iface).FDateConfirm;
  end;
  if Iface is TSgtsJrnJournalFieldUpdateIface then begin
    Result:=TSgtsJrnJournalFieldUpdateIface(Iface).FDateConfirm;
  end;
end;

procedure TSgtsJrnJournalFieldEditForm.EditWhoConfirmKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  WhoConfirm: TSgtsExecuteDefEditLink;
  DateConfirm: TSgtsExecuteDefDate;
begin
  WhoConfirm:=GetWhoConfirm;
  DateConfirm:=GetDateConfirm;
  if Assigned(WhoConfirm) and
     Assigned(DateConfirm) then begin
     if WhoConfirm.Link.Empty then begin
       DateConfirm.Value:=Null;
     end;
  end;
end;

procedure TSgtsJrnJournalFieldEditForm.ButtonWhoConfirmClick(
  Sender: TObject);
var
  WhoConfirm: TSgtsExecuteDefEditLink;
  DateConfirm: TSgtsExecuteDefDate;
begin
  WhoConfirm:=GetWhoConfirm;
  DateConfirm:=GetDateConfirm;
  if Assigned(WhoConfirm) and
     Assigned(DateConfirm) then begin
     if not WhoConfirm.Link.Empty then begin
       if DateConfirm.Empty then
         DateConfirm.Value:=Date;
     end;
  end;
end;

end.
