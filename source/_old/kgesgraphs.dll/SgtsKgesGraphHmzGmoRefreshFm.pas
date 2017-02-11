unit SgtsKgesGraphHmzGmoRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus,
  SgtsKgesGraphPeriodPointsRefreshFm, SgtsCoreIntf;

type
  TSgtsKgesGraphHmzGmoRefreshForm = class(TSgtsKgesGraphPeriodPointsRefreshForm)
  end;

  TSgtsKgesGraphHmzGmoRefreshIface=class(TSgtsKgesGraphPeriodPointsRefreshIface)
  public
    procedure Init; override;
  end;

var
  SgtsKgesGraphHmzGmoRefreshForm: TSgtsKgesGraphHmzGmoRefreshForm;

implementation

uses SgtsConsts, SgtsGraphFm, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphRefreshFm;

{$R *.dfm}

{ TSgtsKgesGraphHmzGmoRefreshIface }

procedure TSgtsKgesGraphHmzGmoRefreshIface.Init;
var
  MetrGroup: Integer;
  TemperatureGroup: Integer;
  ExpenseVolumeGroup: Integer;
begin
  inherited Init;
  FormClass:=TSgtsKgesGraphHmzGmoRefreshForm;
  Caption:='Условия графиков по Химанализу';
  GraphName:='Результаты наблюдений за химическими элементами';

  MeasureTypes.Add(2602);
  MeasureTypes.Add(2601);
  MeasureTypes.Add(2603);
  MeasureTypes.Add(2604);
  MeasureTypes.Add(2607);

  MetrGroup:=0;
  TemperatureGroup:=1;
  ExpenseVolumeGroup:=2;

  with LeftAxisParams do begin
    Add('pH','PH',-1,true);
    Add('CO2 св','CO2SV',-1,true);
    Add('CO3(-2)','CO3_2',-1,true);
    Add('CO2 агр','CO2AGG',-1,true);
    Add('Щелочность','ALKALI',-1,true);
    Add('Жесткость','ACERBITY',-1,true);
    Add('Ca(+)','CA',-1,true);
    Add('Mg(+)','MG',-1,true);
    Add('Cl(-)','CL',-1,true);
    Add('SO4(-2)','SO4_2',-1,true);
    Add('HCO3(-)','HCO3',-1,true);
    Add('Na(+)+K(+)','NA_K',-1,true);
    Add('Агрессивность','AGGRESSIV',-1,true);

    Add('Уровень верхнего бьефа','UVB',MetrGroup);
    Add('Уровень нижнего бьефа','UNB',MetrGroup);
    Add('Приращение УВБ','UVB_INC');
    Add('Температура воздуха','T_AIR',TemperatureGroup);
    Add('Температура воздуха за 10 суток','T_AIR_10',TemperatureGroup);
    Add('Температура воздуха за 30 суток','T_AIR_30',TemperatureGroup);
    Add('Температура воды в вернем бьефе','T_WATER',TemperatureGroup);
    Add('Осадков за сутки','RAIN_DAY');
    Add('Осадков с начала года','RAIN_YEAR');
    Add('Осадков за период','RAIN_PERIOD');
    Add('Сброс','UNSET',ExpenseVolumeGroup);
    Add('Приток','INFLUX',ExpenseVolumeGroup);
    Add('Объем водохранилища','V_VAULT');
  end;

  with BottomAxisParams do begin
    Add('Дата наблюдения','DATE_OBSERVATION');
    Add('Цикл','CYCLE_NUM');
    CopyFrom(LeftAxisParams,false,false);
  end;

  with RightAxisParams do begin
    CopyFrom(LeftAxisParams);
  end;
end;

{ TSgtsKgesGraphHmzGmoRefreshForm }

end.
