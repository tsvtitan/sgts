unit SgtsJrnJournalActionsFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, ImgList, ComCtrls, StdCtrls, Grids, Mask, DBCtrls,
  DBGrids, ExtCtrls, ToolWin, SgtsDataGridFm, SgtsSelectDefs, SgtsCoreIntf,
  SgtsFm;

type
  TSgtsJrnJournalActionsForm = class(TSgtsDataGridForm)
    PanelInfo: TPanel;
    GroupBoxValue: TGroupBox;
    PanelValue: TPanel;
    BevelInfo: TBevel;
    PanelFilter: TPanel;
    GroupBoxFiilter: TGroupBox;
    LabelDateFrom: TLabel;
    LabelDateTo: TLabel;
    DateTimePickerFrom: TDateTimePicker;
    DateTimePickerTo: TDateTimePicker;
    BevelFilter: TBevel;
    DBMemoValue: TDBMemo;
    procedure DateTimePickerFromChange(Sender: TObject);
  private
    procedure ApplyFilter;
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
    procedure InitByIface(AIface: TSgtsFormIface); override;
  end;

  TSgtsJrnJournalActionsIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsJrnJournalActionsForm: TSgtsJrnJournalActionsForm;

implementation

uses DBClient, DateUtils,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsConsts, SgtsDataFm, SgtsGetRecordsConfig;

{$R *.dfm}

{ TSgtsJrnJournalActionsIface }

procedure TSgtsJrnJournalActionsIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsJrnJournalActionsForm;
  InterfaceName:=SInterfaceJournalActions;
  InsertClass:=nil;
  UpdateClass:=nil;
  DeleteClass:=nil;
  with DataSet do begin
    ProviderName:=SProviderSelectJournalActions;
    with SelectDefs do begin
      AddKey('JOURNAL_ACTION_ID');
      Add('DATE_ACTION','Дата и время',70);
      Add('PERSONNEL_NAME','Персона',150);
      Add('OBJECT','Объект',100);
      Add('METHOD','Метод',100);
      Add('PARAM','Параметр',100);
      AddInvisible('PERSONNEL_ID');
      AddInvisible('VALUE');
    end;
  end;
  Permissions.AddDefault(SPermissionNameConfirm);
end;

{ TSgtsJrnJournalActionsForm }

constructor TSgtsJrnJournalActionsForm.Create(ACoreIntf: ISgtsCore);
var
  StartDate: TDate;
begin
  inherited Create(ACoreIntf);
  StartDate:=EncodeDate(YearOf(Date),MonthOf(Date),1);
  DateTimePickerFrom.Date:=StartDate;
  DateTimePickerTo.Date:=DateOf(Date);
end;

procedure TSgtsJrnJournalActionsForm.InitByIface(AIface: TSgtsFormIface);
begin
  inherited InitByIface(AIface);
end;

procedure TSgtsJrnJournalActionsForm.DateTimePickerFromChange(
  Sender: TObject);
begin
  ApplyFilter;
end;

procedure TSgtsJrnJournalActionsForm.ApplyFilter;
var
  FilterGroup: TSgtsGetRecordsConfigFilterGroup;
begin
  Iface.DataSet.FilterGroups.Clear;
  FilterGroup:=Iface.DataSet.FilterGroups.Add;
  FilterGroup.Filters.Add('DATE_ACTION',fcEqualGreater,DateOf(DateTimePickerFrom.Date));
  FilterGroup.Filters.Add('DATE_ACTION',fcEqualLess,DateOf(DateTimePickerTo.Date));
  Iface.Refresh;
end;

end.
