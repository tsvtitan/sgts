unit SgtsKgesGraphGmoRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus,
  SgtsKgesGraphPeriodRefreshFm, SgtsCoreIntf;

type
  TSgtsKgesGraphGmoRefreshForm = class(TSgtsKgesGraphPeriodRefreshForm)
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsKgesGraphGmoRefreshIface=class(TSgtsKgesGraphPeriodRefreshIface)
  public
    procedure Init; override;
  end;

var
  SgtsKgesGraphGmoRefreshForm: TSgtsKgesGraphGmoRefreshForm;

implementation

uses SgtsConsts, SgtsGraphFm, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphRefreshFm;

{$R *.dfm}

{ TSgtsKgesGraphGmoRefreshIface }

procedure TSgtsKgesGraphGmoRefreshIface.Init;
var
  MetrGroup: Integer;
  TemperatureGroup: Integer;
  ExpenseVolumeGroup: Integer;
begin
  inherited Init;
  FormClass:=TSgtsKgesGraphGmoRefreshForm;
  Caption:='Условия графиков по Гидрометеорологии';
  GraphName:='Гидрометеорологические данные по Красноярской ГЭС';

  MetrGroup:=0;
  TemperatureGroup:=1;
  ExpenseVolumeGroup:=2;

  with LeftAxisParams do begin
    Add('Уровень верхнего бьефа','UVB',MetrGroup);
    Add('Уровень нижнего бьефа','UNB',MetrGroup);
    Add('Приращение УВБ','UVB_INC');
    Add('Температура воздуха','T_AIR',TemperatureGroup);
    Add('Температура воздуха за 10 суток','T_AIR_10',TemperatureGroup);
    Add('Температура воздуха за 30 суток','T_AIR_30',TemperatureGroup);
    Add('Температура воды','T_WATER',TemperatureGroup);
    Add('Осадков за сутки','RAIN_DAY');
    Add('Осадков с начала года','RAIN_YEAR');
    Add('Осадков за период','RAIN_PERIOD');
    Add('Сброс','UNSET',ExpenseVolumeGroup);
    Add('Приток','INFLUX',ExpenseVolumeGroup);
    Add('Объем водохранилища','V_VAULT');
  end;

  with BottomAxisParams do begin
    Add('Дата наблюдения','DATE_OBSERVATION');
    Add('Цикл','CYCLE_NUM').XMerging:=false;
    CopyFrom(LeftAxisParams,false,false);
  end;

  RightAxisParams.CopyFrom(LeftAxisParams);
end;

{ TSgtsKgesGraphGmoRefreshForm }

constructor TSgtsKgesGraphGmoRefreshForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);

end;

end.
