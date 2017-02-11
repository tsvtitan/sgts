unit SgtsKgesGraphPzmGmoRefreshFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, CheckLst, Menus,
  SgtsKgesGraphPeriodPointsRefreshFm, SgtsCoreIntf;

type
  TSgtsKgesGraphPzmGmoRefreshForm = class(TSgtsKgesGraphPeriodPointsRefreshForm)
  end;

  TSgtsKgesGraphPzmGmoRefreshIface=class(TSgtsKgesGraphPeriodPointsRefreshIface)
  public
    procedure Init; override;
  end;

var
  SgtsKgesGraphPzmGmoRefreshForm: TSgtsKgesGraphPzmGmoRefreshForm;

implementation

uses SgtsConsts, SgtsGraphFm, SgtsKgesGraphsConsts, SgtsProviderConsts,
     SgtsKgesGraphRefreshFm;

{$R *.dfm}

{ TSgtsKgesGraphPzmGmoRefreshIface }

procedure TSgtsKgesGraphPzmGmoRefreshIface.Init;
var
  MetrGroup: Integer;
  TemperatureGroup: Integer;
  ExpenseVolumeGroup: Integer;
  Pressure: Integer;
begin
  inherited Init;
  FormClass:=TSgtsKgesGraphPzmGmoRefreshForm;
  Caption:='Условия графиков по Пьезометрам';
  GraphName:='Результаты наблюдений за пьезометрами';

  MeasureTypes.Add(2561);
  MeasureTypes.Add(2562);
  MeasureTypes.Add(2563);

  MetrGroup:=0;
  TemperatureGroup:=1;
  ExpenseVolumeGroup:=2;
  Pressure:=3;

  with LeftAxisParams do begin
    Add('Отметка уровня воды в пьезометре','MARK_WATER',-1,true);
    Add('Действующий напор','PRESSURE_ACTIVE',Pressure,true);
    Add('Фильтрационное противодавление','PRESSURE_OPPOSE',Pressure,true);
    Add('Приведенный напор','PRESSURE_BROUGHT',-1,true);
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
    Add('Цикл','CYCLE_NUM');
    CopyFrom(LeftAxisParams,false,false);
  end;

  with RightAxisParams do begin
    CopyFrom(LeftAxisParams);
  end;
end;

{ TSgtsKgesGraphPzmGmoRefreshForm }

end.
