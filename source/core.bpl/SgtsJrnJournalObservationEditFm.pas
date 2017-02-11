unit SgtsJrnJournalObservationEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls, SgtsExecuteDefs, SgtsCoreIntf;

type
  TSgtsJrnJournalObservationEditForm = class(TSgtsDataEditForm)
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
    LabelDateObservation: TLabel;
    DateTimePickerObservation: TDateTimePicker;
  private
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsJrnJournalObservationInsertIface=class(TSgtsDataInsertIface)
  private
    FWhoEnterd: TSgtsExecuteDefEditLink;
  public
    procedure Init; override;
    procedure SetDefValues; override;

  end;

  TSgtsJrnJournalObservationUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsJrnJournalObservationDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsJrnJournalObservationEditForm: TSgtsJrnJournalObservationEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs,
     SgtsRbkCyclesFm, SgtsRbkPointsFm, SgtsRbkParamsFm, SgtsRbkPersonnelsFm,
     SgtsCoreObj, SgtsDatabaseIntf;

{$R *.dfm}

{ TSgtsJrnJournalObservationInsertIface }

procedure TSgtsJrnJournalObservationInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalObservationEditForm;
  InterfaceName:=SInterfaceJournalObservationInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertJournalObservation;
    with ExecuteDefs do begin
      AddKey('JOURNAL_OBSERVATION_ID');
      AddDate('DATE_OBSERVATION','DateTimePickerObservation','LabelDateObservation',true);
      AddEditLink('CYCLE_ID','EditCycle','LabelCycle','ButtonCycle',
                  TSgtsRbkCyclesIface,'CYCLE_NUM','CYCLE_NUM','CYCLE_ID',true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',false);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditFloat('VALUE','EditValue','LabelValue',true);
      FWhoEnterd:=AddEditLink('WHO_ENTER','EditWhoEnter','LabelWhoEnter','ButtonWhoEnter',
                              TSgtsRbkPersonnelsIface,'WHO_ENTER_NAME','PERSONNEL_NAME','PERSONNEL_ID',true);
      AddDate('DATE_ENTER','DateTimePickerEnter','LabelDateEnter',true);
    end;
  end;
end;

procedure TSgtsJrnJournalObservationInsertIface.SetDefValues;
begin
  inherited SetDefValues;
  if Assigned(Database) then begin

    FWhoEnterd.DefaultValue:=Database.PersonnelId;
    FWhoEnterd.SetDefault;

    FWhoEnterd.Link.DefaultValue:=Database.Personnel;
    FWhoEnterd.Link.SetDefault;
  end;
end;

{ TSgtsJrnJournalObservationUpdateIface }

procedure TSgtsJrnJournalObservationUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalObservationEditForm;
  InterfaceName:=SInterfaceJournalObservationUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateJournalObservation;
    with ExecuteDefs do begin
      AddKeyLink('JOURNAL_OBSERVATION_ID');
      AddDate('DATE_OBSERVATION','DateTimePickerObservation','LabelDateObservation',true);
      AddEditLink('CYCLE_ID','EditCycle','LabelCycle','ButtonCycle',
                  TSgtsRbkCyclesIface,'CYCLE_NUM','CYCLE_NUM','CYCLE_ID',true);
      AddEditLink('POINT_ID','EditPoint','LabelPoint','ButtonPoint',
                  TSgtsRbkPointsIface,'POINT_NAME','NAME','POINT_ID',false);
      AddEditLink('PARAM_ID','EditParam','LabelParam','ButtonParam',
                  TSgtsRbkParamsIface,'PARAM_NAME','NAME','PARAM_ID',true);
      AddEditFloat('VALUE','EditValue','LabelValue',true);
      AddEditLink('WHO_ENTER','EditWhoEnter','LabelWhoEnter','ButtonWhoEnter',
                  TSgtsRbkPersonnelsIface,'WHO_ENTER_NAME','PERSONNEL_NAME','PERSONNEL_ID',true);
      AddDate('DATE_ENTER','DateTimePickerEnter','LabelDateEnter',true);
    end;
  end;
end;

{ TSgtsJrnJournalObservationDeleteIface }

procedure TSgtsJrnJournalObservationDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceJournalObservationDelete;
  DeleteQuestion:='Удалить запись в журнале наблюдения?';
  with DataSet do begin
    ProviderName:=SProviderDeleteJournalObservation;
    with ExecuteDefs do begin
      AddKeyLink('JOURNAL_OBSERVATION_ID');
    end;
  end;
end;

{ TSgtsJrnJournalObservationEditForm }

constructor TSgtsJrnJournalObservationEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerObservation.Date:=Date;
  DateTimePickerEnter.Date:=Date;
end;

end.
