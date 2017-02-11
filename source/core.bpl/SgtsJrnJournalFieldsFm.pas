unit SgtsJrnJournalFieldsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ComCtrls, StdCtrls, Grids, Mask, DBCtrls,
  DBGrids, ExtCtrls, ToolWin, SgtsDataGridFm, SgtsSelectDefs, SgtsCoreIntf,
  SgtsFm;

type
  TSgtsJrnJournalFieldsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxInfo: TGroupBox;
    PanelNote: TPanel;
    LabelWhoEnter: TLabel;
    LabelDateEnter: TLabel;
    DBEditWhoEnter: TDBEdit;
    DBEditDateEnter: TDBEdit;
    LabelWhoConfirm: TLabel;
    DBEditWhoConfirm: TDBEdit;
    LabelDateConfirm: TLabel;
    DBEditDateConfirm: TDBEdit;
    BevelInfo: TBevel;
    PanelFilter: TPanel;
    GroupBoxFiilter: TGroupBox;
    LabelDateFrom: TLabel;
    LabelDateTo: TLabel;
    DateTimePickerFrom: TDateTimePicker;
    DateTimePickerTo: TDateTimePicker;
    BevelFilter: TBevel;
    procedure DateTimePickerFromChange(Sender: TObject);
  private
    procedure ApplyFilter;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
  end;

  TSgtsJrnJournalFieldsIface=class(TSgtsDataGridIface)
  private
    function GetConfirmProc(Def: TSgtsSelectDef): Variant;
    function GetForm: TSgtsJrnJournalFieldsForm;
  public
    procedure Init; override;
    procedure Refresh; override;

    property Form: TSgtsJrnJournalFieldsForm read GetForm;
  end;

var
  SgtsJrnJournalFieldsForm: TSgtsJrnJournalFieldsForm;

implementation

uses DBClient, DateUtils,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsConsts, SgtsJrnJournalFieldEditFm, SgtsDataFm, SgtsGetRecordsConfig;

{$R *.dfm}

{ TSgtsJrnJournalFieldsIface }

procedure TSgtsJrnJournalFieldsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalFieldsForm ;
  InterfaceName:=SInterfaceJournalFields;
  InsertClass:=TSgtsJrnJournalFieldInsertIface;
  UpdateClass:=TSgtsJrnJournalFieldUpdateIface;
  DeleteClass:=TSgtsJrnJournalFieldDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectJournalFields;
    with SelectDefs do begin
      AddKey('JOURNAL_FIELD_ID');
      Add('DATE_OBSERVATION','Дата наблюдения',80);
      Add('CYCLE_NUM','Цикл',50);
      Add('MEASURE_TYPE_NAME','Вид измерения',100);
      Add('POINT_NAME','Изм. точка',120);
      Add('INSTRUMENT_NAME','Прибор',100);
      Add('MEASURE_UNIT_NAME','Единица измерения',30);
      Add('PARAM_NAME','Параметр',150);
      Add('VALUE','Значение',80);
      AddCalcInvisible('IS_CONFIRM',GetConfirmProc,ftInteger);
      AddDrawCheck('IS_CONFIRM_EX','Утверждено','IS_CONFIRM',50,false);
      AddInvisible('CYCLE_ID');
      AddInvisible('POINT_ID');
      AddInvisible('PARAM_ID');
      AddInvisible('INSTRUMENT_ID');
      AddInvisible('MEASURE_UNIT_ID');
      AddInvisible('WHO_ENTER');
      AddInvisible('WHO_ENTER_NAME');
      AddInvisible('DATE_ENTER');
      AddInvisible('WHO_CONFIRM');
      AddInvisible('WHO_CONFIRM_NAME');
      AddInvisible('DATE_CONFIRM');
      AddInvisible('GROUP_ID');
      AddInvisible('PRIORITY');
      AddInvisible('IS_BASE');
      AddInvisible('MEASURE_TYPE_ID');
      AddInvisible('JOURNAL_NUM');
      AddInvisible('NOTE');
      AddInvisible('IS_CHECK');
    end;
  end;
  Permissions.AddDefault(SPermissionNameConfirm);
end;

function TSgtsJrnJournalFieldsIface.GetConfirmProc(Def: TSgtsSelectDef): Variant;
var
  Field: TField;
begin
  Result:=0;
  Field:=DataSet.FindField('WHO_CONFIRM');
  if Assigned(Field) and not VarIsNull(Field.Value) then
    Result:=1;
end;

function TSgtsJrnJournalFieldsIface.GetForm: TSgtsJrnJournalFieldsForm;
begin
  Result:=TSgtsJrnJournalFieldsForm(inherited Form);
end;

procedure TSgtsJrnJournalFieldsIface.Refresh;
begin
  if CanRefresh then begin
    inherited Refresh;
  end;
end;

{ TSgtsJrnJournalFieldsForm }

constructor TSgtsJrnJournalFieldsForm.Create(ACoreIntf: ISgtsCore);
var
  StartDate: TDate;
begin
  inherited Create(ACoreIntf);
  StartDate:=EncodeDate(YearOf(Date),MonthOf(Date),1);
  DateTimePickerFrom.Date:=StartDate;
  DateTimePickerTo.Date:=DateOf(Date);
end;

procedure TSgtsJrnJournalFieldsForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
  ApplyFilter;
end;

procedure TSgtsJrnJournalFieldsForm.DateTimePickerFromChange(
  Sender: TObject);
begin
  ApplyFilter;
  Iface.Refresh;
end;

procedure TSgtsJrnJournalFieldsForm.ApplyFilter;
var
  FilterGroup: TSgtsGetRecordsConfigFilterGroup;
begin
  Iface.DataSet.FilterGroups.Clear;
  FilterGroup:=Iface.DataSet.FilterGroups.Add;
  FilterGroup.Filters.Add('DATE_OBSERVATION',fcEqualGreater,DateOf(DateTimePickerFrom.Date));
  FilterGroup.Filters.Add('DATE_OBSERVATION',fcEqualLess,DateOf(DateTimePickerTo.Date));
end;

end.
