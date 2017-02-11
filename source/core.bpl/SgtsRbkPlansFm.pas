unit SgtsRbkPlansFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, DB,
  StdCtrls, Mask, DBCtrls,
  SgtsDataGridFm, SgtsDataFm, SgtsFm,
  SgtsCoreIntf;

type
  TSgtsRbkPlansForm = class(TSgtsDataGridForm)
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPlansIface=class(TSgtsDataGridIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPlansForm: TSgtsRbkPlansForm;

implementation

uses DBClient,
     SgtsDbGrid, SgtsCDS, SgtsProviderConsts, SgtsDatabaseCDS,
     SgtsSelectDefs, SgtsRbkPlanEditFm, SgtsConsts;

{$R *.dfm}

{ TSgtsRbkPlansIface }

procedure TSgtsRbkPlansIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPlansForm;
  InterfaceName:=SInterfacePlans;
  InsertClass:=TSgtsRbkPlanInsertIface;
  UpdateClass:=TSgtsRbkPlanUpdateIface;
  DeleteClass:=TSgtsRbkPlanDeleteIface;
  with DataSet do begin
    ProviderName:=SProviderSelectPlans;
    with SelectDefs do begin
      Add('CYCLE_NUM','Номер цикла',70);
      Add('MEASURE_TYPE_NAME','Вид измерения',150);
      Add('DATE_BEGIN','Дата начала',70);
      Add('DATE_END','Дата окончания',70);
      AddInvisible('CYCLE_ID');
      AddInvisible('MEASURE_TYPE_ID');
    end;
  end;
end;

{ TSgtsRbkPlansForm }

constructor TSgtsRbkPlansForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
end;


end.
