unit SgtsGrpJournalRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls,
  CheckLst, ExtCtrls, DBGrids, DB,
  SgtsFm, SgtsDbGrid, SgtsDatabaseCDS,
  SgtsCoreIntf,
  SgtsBaseGraphRefreshFm, SgtsBaseGraphFm;

type

  TSgtsGrpJournalRefreshForm = class(TSgtsBaseGraphRefreshForm)
    PanelFilter: TPanel;
    GroupBoxFilter: TGroupBox;
    PanelMemoFilters: TPanel;
    MemoFilters: TMemo;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSgtsGrpJournalRefreshIface=class(TSgtsBaseGraphRefreshIface)
  private
    function GetForm: TSgtsGrpJournalRefreshForm;
  protected
    procedure AfterCreateForm(AForm: TSgtsForm); override;
  public
    procedure Init; override;

    property Form: TSgtsGrpJournalRefreshForm read GetForm;
  end;


var
  SgtsGrpJournalRefreshForm: TSgtsGrpJournalRefreshForm;

implementation

uses DBClient,
     SgtsIface, SgtsGraphFm, SgtsGetRecordsConfig, SgtsConsts, SgtsObj,
     SgtsUtils, SgtsGrpJournalFm;

{$R *.dfm}

{ TSgtsGrpJournalRefreshIface }

function TSgtsGrpJournalRefreshIface.GetForm: TSgtsGrpJournalRefreshForm;
begin
  Result:=TSgtsGrpJournalRefreshForm(inherited Form);
end;

procedure TSgtsGrpJournalRefreshIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsGrpJournalRefreshForm;
  if Assigned(ParentIface) then begin
    SectionName:=Name+InttoStr(TSgtsGrpJournalIface(ParentIface).CutId);
    LeftAxisParams.FalseUseFilter;
    DefaultLeftAxisParams.FalseUseFilter;
    RightAxisParams.FalseUseFilter;
    DefaultRightAxisParams.FalseUseFilter;
    BottomAxisParams.FalseUseFilter;
    DefaultBottomAxisParams.FalseUseFilter;
  end;
end;

procedure TSgtsGrpJournalRefreshIface.AfterCreateForm(AForm: TSgtsForm);
begin
  inherited AfterCreateForm(AForm);
  if Assigned(Form) and
     Assigned(ParentIface) then begin
    Form.MemoFilters.Lines.Text:=TSgtsGrpJournalIface(ParentIface).DefaultDataSet.FilterGroups.GetUserFilter;
  end;
end;

{ TSgtsGrpJournalRefreshForm }

procedure TSgtsGrpJournalRefreshForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if CanClose then begin
    Iface.BeforeWriteParams;
    Iface.WriteParams;
  end;
end;

end.
