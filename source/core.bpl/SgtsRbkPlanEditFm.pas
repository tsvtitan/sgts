unit SgtsRbkPlanEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsCoreIntf, SgtsControls;

type
  TSgtsRbkPlanEditForm = class(TSgtsDataEditForm)
    LabelCycle: TLabel;
    EditCycle: TEdit;
    ButtonCycle: TButton;
    LabelMeasureType: TLabel;
    EditMeasureType: TEdit;
    ButtonMeasureType: TButton;
    LabelDateBegin: TLabel;
    LabelDateEnd: TLabel;
    DateTimePickerBegin: TDateTimePicker;
    DateTimePickerEnd: TDateTimePicker;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkPlanInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPlanUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
  end;

  TSgtsRbkPlanDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
  end;

var
  SgtsRbkPlanEditForm: TSgtsRbkPlanEditForm;

implementation

uses DBClient, DateUtils,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkMeasureTypesFm, SgtsRbkCyclesFm;

{$R *.dfm}

{ TSgtsRbkPlanInsertIface }

procedure TSgtsRbkPlanInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPlanEditForm;
  InterfaceName:=SInterfacePlanInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertPlan;
    with ExecuteDefs do begin
      AddEditLink('CYCLE_ID','EditCycle','LabelCycle','ButtonCycle',
                  TSgtsRbkCyclesIface,'CYCLE_NUM','','',true);
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','',true);
      AddDate('DATE_BEGIN','DateTimePickerBegin','LabelDateBegin',true);
      AddDate('DATE_END','DateTimePickerEnd','LabelDateEnd',false);
    end;
  end;
end;

{ TSgtsRbkPlanUpdateIface }

procedure TSgtsRbkPlanUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkPlanEditForm;
  InterfaceName:=SInterfacePlanUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdatePlan;
    with ExecuteDefs do begin
      AddEditLink('CYCLE_ID','EditCycle','LabelCycle','ButtonCycle',
                  TSgtsRbkCyclesIface,'CYCLE_NUM','','',true,true);
      AddEditLink('MEASURE_TYPE_ID','EditMeasureType','LabelMeasureType','ButtonMeasureType',
                  TSgtsRbkMeasureTypesIface,'MEASURE_TYPE_NAME','NAME','',true,true);
      AddDate('DATE_BEGIN','DateTimePickerBegin','LabelDateBegin',true);
      AddDate('DATE_END','DateTimePickerEnd','LabelDateEnd',false);
    end;
  end;
end;

{ TSgtsRbkPlanDeleteIface }

procedure TSgtsRbkPlanDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfacePlanDelete;
  DeleteQuestion:='Удалить план на цикл: %CYCLE_NUM и вид измерения: %MEASURE_TYPE_NAME?';
  with DataSet do begin
    ProviderName:=SProviderDeletePlan;
    with ExecuteDefs do begin
      AddKeyLink('CYCLE_ID');
      AddKeyLink('MEASURE_TYPE_ID');
      AddInvisible('CYCLE_NUM');
      AddInvisible('MEASURE_TYPE_NAME');
    end;
  end;
end;

{ TSgtsRbkPlanEditForm }

constructor TSgtsRbkPlanEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  DateTimePickerBegin.Date:=DateOf(Now);
end;

end.
